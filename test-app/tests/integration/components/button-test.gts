import { render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import { setupRenderingTest } from 'test-app/tests/helpers';

import { Button as TestButton } from '@crowdstrike/ember-toucan-core/test-support';
import Button from '@crowdstrike/ember-toucan-core/components/button/index';

module('Integration | Component | button', function (hooks) {
  setupRenderingTest(hooks);

  let button = new TestButton('[data-button]');

  test('it renders', async function (assert) {
    await render(<template>
      <Button data-button>
        text
      </Button>
    </template>);

    assert.strictEqual(button.text, 'text');
    assert.false(button.isDisabled);
    assert
      .dom(button.element)
      .hasAttribute('type', 'button', 'Expected default type to be "button"');
  });

  test('it yields a loading named block when `@isLoading={{true}}', async function (assert) {
    await render(<template>
      <Button @isLoading={{true}} data-button>
        <:loading>
          <span data-test-loading-content>loading state</span>
        </:loading>
      </Button>
    </template>);

    assert.true(button.isLoading);

    assert
      .dom('[data-test-loading-content]')
      .exists('Expect to have loading named block rendered');
  });

  test('it does not render the content in the loading named block when `@isLoading={{false}}', async function (assert) {
    await render(<template>
      <Button @isLoading={{false}} data-button>
        <:loading>
          <span data-test-loading-content>should not be visible since isLoading
            is false</span>
        </:loading>
        <:default>
          <span data-test-default />
        </:default>
      </Button>
    </template>);

    assert.false(button.isLoading);

    assert
      .dom('[data-test-loading]')
      .doesNotExist('Expected to NOT have loading named block rendered');

    assert
      .dom('[data-test-default]')
      .exists('Expect to have default named block rendered');
  });

  test('it sets `aria-disabled="true"` when `@isDisabled={{true}}', async function (assert) {
    await render(<template>
      <Button @isDisabled={{true}} data-button>
        disabled
      </Button>
    </template>);

    assert.true(button.isDisabled);
  });

  test('it yields a disabled named block when `@isDisabled={{true}}', async function (assert) {
    await render(<template>
      <Button @isDisabled={{true}} data-button>
        <:disabled>
          <span data-test-disabled-content>disabled state</span>
        </:disabled>
      </Button>
    </template>);

    assert
      .dom('[data-test-disabled-content]')
      .exists('Expect to have disabled named block rendered');
  });

  test('it does not render the content in the disabled named block when `@isDisabled={{false}}', async function (assert) {
    await render(<template>
      <Button @isDisabled={{false}} data-button>
        <:disabled>
          <span data-test-disabled-content>should not be visible since
            isDisabled is false</span>
        </:disabled>
        <:default>
          <span data-test-default />
        </:default>
      </Button>
    </template>);

    assert
      .dom('[data-test-disabled-content]')
      .doesNotExist('Expected to NOT have disabled named block rendered');

    assert
      .dom('[data-test-default]')
      .exists('Expect to have default named block rendered');
  });

  test('it calls the provided `@onClick`', async function (assert) {
    let onClick = () => assert.step('clicked');

    await render(<template>
      <Button @onClick={{onClick}} data-button>
        button
      </Button>
    </template>);

    assert.verifySteps([]);

    await button.click();

    assert.verifySteps(['clicked']);
  });

  test('it does NOT call the provided `@onClick` if `@isDisabled={{true}}', async function (assert) {
    let onClick = () => assert.step('clicked');

    await render(<template>
      <Button @isDisabled={{true}} @onClick={{onClick}} data-button>
        button
      </Button>
    </template>);

    assert.verifySteps([]);

    await button.click();

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

    await render(<template>
      {{! @glint-expect-error: we are passing in an unsupported variant, so this is expected }}
      <Button @variant="not-a-real-variant">
        button
      </Button>
    </template>);
  });
});
