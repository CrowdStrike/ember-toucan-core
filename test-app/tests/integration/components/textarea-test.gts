/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { fillIn, render, settled } from '@ember/test-helpers';
import { module, test } from 'qunit';

import TextareaControl from '@crowdstrike/ember-toucan-core/components/form/controls/textarea';
import { setupRenderingTest } from 'test-app/tests/helpers';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

module('Integration | Component | Textarea', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <TextareaControl data-textarea />
    </template>);

    assert.dom('[data-textarea]').hasTagName('textarea');
    assert.dom('[data-container]').hasClass('text-titles-and-attributes');
    assert.dom('[data-container]').hasClass('shadow-focusable-outline');
    assert.dom('[data-container]').doesNotHaveClass('text-disabled');
    assert.dom('[data-container]').doesNotHaveClass('shadow-error-outline');
    assert
      .dom('[data-container]')
      .doesNotHaveClass('focus-within:shadow-error-focus-outline');
  });

  test('it disables the textarea using `@isDisabled`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <TextareaControl @isDisabled={{true}} data-textarea />
    </template>);

    assert.dom('[data-textarea]').isDisabled();
    assert.dom('[data-container]').hasClass('text-disabled');
    assert
      .dom('[data-container]')
      .doesNotHaveClass('text-titles-and-attributes');
  });

  test('it sets readonly on the textarea using `@isReadOnly`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <TextareaControl @isReadOnly={{true}} data-textarea />
    </template>);

    assert.dom('[data-textarea]').hasAttribute('readonly');

    assert.dom('[data-container]').hasClass('shadow-read-only-outline');
    assert.dom('[data-container]').hasClass('bg-surface-xl');
    assert.dom('[data-container]').hasNoClass('bg-overlay-1');
    assert.dom('[data-container]').hasNoClass('text-disabled');
    assert.dom('[data-container]').hasNoClass('shadow-error-outline');
    assert.dom('[data-container]').hasNoClass('shadow-focusable-outline');
  });

  test('it spreads attributes to the underlying textarea', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <TextareaControl placeholder="Placeholder text" data-textarea />
    </template>);

    assert
      .dom('[data-textarea]')
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it sets the value attribute via `@value`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <TextareaControl @value="tony" data-textarea />
    </template>);

    assert.dom('[data-textarea]').hasValue('tony');
  });

  test('it keeps the <textarea> value in sync with external changes to `@value`', async function (assert) {
    class TestContext {
      @tracked testValue;
    }
    const testContext = new TestContext();
    testContext.testValue = 'initial';

    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <TextareaControl @value={{testContext.testValue}} data-textarea />
    </template>);

    assert.dom('[data-textarea]').hasValue('initial');

    testContext.testValue = 'updated';

    await settled();

    assert.dom('[data-textarea]').hasValue('updated');
  });

  test('it keeps the <textarea> value in sync with external changes to `@value` after the value is changed', async function (assert) { 
    class TestContext {
      @tracked testValue;

      @action
      updateTestValue(value, e) {
        this.testValue = value;
      }
    }
    const testContext = new TestContext();
    testContext.testValue = 'initial';

    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <TextareaControl @value={{testContext.testValue}} @onChange={{testContext.updateTestValue}} data-textarea />
    </template>);

    assert.dom('[data-textarea]').hasValue('initial');

    await fillIn('[data-textarea]', 'test');

    assert.dom('[data-textarea]').hasValue('test');

    testContext.testValue = 'updated';

    await settled();

    assert.dom('[data-textarea]').hasValue('updated');
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
      <TextareaControl @onChange={{handleChange}} data-textarea />
    </template>);

    assert.verifySteps([]);

    await fillIn('[data-textarea]', 'test');

    assert.verifySteps(['handleChange']);
  });

  test('it applies the error shadow when `@hasError={{true}}`', async function (assert) {
    await render(<template>
      {{! we do not require a label, but instead suggest using Field / TextareaField }}
      {{! template-lint-disable require-input-label }}
      <TextareaControl @hasError={{true}} data-textarea />
    </template>);

    assert.dom('[data-container]').hasClass('shadow-error-outline');
    assert
      .dom('[data-container]')
      .hasClass('focus-within:shadow-error-focus-outline');
    assert.dom('[data-container]').doesNotHaveClass('shadow-focusable-outline');
  });
});
