/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */

import { click, find, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import CheckboxField from '@crowdstrike/ember-toucan-core/components/form/fields/checkbox';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Fields | CheckboxField', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" @rootTestSelector="test" data-checkbox />
    </template>);

    assert.dom('[data-label]').hasText('Label');
    assert.dom('[data-label]').hasClass('text-titles-and-attributes');

    assert
      .dom('[data-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided'
      );

    assert.dom('[data-checkbox]').hasTagName('input');
    assert.dom('[data-checkbox]').hasAttribute('id');
    assert.dom('[data-checkbox]').hasNoAttribute('aria-invalid');

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected error block not to be displayed as an error was not provided'
      );
    assert
      .dom('[data-root-field="test"] > [data-control]')
      .hasNoClass('shadow-error-outline');

    assert.dom('[data-lock-icon]').doesNotExist();
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" @hint="Hint text" data-checkbox />
    </template>);

    assert.dom('[data-hint]').hasText('Hint text');
  });

  test('it renders with a hint and label block', async function (assert) {
    await render(<template>
      <CheckboxField data-checkbox>
        <:label>label block content</:label>
        <:hint>hint block content</:hint>
      </CheckboxField>
    </template>);

    assert.dom('[data-hint]').hasText('hint block content');
    assert.dom('[data-label]').hasText('label block content');
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <CheckboxField
        @label="Label"
        @error="Error text"
        @rootTestSelector="test"
        data-checkbox
      />
    </template>);

    let error = find('[data-error]');

    assert.dom(error).hasText('Error text');
    assert.dom(error).hasAttribute('id');

    let errorId = error?.getAttribute('id') || '';

    assert.ok(errorId, 'Expected errorId to be truthy');

    // For the checkbox-field component, the only aria-describedby
    // value should be the errorId.  This is due to the way the component
    // is structured, where the label+hint are rendered inside of the
    // wrapping <label> element
    let describedby =
      find('[data-checkbox]')?.getAttribute('aria-describedby') || '';

    assert.ok(
      describedby.includes(errorId),
      'Expected errorId to be included in the aria-describedby'
    );

    assert.dom('[data-checkbox]').hasAttribute('aria-invalid', 'true');

    assert
      .dom('[data-root-field="test"] > [data-control]')
      .hasClass('shadow-error-outline');
  });

  test('it sets the "for" attribute on the label to the "id" attribute of the checkbox', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" data-checkbox />
    </template>);

    let labelFor = find('[data-control] > label')?.getAttribute('for') || '';

    assert.ok(labelFor, 'Expected the id attribute of the label to be truthy');

    assert
      .dom('[data-checkbox]')
      .hasAttribute(
        'id',
        labelFor,
        'Expected the for attribute on the label to match the id attribute on the checkbox'
      );
  });

  test('it disables the checkbox using `@isDisabled` and renders a lock icon', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" @isDisabled={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').isDisabled();

    assert.dom('[data-lock-icon]').exists();

    assert.dom('[data-label]').hasClass('text-disabled');
  });

  test('it sets readonly on the checkbox using `@isReadOnly` and renders a lock icon', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" @isReadOnly={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasAttribute('readonly');

    assert.dom('[data-lock-icon]').exists();
  });

  test('it spreads attributes to the underlying checkbox', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" name="checkbox-name" data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasAttribute('name', 'checkbox-name');
  });

  test('it sets the checked-state via `@isChecked`', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" @isChecked={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').isChecked();
  });

  test('it calls `@onChange` when clicked with the expected checked state', async function (assert) {
    assert.expect(7);

    let handleChange = (checked: boolean, e: Event | InputEvent) => {
      assert.true(
        checked,
        'Expected to be checked since we started un-checked'
      );
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.step('handleChange');
    };

    await render(<template>
      <CheckboxField
        @label="Label"
        @onChange={{handleChange}}
        @isChecked={{false}}
        data-checkbox
      />
    </template>);

    assert.verifySteps([]);

    await click('[data-checkbox]');

    assert.verifySteps(['handleChange']);

    assert.dom('[data-checkbox]').isChecked();
  });

  test('it calls `@onChange` when clicked with the expected indeterminate state', async function (assert) {
    assert.expect(4);

    let handleChange = (_checked: boolean, e: Event | InputEvent) => {
      assert.false(
        (e.target as HTMLInputElement).indeterminate,
        'Expected indeterminate state to be false as the indeterminate property on the input element was changed by clicking it'
      );
      assert.step('handleChange');
    };

    await render(<template>
      <CheckboxField
        @label="Label"
        @onChange={{handleChange}}
        @isIndeterminate={{true}}
        data-checkbox
      />
    </template>);

    assert.verifySteps([]);

    await click('[data-checkbox]');

    assert.verifySteps(['handleChange']);
  });

  test('it applies the provided `@rootTestSelector` to the data-root-field attribute', async function (assert) {
    await render(<template>
      <CheckboxField
        @label="Label"
        @rootTestSelector="selector"
        data-checkbox
      />
    </template>);

    assert.dom('[data-root-field="selector"]').exists();
  });

  test('it sets default padding when not provided with "@value"', async function (assert) {
    // When a checkbox-field is used by itself, we want default padding to account
    // for the potential error shadow.
    await render(<template><CheckboxField @label="Label" /></template>);

    assert.dom('[data-control]').doesNotHaveClass('p-0');
    assert.dom('[data-control]').hasClass('p-1');
  });

  test('it sets no padding when provided with "@value"', async function (assert) {
    // When inside of a checkbox-group-field, we do not want the built-in
    // padding to account for the error shadow as the error shadow is handled
    // by the Fieldset instead. We can tell if we are in a checkbox-group-field
    // if an "@value" argument is provided.
    await render(<template>
      <CheckboxField @label="Label" @value="option-1" />
    </template>);

    assert.dom('[data-control]').doesNotHaveClass('p-1');
    assert.dom('[data-control]').hasClass('p-0');
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

    await render(<template><CheckboxField /></template>);
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
      <CheckboxField @label="Label">
        <:label>label block content</:label>
      </CheckboxField>
    </template>);
  });

  test('it throws an assertion error if provided with both "@value" and "@isChecked"', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes(
          'Both "@value" and "@isChecked" arguments were supplied.'
        ),
        'Expected assertion error message'
      );
    });

    await render(<template>
      <CheckboxField @label="Label" @isChecked={{true}} @value="option" />
    </template>);
  });
});
