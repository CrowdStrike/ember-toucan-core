/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { click, render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import CheckboxControl from '@crowdstrike/ember-toucan-core/components/form/controls/checkbox';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Checkbox', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasTagName('input');
    assert.dom('[data-checkbox]').hasAttribute('type', 'checkbox');

    assert.dom('[data-checkbox]').isNotChecked();
    assert.dom('[data-checkbox]').hasProperty('indeterminate', false);

    assert.dom('[data-checkbox]').hasClass('bg-normal-idle');
    assert.dom('[data-checkbox]').doesNotHaveClass('border-disabled');

    assert.dom('[data-checkbox]').hasNoAttribute('readonly');
  });

  test('it disables the checkbox using `@isDisabled`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @isDisabled={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').isDisabled();

    assert.dom('[data-checkbox]').hasClass('border-disabled');
    assert.dom('[data-checkbox]').hasClass('bg-transparent');
    assert.dom('[data-checkbox]').doesNotHaveClass('bg-primary-idle');
    assert.dom('[data-checkbox]').doesNotHaveClass('border-none');
  });

  test('it sets readonly on the checkbox using `@isReadOnly`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @isReadOnly={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasAttribute('readonly');
  });

  test('it makes the checkbox checked using `@isChecked`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @isChecked={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').isChecked();
  });

  test('it makes the checkbox indeterminate using `@isIndeterminate`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @isIndeterminate={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasProperty('indeterminate', true);

    assert.dom('[data-checkbox]').hasClass('bg-primary-idle');
    assert.dom('[data-checkbox]').hasClass('border-none');
    assert.dom('[data-checkbox]').hasNoClass('border-disabled');
    assert.dom('[data-checkbox]').hasNoClass('bg-transparent');
  });

  test('it applies the expected classes when `@isIndeterminate={{true}}` and `@isDisabled={{true}}', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl
        @isIndeterminate={{true}}
        @isDisabled={{true}}
        data-checkbox
      />
    </template>);

    assert.dom('[data-checkbox]').hasClass('bg-disabled');
    assert.dom('[data-checkbox]').hasClass('border-none');
    assert.dom('[data-checkbox]').hasNoClass('bg-primary-idle');
  });

  test('it applies the expected classes when `@isChecked={{true}}` and `@isDisabled={{true}}', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @isChecked={{true}} @isDisabled={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasClass('bg-disabled');
    assert.dom('[data-checkbox]').hasClass('border-none');
    assert.dom('[data-checkbox]').hasNoClass('bg-primary-idle');
  });

  test('it applies the expected classes when `@isChecked={{true}}` and `@isReadOnly={{true}}', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @isChecked={{true}} @isReadOnly={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasClass('bg-titles-and-attributes');
    assert.dom('[data-checkbox]').hasClass('border-none');
    assert.dom('[data-checkbox]').hasNoClass('bg-primary-idle');
    assert.dom('[data-checkbox]').hasNoClass('bg-transparent');
    assert.dom('[data-checkbox]').hasNoClass('bg-surface-xl');
    assert.dom('[data-checkbox]').hasNoClass('bg-normal-idle');
    assert.dom('[data-checkbox]').hasNoClass('bg-disabled');
    assert.dom('[data-checkbox]').hasNoClass('border-disabled');
  });

  test('it applies the expected classes when `@isChecked={{false}}` and `@isReadOnly={{true}}', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl
        @isChecked={{false}}
        @isReadOnly={{true}}
        data-checkbox
      />
    </template>);

    assert.dom('[data-checkbox]').hasClass('bg-surface-xl');
    assert.dom('[data-checkbox]').hasNoClass('bg-primary-idle');
    assert.dom('[data-checkbox]').hasNoClass('bg-transparent');
    assert.dom('[data-checkbox]').hasNoClass('bg-titles-and-attributes');
    assert.dom('[data-checkbox]').hasNoClass('bg-normal-idle');
    assert.dom('[data-checkbox]').hasNoClass('bg-disabled');
    assert.dom('[data-checkbox]').hasNoClass('border-disabled');
  });

  test('it spreads attributes to the underlying checkbox', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl name="a-name" data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasAttribute('name', 'a-name');
  });

  test('it calls `@onChange` when clicked with the expected checked state', async function (assert) {
    assert.expect(6);

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
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @onChange={{handleChange}} data-checkbox />
    </template>);

    assert.verifySteps([]);

    await click('[data-checkbox]');

    assert.verifySteps(['handleChange']);
  });

  test('it calls `@onChange` when clicked with the expected indeterminate state', async function (assert) {
    assert.expect(4);

    let handleChange = (_checked: boolean, e: Event | InputEvent) => {
      assert.false(
        (e.target as HTMLInputElement).indeterminate,
        'Expected indeterminate state to be false since we started as true and the element was clicked'
      );
      assert.step('handleChange');
    };

    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl
        @onChange={{handleChange}}
        @isIndeterminate={{true}}
        data-checkbox
      />
    </template>);

    assert.verifySteps([]);

    await click('[data-checkbox]');

    assert.verifySteps(['handleChange']);
  });
});
