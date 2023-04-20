/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import { fillIn, render } from '@ember/test-helpers';
import { module, test } from 'qunit';

// outside of tests, in everyday use, use <Form::Controls::Input />
import InputControl from '@crowdstrike/ember-toucan-core/components/form/controls/input';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Input', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / InputField }}
      {{! template-lint-disable require-input-label }}
      <InputControl data-input />
    </template>);

    assert.dom('[data-input]').hasTagName('input');
    assert.dom('[data-input]').hasClass('text-titles-and-attributes');
    assert.dom('[data-input]').doesNotHaveClass('text-disabled');
    assert.dom('[data-input]').doesNotHaveClass('shadow-error-outline');
    assert
      .dom('[data-input]')
      .doesNotHaveClass('focus:shadow-error-focus-outline');
  });

  test('it disables the input using `@isDisabled`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / InputField }}
      {{! template-lint-disable require-input-label }}
      <InputControl @isDisabled={{true}} data-input />
    </template>);

    assert.dom('[data-input]').isDisabled();
    assert.dom('[data-input]').hasClass('text-disabled');
    assert.dom('[data-input]').doesNotHaveClass('text-titles-and-attributes');
  });

  test('it sets readonly on the input using `@isReadOnly`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <InputControl @isReadOnly={{true}} data-input />
    </template>);

    assert.dom('[data-input]').hasAttribute('readonly');

    assert.dom('[data-input]').hasClass('shadow-read-only-outline');
    assert.dom('[data-input]').hasClass('bg-surface-xl');
    assert.dom('[data-input]').hasNoClass('bg-overlay-1');
    assert.dom('[data-input]').hasNoClass('text-disabled');
    assert.dom('[data-input]').hasNoClass('shadow-error-outline');
    assert.dom('[data-input]').hasNoClass('shadow-focusable-outline');
  });

  test('it spreads attributes to the underlying input', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / InputField }}
      {{! template-lint-disable require-input-label }}
      <InputControl placeholder="Placeholder text" data-input />
    </template>);

    assert.dom('[data-input]').hasAttribute('placeholder', 'Placeholder text');
  });

  test('it sets the value attribute via `@value`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / InputField }}
      {{! template-lint-disable require-input-label }}
      <InputControl @value="tony" data-input />
    </template>);

    assert.dom('[data-input]').hasValue('tony');
  });

  test('it calls `@onChange` when input is received', async function (assert) {
    assert.expect(6);

    let handleChange = (value: string, e: Event | InputEvent) => {
      assert.strictEqual(value, 'test', 'Expected input to match');
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.step('handleChange');
    };

    await render(<template>
      {{! we do not require a label, but instead suggest using Field / InputField }}
      {{! template-lint-disable require-input-label }}
      <InputControl @onChange={{handleChange}} data-input />
    </template>);

    assert.verifySteps([]);

    await fillIn('[data-input]', 'test');

    assert.verifySteps(['handleChange']);
  });

  test('it applies the error shadow when `@hasError={{true}}`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <InputControl @hasError={{true}} data-input />
    </template>);

    assert.dom('[data-input]').hasClass('shadow-error-outline');
    assert.dom('[data-input]').hasClass('focus:shadow-error-focus-outline');
    assert.dom('[data-input]').doesNotHaveClass('shadow-focusable-outline');
  });
});
