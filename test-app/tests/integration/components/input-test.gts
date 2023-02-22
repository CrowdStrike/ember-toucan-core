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
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <InputControl data-input />
    </template>);

    assert.dom('[data-input]').hasTagName('input');
    assert.dom('[data-input]').hasClass('text-titles-and-attributes');
    assert.dom('[data-input]').doesNotHaveClass('text-disabled');
  });

  test('it disables the textarea using `@isDisabled`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <InputControl @isDisabled={{true}} data-input />
    </template>);

    assert.dom('[data-input]').isDisabled();
    assert.dom('[data-input]').hasClass('text-disabled');
    assert
      .dom('[data-input]')
      .doesNotHaveClass('text-titles-and-attributes');
  });

  test('it spreads attributes to the underlying textarea', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <InputControl placeholder="Placeholder text" data-input />
    </template>);

    assert
      .dom('[data-input]')
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it sets the value attribute via `@value`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
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
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <InputControl @onChange={{handleChange}} data-input />
    </template>);

    assert.verifySteps([]);

    await fillIn('[data-input]', 'test');

    assert.verifySteps(['handleChange']);
  });
});
