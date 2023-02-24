/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

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
    assert.dom('[data-checkbox]').hasAttribute('data-checked', 'false');

    assert.dom('[data-checkbox]').hasClass('bg-normal-idle');
    assert.dom('[data-checkbox]').doesNotHaveClass('border-disabled');
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

  test('it makes the checkbox checked using `@value`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @value={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').isChecked();
    assert.dom('[data-checkbox]').hasAttribute('data-checked', 'true');
  });

  test('it makes the checkbox indeterminate using `@isIndeterminate`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @isIndeterminate={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasAttribute('data-checked', 'mixed');

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

  test('it applies the expected classes when `@value={{true}}` and `@isDisabled={{true}}', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <CheckboxControl @value={{true}} @isDisabled={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasClass('bg-disabled');
    assert.dom('[data-checkbox]').hasClass('border-none');
    assert.dom('[data-checkbox]').hasNoClass('bg-primary-idle');
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
    assert.expect(7);

    let handleChange = (
      checked: boolean,
      e: Event | InputEvent,
      isIndeterminate: boolean
    ) => {
      assert.true(
        checked,
        'Expected to be checked since we started un-checked'
      );
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.false(
        isIndeterminate,
        'Expected indeterminate state to be false as we did not provide `@isIndeterminate={{true}}`'
      );
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

    let handleChange = (
      _checked: boolean,
      _e: Event | InputEvent,
      isIndeterminate: boolean
    ) => {
      assert.false(
        isIndeterminate,
        'Expected indeterminate state to be false since we started as true'
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
