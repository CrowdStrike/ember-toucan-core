/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { fillIn, render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import ComboboxControl from '@crowdstrike/ember-toucan-core/components/form/controls/combobox';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Combobox', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / ComboboxField }}
      {{! template-lint-disable require-input-label }}
      <ComboboxControl data-combobox />
    </template>);

    assert.dom('[data-combobox]').hasTagName('input');
    assert.dom('[data-combobox]').hasClass('text-titles-and-attributes');
    assert.dom('[data-combobox]').hasClass('shadow-focusable-outline');
    assert.dom('[data-combobox]').doesNotHaveClass('text-disabled');
    assert.dom('[data-combobox]').doesNotHaveClass('shadow-error-outline');
    assert
      .dom('[data-combobox]')
      .doesNotHaveClass('focus:shadow-error-focus-outline');
  });

  test('it disables the combobox using `@isDisabled`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / ComboboxField }}
      {{! template-lint-disable require-input-label }}
      <ComboboxControl @isDisabled={{true}} data-combobox />
    </template>);

    assert.dom('[data-combobox]').isDisabled();
    assert.dom('[data-combobox]').hasClass('text-disabled');
    assert
      .dom('[data-combobox]')
      .doesNotHaveClass('text-titles-and-attributes');
  });

  test('it sets readonly on the combobox using `@isReadOnly`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / ComboboxField }}
      {{! template-lint-disable require-input-label }}
      <ComboboxControl @isReadOnly={{true}} data-combobox />
    </template>);

    assert.dom('[data-combobox]').hasAttribute('readonly');

    assert.dom('[data-combobox]').hasClass('shadow-read-only-outline');
    assert.dom('[data-combobox]').hasClass('bg-surface-xl');
    assert.dom('[data-combobox]').hasNoClass('bg-overlay-1');
    assert.dom('[data-combobox]').hasNoClass('text-disabled');
    assert.dom('[data-combobox]').hasNoClass('shadow-error-outline');
    assert.dom('[data-combobox]').hasNoClass('shadow-focusable-outline');
  });

  // test('it spreads attributes to the underlying textarea', async function (assert) {
  //   await render(<template>
  //     {{! we do not require a label, but instead suggest using Field / ComboboxField }}
  //     {{! template-lint-disable require-input-label }}
  //     <ComboboxControl placeholder="Placeholder text" data-combobox />
  //   </template>);

  //   assert
  //     .dom('[data-combobox]')
  //     .hasAttribute('placeholder', 'Placeholder text');
  // });

  // test('it sets the value attribute via `@value`', async function (assert) {
  //   await render(<template>
  //     {{! we do not require a label, but instead suggest using Field / ComboboxField }}
  //     {{! template-lint-disable require-input-label }}
  //     <ComboboxControl @value="tony" data-combobox />
  //   </template>);

  //   assert.dom('[data-combobox]').hasValue('tony');
  // });

  // test('it calls `@onChange` when input is received', async function (assert) {
  //   assert.expect(6);

  //   let handleChange = (value: string, e: Event | InputEvent) => {
  //     assert.strictEqual(value, 'test', 'Expected input to match');
  //     assert.ok(e, 'Expected `e` to be available as the second argument');
  //     assert.ok(e.target, 'Expected direct access to target from `e`');
  //     assert.step('handleChange');
  //   };

  //   await render(<template>
  //     {{! we do not require a label, but instead suggest using Field / ComboboxField }}
  //     {{! template-lint-disable require-input-label }}
  //     <ComboboxControl @onChange={{handleChange}} data-combobox />
  //   </template>);

  //   assert.verifySteps([]);

  //   await fillIn('[data-combobox]', 'test');

  //   assert.verifySteps(['handleChange']);
  // });

  // test('it applies the error shadow when `@hasError={{true}}`', async function (assert) {
  //   await render(<template>
  //     {{! we do not require a label, but instead suggest using Field / ComboboxField }}
  //     {{! template-lint-disable require-input-label }}
  //     <ComboboxControl @hasError={{true}} data-combobox />
  //   </template>);

  //   assert.dom('[data-combobox]').hasClass('shadow-error-outline');
  //   assert.dom('[data-combobox]').hasClass('focus:shadow-error-focus-outline');
  //   assert.dom('[data-combobox]').doesNotHaveClass('shadow-focusable-outline');
  // });
});
