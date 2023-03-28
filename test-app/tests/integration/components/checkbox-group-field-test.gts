/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import { click, render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import CheckboxGroupField from '@crowdstrike/ember-toucan-core/components/form/checkbox-group-field';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | CheckboxGroupField', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <CheckboxGroupField @label="Label" @name="group" data-group-field />
    </template>);

    assert.dom('[data-group-field]').exists();
    assert.dom('[data-group-field]').hasNoAttribute('aria-invalid');

    assert.dom('[data-label]').hasText('Label');
  });

  test('it renders yielded CheckboxFields', async function (assert) {
    await render(<template>
      <CheckboxGroupField
        @label="Label"
        @name="group"
        data-group-field
        as |group|
      >
        <group.CheckboxField
          @label="label 1"
          @value="option-1"
          data-checkbox-1
        />
        <group.CheckboxField
          @label="label 2"
          @value="option-2"
          data-checkbox-2
        />
      </CheckboxGroupField>
    </template>);

    assert.dom('[data-group-field]').exists();
    assert.dom('[data-checkbox-1]').exists();
    assert.dom('[data-checkbox-2]').exists();
  });

  test('it sets the `value` attribute of the yielded CheckboxFields based on the provided `@value` argument', async function (assert) {
    await render(<template>
      <CheckboxGroupField
        @label="Label"
        @name="group"
        data-group-field
        as |group|
      >
        <group.CheckboxField
          @label="label 1"
          @value="option-1"
          data-checkbox-1
        />
        <group.CheckboxField
          @label="label 2"
          @value="option-2"
          data-checkbox-2
        />
      </CheckboxGroupField>
    </template>);

    assert.dom('[data-checkbox-1]').hasValue('option-1');
    assert.dom('[data-checkbox-2]').hasValue('option-2');
  });

  test('it curries the `name` attribute to yielded CheckboxFields from the `@name` argument', async function (assert) {
    await render(<template>
      <CheckboxGroupField
        @label="Label"
        @name="checkbox-group-name"
        data-group-field
        as |group|
      >
        <group.CheckboxField
          @label="label 1"
          @value="option-1"
          data-checkbox-1
        />
        <group.CheckboxField
          @label="label 2"
          @value="option-2"
          data-checkbox-2
        />
      </CheckboxGroupField>
    </template>);

    assert.dom('[data-checkbox-1]').hasAttribute('name', 'checkbox-group-name');
    assert.dom('[data-checkbox-2]').hasAttribute('name', 'checkbox-group-name');
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <CheckboxGroupField @label="Label" @name="group" @hint="Hint text" />
    </template>);

    assert.dom('[data-hint]').hasText('Hint text');
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <CheckboxGroupField @label="Label" @name="group" @error="Error text" />
    </template>);

    assert.dom('[data-error]').hasText('Error text');
  });

  test('it default-checks the checkbox with the matching `@value`', async function (assert) {
    let selectedOption = ['option-2'];

    await render(<template>
      <CheckboxGroupField
        @label="Label"
        @name="group"
        @value={{selectedOption}}
        as |group|
      >
        <group.CheckboxField
          @label="label 1"
          @value="option-1"
          data-checkbox-1
        />
        <group.CheckboxField
          @label="label 2"
          @value="option-2"
          data-checkbox-2
        />
      </CheckboxGroupField>
    </template>);

    assert.dom('[data-checkbox-1]').isNotChecked();
    assert.dom('[data-checkbox-2]').isChecked();
  });

  test('it disables the fieldset and all child checkboxes using `@isDisabled`', async function (assert) {
    await render(<template>
      <CheckboxGroupField
        @label="Label"
        @name="group"
        @isDisabled={{true}}
        data-group-field
        as |group|
      >
        <group.CheckboxField
          @label="label 1"
          @value="option-1"
          data-checkbox-1
        />
        <group.CheckboxField
          @label="label 2"
          @value="option-2"
          data-checkbox-2
        />
      </CheckboxGroupField>
    </template>);

    assert.dom('[data-group-field]').isDisabled();
    assert.dom('[data-checkbox-1]').isDisabled();
    assert.dom('[data-checkbox-2]').isDisabled();
  });

  test('it calls `@onChange` when a checkbox is clicked and can update `@value`', async function (assert) {
    assert.expect(10);

    let selectedValue = ['option-2'];

    let handleChange = (value: Array<string>, e: Event | InputEvent) => {
      assert.deepEqual(
        value,
        ['option-2', 'option-1'],
        'Expected value to matched'
      );
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.step('handleChange');

      selectedValue = value;
    };

    await render(<template>
      <CheckboxGroupField
        @label="Label"
        @name="group"
        @onChange={{handleChange}}
        @value={{selectedValue}}
        as |group|
      >
        <group.CheckboxField
          @label="label 1"
          @value="option-1"
          data-checkbox-1
        />
        <group.CheckboxField
          @label="label 2"
          @value="option-2"
          data-checkbox-2
        />
      </CheckboxGroupField>
    </template>);

    assert.verifySteps([]);

    assert.dom('[data-checkbox-1]').isNotChecked();
    assert.dom('[data-checkbox-2]').isChecked();

    await click('[data-checkbox-1]');

    assert.verifySteps(['handleChange']);

    assert.dom('[data-checkbox-1]').isChecked();
    assert.dom('[data-checkbox-2]').isChecked();
  });

  test('it sets "aria-invalid" when provided with `@error`', async function (assert) {
    await render(<template>
      <CheckboxGroupField
        @label="Label"
        @name="group"
        @error="Error message"
        data-group-field
      />
    </template>);

    assert.dom('[data-group-field]').hasAttribute('aria-invalid', 'true');
  });
});
