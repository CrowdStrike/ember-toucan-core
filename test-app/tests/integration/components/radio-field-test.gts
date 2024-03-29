/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { click, find, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import RadioField from '@crowdstrike/ember-toucan-core/components/form/fields/radio';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Fields | Radio', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @rootTestSelector="test"
        @name="name"
        data-radio
      />
    </template>);

    assert.dom('[data-label]').hasText('Label');
    assert.dom('[data-label]').hasClass('text-titles-and-attributes');

    assert
      .dom('[data-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided'
      );

    assert.dom('[data-radio]').hasTagName('input');
    assert.dom('[data-radio]').hasAttribute('id');
    assert.dom('[data-radio]').hasNoAttribute('aria-invalid');
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @hint="Hint text"
        @name="name"
        data-radio
      />
    </template>);

    assert.dom('[data-hint]').hasText('Hint text');
  });

  test('it renders with a hint and label block', async function (assert) {
    await render(<template>
      <RadioField @value="option" @name="name" data-radio>
        <:label><span data-label>label block content</span></:label>
        <:hint><span data-hint>hint block content</span></:hint>
      </RadioField>
    </template>);

    assert.dom('[data-hint]').hasText('hint block content');
    assert.dom('[data-label]').hasText('label block content');
  });

  test('it sets the "for" attribute on the label to the "id" attribute of the radio', async function (assert) {
    await render(<template>
      <RadioField @value="option" @label="Label" @name="name" data-radio />
    </template>);

    let labelFor = find('[data-control] > label')?.getAttribute('for') || '';

    assert.ok(labelFor, 'Expected the id attribute of the label to be truthy');

    assert
      .dom('[data-radio]')
      .hasAttribute(
        'id',
        labelFor,
        'Expected the for attribute on the label to match the id attribute on the radio'
      );
  });

  test('it disables the radio using `@isDisabled`', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @isDisabled={{true}}
        @name="name"
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').isDisabled();

    assert.dom('[data-label]').hasClass('text-disabled');
  });

  test('it sets readonly on the radio using `@isReadOnly`', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @name="name"
        @label="Label"
        @isReadOnly={{true}}
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').hasAttribute('readonly');
  });

  test('it spreads attributes to the underlying radio', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        data-test-selector="test"
        @name="name"
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').hasAttribute('data-test-selector', 'test');
  });

  test('it sets the checked-state when `@selectedValue` and `@value` are equal', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @selectedValue="option"
        @name="name"
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').isChecked();
  });

  test('it does not set the checked-state when `@selectedValue` and `@value` are different', async function (assert) {
    await render(<template>
      <RadioField
        @value="not-the-same-as-selected-value"
        @label="Label"
        @selectedValue="selected-value"
        @name="name"
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').isNotChecked();
  });

  test('it sets the radio name attribute via `@name`', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @name="radio-name"
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').hasAttribute('name', 'radio-name');
  });

  test('it calls `@onChange` when clicked with the expected checked state', async function (assert) {
    assert.expect(7);

    let handleChange = (value: string, e: Event | InputEvent) => {
      assert.strictEqual(value, 'option', 'Expected value to matched');
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.step('handleChange');
    };

    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @onChange={{handleChange}}
        @name="name"
        data-radio
      />
    </template>);

    assert.verifySteps([]);

    await click('[data-radio]');

    assert.verifySteps(['handleChange']);

    assert.dom('[data-radio]').isChecked();
  });

  test('it applies the provided `@rootTestSelector` to the data-root-field attribute', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @rootTestSelector="selector"
        @name="name"
        data-radio
      />
    </template>);

    assert.dom('[data-root-field="selector"]').exists();
  });

  test('it throws an assertion error if no `@label` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes(
          'Assertion Failed: You need either :label or @label'
        ),
        'Expected assertion error message'
      );
    });

    await render(<template>
      <RadioField @value="option" @name="name" />
    </template>);
  });

  test('it throws an assertion error if both `@label` and `:label` are provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes(
          'Assertion Failed: You can have :label or @label, but not both'
        ),
        'Expected assertion error message'
      );
    });

    await render(<template>
      <RadioField @label="Label" @value="option" @name="name">
        <:label>Hello there</:label>
      </RadioField>
    </template>);
  });

  test('it throws an assertion error if no `@value` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('A "@value" argument is required'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      {{! @glint-expect-error: we are not providing @value, so this is expected }}
      <RadioField @label="Label" @name="name" />
    </template>);
  });

  test('it throws an assertion error if no `@name` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('A "@name" argument is required'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      {{! @glint-expect-error: we are not providing @name, so this is expected }}
      <RadioField @label="Label" @value="value" />
    </template>);
  });
});
