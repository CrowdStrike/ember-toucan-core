/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import { click, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import RadioControl from '@crowdstrike/ember-toucan-core/components/form/controls/radio';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Radio', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field }}
      {{! template-lint-disable require-input-label }}
      <RadioControl @value="option" data-radio />
    </template>);

    assert.dom('[data-radio]').hasTagName('input');
    assert.dom('[data-radio]').hasAttribute('type', 'radio');
    assert.dom('[data-radio]').hasAttribute('value', 'option');

    assert.dom('[data-radio]').isNotChecked();

    assert.dom('[data-radio]').hasClass('bg-normal-idle');
    assert.dom('[data-radio]').doesNotHaveClass('border-disabled');
  });

  test('it disables the radio using `@isDisabled`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field }}
      {{! template-lint-disable require-input-label }}
      <RadioControl @value="option" @isDisabled={{true}} data-radio />
    </template>);

    assert.dom('[data-radio]').isDisabled();

    assert.dom('[data-radio]').hasClass('border-disabled');
    assert.dom('[data-radio]').hasClass('bg-transparent');
    assert.dom('[data-radio]').doesNotHaveClass('bg-primary-idle');
    assert.dom('[data-radio]').doesNotHaveClass('border-none');
  });

  test('it makes the radio checked using `@isChecked={{true}}`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field }}
      {{! template-lint-disable require-input-label }}
      <RadioControl @value="option" @isChecked={{true}} data-radio />
    </template>);

    assert.dom('[data-radio]').isChecked();
  });

  test('it applies the expected classes when `@isDisabled={{true}}', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field }}
      {{! template-lint-disable require-input-label }}
      <RadioControl @value="option" @isDisabled={{true}} data-radio />
    </template>);

    assert.dom('[data-radio]').hasClass('bg-transparent');
    assert.dom('[data-radio]').hasClass('border-disabled');
    assert.dom('[data-radio]').hasNoClass('bg-primary-idle');
    assert.dom('[data-radio]').hasNoClass('border-none');
  });

  test('it applies the expected classes when `@isChecked={{true}}` and `@isDisabled={{false}}', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field }}
      {{! template-lint-disable require-input-label }}
      <RadioControl
        @value="option"
        @isChecked={{true}}
        @isDisabled={{false}}
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').hasClass('bg-primary-idle');
    assert.dom('[data-radio]').hasClass('border-none');
    assert.dom('[data-radio]').hasNoClass('bg-disabled');
    assert.dom('[data-radio]').hasNoClass('bg-transparent');
    assert.dom('[data-radio]').hasNoClass('bg-normal-idle');
    assert.dom('[data-radio]').hasNoClass('border-disabled');
  });

  test('it applies the expected classes when `@isChecked={{true}}` and `@isDisabled={{true}}', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field }}
      {{! template-lint-disable require-input-label }}
      <RadioControl
        @value="option"
        @isChecked={{true}}
        @isDisabled={{true}}
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').hasClass('bg-disabled');
    assert.dom('[data-radio]').hasClass('border-none');
    assert.dom('[data-radio]').hasNoClass('bg-primary-idle');
    assert.dom('[data-radio]').hasNoClass('bg-transparent');
    assert.dom('[data-radio]').hasNoClass('bg-normal-idle');
    assert.dom('[data-radio]').hasNoClass('border-disabled');
  });

  test('it spreads attributes to the underlying radio', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field }}
      {{! template-lint-disable require-input-label }}
      <RadioControl @value="option" name="a-name" data-radio />
    </template>);

    assert.dom('[data-radio]').hasAttribute('name', 'a-name');
  });

  test('it calls `@onChange` when clicked', async function (assert) {
    assert.expect(6);

    let handleChange = (value: string, e: Event | InputEvent) => {
      assert.strictEqual(value, 'option', 'Expected value to matched');
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.step('handleChange');
    };

    await render(<template>
      {{! we do not require a label, but instead suggest using Field }}
      {{! template-lint-disable require-input-label }}
      <RadioControl @value="option" @onChange={{handleChange}} data-radio />
    </template>);

    assert.verifySteps([]);

    await click('[data-radio]');

    assert.verifySteps(['handleChange']);
  });

  test('it throws an assertion error if not provided with `@value`', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('A "@value" argument is required'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      {{! @glint-expect-error:we are not providing @value, so this is expected }}
      <RadioControl />
    </template>);
  });
});
