/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { fillIn, find, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import InputField from '@crowdstrike/ember-toucan-core/components/form/fields/input';
import { action } from '@ember/object';

import { tracked } from '@glimmer/tracking';

import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Fields | Input', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <InputField @label="Label" type="text" data-input />
    </template>);

    const label = '[data-label]';
    const input = '[data-input]';
    const inputId = find(input)?.getAttribute('id') || '';

    assert.ok(inputId, 'Expected to have id');
    assert.dom(label).exists('Expected to have label block rendered');
    assert.dom(label).hasText('Label', 'Expected to have label text "label"');
    assert.dom(label).hasAttribute('for', inputId);
    assert.dom(input).exists('Expected to have input tag rendered');
    assert.dom(input).hasAttribute('type', 'text');
    assert.dom(input).hasAttribute('id');
    assert.dom(input).hasNoClass('shadow-error-outline');
  });

  test('it throws an assertion error if no `@label` or `:label` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.strictEqual(
        e.message,
        'Assertion Failed: You need either :label or @label',
        'Expected assertion error message'
      );
    });
    await render(<template><InputField type="text" /></template>);
  });

  test('it throws an assertion error if both `@label` and `:label` are provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.strictEqual(
        e.message,
        'Assertion Failed: You can have :label or @label, but not both',
        'Expected assertion error message'
      );
    });
    await render(<template>
      <InputField @label="Label" type="text">
        <:label>Hello</:label>
      </InputField>
    </template>);
  });

  test('it renders an error', async function (assert) {
    await render(<template>
      <InputField
        @label="Label"
        type="text"
        @error="There is an error"
        data-input
      />
    </template>);

    const input = '[data-input]';
    const error = '[data-error]';

    assert.dom(error).exists('Expected to have error component rendered');
    assert
      .dom(error)
      .hasText('There is an error', 'Expected to have error text "error"');
    assert.dom(error).hasAttribute('id');

    const errorId = find(error)?.getAttribute('id') || '';
    const describedby = find(input)?.getAttribute('aria-describedby') || '';

    assert.ok(
      describedby.includes(errorId),
      'Expected errorId to be included in the aria-describedby'
    );
    assert.dom(input).hasAttribute('aria-invalid', 'true');

    assert.dom(input).hasClass('shadow-error-outline');
    assert.dom(input).hasClass('focus:shadow-error-focus-outline');
  });

  test('it renders hint text', async function (assert) {
    await render(<template>
      <InputField
        @label="Label"
        type="text"
        @hint="Hint text visible here"
        data-input
      />
    </template>);

    const label = '[data-label]';
    const input = '[data-input]';
    const hint = '[data-hint]';

    assert.dom(label).exists('Expected to have label component rendered');
    assert.dom(label).hasText('Label', 'Expected to have label text "label"');

    assert.dom(input).exists('Expected to have input tag rendered');
    assert.dom(input).hasAttribute('type', 'text');

    assert.dom(hint).exists('Expected to have hint component rendered');
    assert
      .dom(hint)
      .hasText('Hint text visible here', 'Expected to have hint text "error"');
    assert.dom(hint).hasAttribute('id');
    const hintId = find(hint)?.getAttribute('id') || '';
    const describedby = find(input)?.getAttribute('aria-describedby') || '';

    assert.ok(
      describedby.includes(hintId),
      'Expected hintId to be included in the aria-describedby'
    );
  });

  test('it renders a hint and label block', async function (assert) {
    await render(<template>
      <InputField type="text" data-input>
        <:label><span data-label>label block content</span></:label>
        <:hint><span data-hint>hint block content</span></:hint>
      </InputField>
    </template>);

    assert.dom('[data-label]').hasText('label block content');
    assert.dom('[data-hint]').hasText('hint block content');
  });

  test('it sets aria-describedby when both a hint and error are provided using the hint and error ids', async function (assert) {
    await render(<template>
      <InputField
        @label="Label"
        type="text"
        @hint="Hint text visible here"
        @error="Error text"
        data-input
      />
    </template>);

    const errorId = find('[data-error]')?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected errorId to be truthy');

    const hintId = find('[data-hint]')?.getAttribute('id') || '';
    assert.ok(hintId, 'Expected hintId to be truthy');

    assert
      .dom('[data-input]')
      .hasAttribute('aria-describedby', `${hintId} ${errorId}`);
  });

  test('it accepts @value and @onChange', async function (assert) {
    assert.expect(8);

    const onChangeCallback = (value: string, e: Event | InputEvent) => {
      assert.strictEqual(value, 'Banana', 'Expected input to match');
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.step('handleChange');
    };

    await render(<template>
      <InputField
        @label="Label"
        type="text"
        @value="Avocado"
        @onChange={{onChangeCallback}}
        data-input
      />
    </template>);

    assert.verifySteps([]);

    assert
      .dom('[data-input]')
      .hasValue('Avocado', 'input has the original value');

    await fillIn('[data-input]', 'Banana');

    assert.dom('[data-input]').hasValue('Banana', 'input has the set @value');

    assert.verifySteps(['handleChange']);
  });

  test('it applies the provided `@rootTestSelector` to the data-root-field attribute', async function (assert) {
    await render(<template>
      <InputField @label="Label" @rootTestSelector="selector" data-input />
    </template>);
    assert.dom('[data-root-field="selector"]').exists();
  });

  test('it renders a `<:secondaryInformation>` block that tracks the input value length', async function (assert) {
    class Context {
      @tracked count = 0;

      @action
      handleChange(value: string) {
        this.count = value.length;
      }
    }

    let ctx = new Context();

    await render(<template>
      <InputField @label="Label" @value="Hello" @onChange={{ctx.handleChange}} data-input>
        <:secondaryInformation as |secondary|>
          <secondary.CharacterCount @max={{255}} data-character />
        </:secondaryInformation>
      </InputField>
    </template>);

    assert.dom('[data-character]').hasText('5 / 255');

    await fillIn('[data-input]', 'Hello Hello');

    assert.dom('[data-character]').hasText('11 / 255');
  });
});
