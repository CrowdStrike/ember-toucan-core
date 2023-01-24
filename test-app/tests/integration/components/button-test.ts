import { click, render, setupOnerror } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';
import { module, test } from 'qunit';

import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | button', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(hbs`
      <Button>
        text
      </Button>
    `);

    assert.dom('button').hasText('text');
    assert.dom('button').hasNoAttribute('aria-disabled');
    assert
      .dom('button')
      .hasAttribute('type', 'button', 'Expected default type to be "button"');
  });

  test('it yields a loading named block when `@isLoading={{true}}', async function (assert) {
    await render(hbs`
      <Button @isLoading={{true}}>
        <:loading>
          <span data-test-selector="loading">loading state</span>
        </:loading>
      </Button>
    `);

    assert
      .dom('[data-test-selector="loading"]')
      .exists('Expect to have loading named block rendered');
  });

  test('it does not render the content in the loading named block when `@isLoading={{false}}', async function (assert) {
    await render(hbs`
      <Button @isLoading={{false}}>
        <:loading>
          <span data-test-selector="loading">should not be visible since isLoading is false</span>
        </:loading>
        <:default>
          <span data-test-selector="default" />
        </:default>
      </Button>
    `);

    assert
      .dom('[data-test-selector="loading"]')
      .doesNotExist('Expected to NOT have loading named block rendered');

    assert
      .dom('[data-test-selector="default"]')
      .exists('Expect to have default named block rendered');
  });

  test('it yields a disabled named block when `@isDisabled={{true}}', async function (assert) {
    await render(hbs`
      <Button @isDisabled={{true}}>
        <:disabled>
          <span data-test-selector="disabled">disabled state</span>
        </:disabled>
      </Button>
    `);

    assert
      .dom('[data-test-selector="disabled"]')
      .exists('Expect to have disabled named block rendered');
  });

  test('it does not render the content in the disabled named block when `@isDisabled={{false}}', async function (assert) {
    await render(hbs`
      <Button @isDisabled={{false}}>
        <:disabled>
          <span data-test-selector="disabled">should not be visible since isDisabled is false</span>
        </:disabled>
        <:default>
          <span data-test-selector="default" />
        </:default>
      </Button>
    `);

    assert
      .dom('[data-test-selector="disabled"]')
      .doesNotExist('Expected to NOT have disabled named block rendered');

    assert
      .dom('[data-test-selector="default"]')
      .exists('Expect to have default named block rendered');
  });

  test('it sets `aria-disabled="true"` when `@isDisabled={{true}}', async function (assert) {
    await render(hbs`
      <Button @isDisabled={{true}}>
        disabled
      </Button>
    `);

    assert.dom('button').hasAttribute('aria-disabled', 'true');
  });

  test('it calls the provided `@onClick`', async function (assert) {
    this.set('onClick', () => assert.step('clicked'));

    await render(hbs`
      <Button @onClick={{this.onClick}}>
        button
      </Button>
    `);

    assert.verifySteps([]);

    await click('button');

    assert.verifySteps(['clicked']);
  });

  test('it does NOT call the provided `@onClick` if `@isDisabled={{true}}', async function (assert) {
    this.set('onClick', () => assert.step('clicked'));

    await render(hbs`
      <Button @isDisabled={{true}} @onClick={{this.onClick}}>
        button
      </Button>
    `);

    assert.verifySteps([]);

    await click('button');

    assert.verifySteps([]);
  });

  test('it throws an assertion error if provided with an unsupported `@variant`', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('Invalid variant for Button'),
        'Expected assertion error message'
      );
    });

    await render(hbs`
      <Button @variant="not-a-real-variant">
        button
      </Button>
    `);
  });
});
