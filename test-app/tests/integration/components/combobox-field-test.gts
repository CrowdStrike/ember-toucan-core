import { click, fillIn, find, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import ComboboxField from '@crowdstrike/ember-toucan-core/components/form/fields/combobox';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Fields | Combobox', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <ComboboxField @label="Label" data-combobox />
    </template>);

    assert.dom('[data-label]').hasText('Label');

    assert
      .dom('[data-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided'
      );

    assert.dom('[data-combobox]').hasTagName('input');
    assert.dom('[data-combobox]').hasAttribute('id');
    assert.dom('[data-combobox]').hasClass('text-titles-and-attributes');

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected hint block not to be displayed as an error was not provided'
      );

    assert.dom('[data-lock-icon]').doesNotExist();
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <ComboboxField @label="Label" @hint="Hint text" data-combobox />
    </template>);

    let hint = find('[data-hint]');

    assert.dom(hint).hasText('Hint text');
    assert.dom(hint).hasAttribute('id');

    let hintId = hint?.getAttribute('id') || '';

    assert.ok(hintId, 'Expected hintId to be truthy');

    let describedby =
      find('[data-combobox]')?.getAttribute('aria-describedby') || '';

    assert.ok(
      describedby.includes(hintId),
      'Expected hintId to be included in the aria-describedby'
    );
  });

  test('it renders with a hint and label block', async function (assert) {
    await render(<template>
      <ComboboxField data-combobox>
        <:label><span data-label>label block content</span></:label>
        <:hint><span data-hint>hint block content</span></:hint>
      </ComboboxField>
    </template>);

    assert.dom('[data-hint]').hasText('hint block content');
    assert.dom('[data-label]').hasText('label block content');
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <ComboboxField @label="Label" @error="Error text" data-combobox />
    </template>);

    let error = find('[data-error]');

    assert.dom(error).hasText('Error text');
    assert.dom(error).hasAttribute('id');

    let errorId = error?.getAttribute('id') || '';

    assert.ok(errorId, 'Expected errorId to be truthy');

    let describedby =
      find('[data-combobox]')?.getAttribute('aria-describedby') || '';

    assert.ok(
      describedby.includes(errorId),
      'Expected errorId to be included in the aria-describedby'
    );

    assert.dom('[data-combobox]').hasAttribute('aria-invalid', 'true');

    assert.dom('[data-combobox]').hasClass('shadow-error-outline');
    assert.dom('[data-combobox]').hasClass('focus:shadow-error-focus-outline');
    assert.dom('[data-combobox]').doesNotHaveClass('shadow-focusable-outline');
  });

  test('it sets aria-describedby when both a hint and error are provided using the hint and errorIds', async function (assert) {
    await render(<template>
      <ComboboxField
        @label="Label"
        @error="Error text"
        @hint="Hint text"
        data-combobox
      />
    </template>);

    let errorId = find('[data-error]')?.getAttribute('id') || '';

    assert.ok(errorId, 'Expected errorId to be truthy');

    let hintId = find('[data-hint]')?.getAttribute('id') || '';

    assert.ok(hintId, 'Expected hintId to be truthy');

    assert
      .dom('[data-combobox]')
      .hasAttribute('aria-describedby', `${errorId} ${hintId}`);
  });

  test('it disables the textarea using `@isDisabled` and renders a lock icon', async function (assert) {
    await render(<template>
      <ComboboxField @label="Label" @isDisabled={{true}} data-combobox />
    </template>);

    assert.dom('[data-combobox]').isDisabled();
    assert.dom('[data-combobox]').hasClass('text-disabled');

    assert.dom('[data-lock-icon]').exists();
  });

  test('it sets readonly on the textarea using `@isReadOnly` and renders a lock icon', async function (assert) {
    await render(<template>
      <ComboboxField @label="Label" @isReadOnly={{true}} data-combobox />
    </template>);

    assert.dom('[data-combobox]').hasAttribute('readonly');

    assert.dom('[data-lock-icon]').exists();
  });

  test('it spreads attributes to the underlying textarea', async function (assert) {
    await render(<template>
      <ComboboxField
        @label="Label"
        placeholder="Placeholder text"
        data-combobox
      />
    </template>);

    assert
      .dom('[data-combobox]')
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it sets the value attribute via `@selected`', async function (assert) {
    await render(<template>
      <ComboboxField @label="Label" @selected="blue" data-combobox />
    </template>);

    assert.dom('[data-combobox]').hasValue('blue');
  });

  // NOTE: This functionality is deeply tested in the Control, as it can
  // get pretty complex.  This test is to ensure `@onChange` is generally
  // working.
  test('it calls `@onChange` when an option is selected', async function (assert) {
    assert.expect(5);

    let options = ['blue', 'red'];

    let handleChange = (value: unknown) => {
      assert.strictEqual(value, 'blue', 'Expected input to match');
      assert.step('handleChange');
    };

    await render(<template>
      <ComboboxField
        @label="Label"
        @options={{options}}
        @onChange={{handleChange}}
        data-combobox
        as |combobox|
      >
        {{! Need to figure out these types }}
        {{! @glint-expect-error }}
        <combobox.Option data-option>{{combobox.option}}</combobox.Option>
      </ComboboxField>
    </template>);

    assert.verifySteps([]);

    await fillIn('[data-combobox]', 'blue');

    assert.dom('[role="option"]').exists({ count: 1 });

    await click('[role="option"]');

    assert.verifySteps(['handleChange']);
  });

  test('it applies the provided `@rootTestSelector` to the data-root-field attribute', async function (assert) {
    await render(<template>
      <ComboboxField
        @label="Label"
        @rootTestSelector="selector"
        data-combobox
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

    await render(<template><ComboboxField /></template>);
  });

  test('it throws an assertion error if a `@label` and :label are provided', async function (assert) {
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
      <ComboboxField @label="Label">
        <:label>Label</:label>
      </ComboboxField>
    </template>);
  });
});
