/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import { find, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import Fieldset from '@crowdstrike/ember-toucan-core/components/form/fieldset';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Fieldset', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <Fieldset @label="Label" data-fieldset />
    </template>);

    assert.dom('[data-label]').hasText('Label');

    assert
      .dom('[data-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided'
      );

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected error block not to be displayed as an error was not provided'
      );

    assert.dom('[data-control]').hasNoClass('shadow-error-outline');
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <Fieldset @label="Label" @hint="Hint text" data-fieldset />
    </template>);

    assert.dom('[data-hint]').hasText('Hint text');
    assert.dom('[data-hint]').hasAttribute('id');
    assert.dom('[data-fieldset]').hasAttribute('aria-describedby');
  });

  test('it renders with hint and label blocks', async function (assert) {
    await render(<template>
      <Fieldset data-fieldset>
        <:label><span data-label>label block content</span></:label>
        <:hint><span data-hint>hint block content</span></:hint>
      </Fieldset>
    </template>);

    assert.dom('[data-hint]').hasText('hint block content');
    assert.dom('[data-label]').hasText('label block content');
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <Fieldset @label="Label" @error="Error text" data-fieldset />
    </template>);

    assert.dom('[data-error]').hasText('Error text');
    assert.dom('[data-error]').hasAttribute('id');

    assert.dom('[data-fieldset]').hasAttribute('aria-describedby');

    assert.dom('[data-control]').hasClass('shadow-error-outline');
  });

  test('it renders with multiple errors', async function (assert) {
    let testErrors = ['error 1', 'error 2'];

    await render(<template>
      <Fieldset @label="Label" @error={{testErrors}} data-fieldset />
    </template>);

    assert.dom('[data-control]').hasClass('shadow-error-outline');

    assert.dom('[data-error]').hasAttribute('id');

    assert.dom('[data-error-item]').exists({ count: 2 });

    assert
      .dom('[data-error-item="0"]')
      .hasText('error 1', 'Expected to have first error text rendered');

    assert
      .dom('[data-error-item="1"]')
      .hasText('error 2', 'Expected to have first error text rendered');
  });

  test('it sets aria-describedby when both a hint and error are provided', async function (assert) {
    await render(<template>
      <Fieldset
        @label="Label"
        @error="Error text"
        @hint="Hint text"
        data-fieldset
      />
    </template>);

    let errorId = find('[data-error]')?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected errorId to be truthy');

    let hintId = find('[data-hint]')?.getAttribute('id') || '';
    assert.ok(hintId, 'Expected hintId to be truthy');

    assert
      .dom('[data-fieldset]')
      .hasAttribute('aria-describedby', `${errorId} ${hintId}`);
  });

  test('it disables the fieldset using `@isDisabled`', async function (assert) {
    await render(<template>
      <Fieldset @label="Label" @isDisabled={{true}} data-fieldset />
    </template>);

    assert.dom('[data-fieldset]').isDisabled();
  });

  test('it spreads attributes to the underlying fieldset', async function (assert) {
    await render(<template>
      <Fieldset @label="Label" form="form-id" data-fieldset />
    </template>);

    assert.dom('[data-fieldset]').hasAttribute('form', 'form-id');
  });

  test('it throws an assertion error if no `@label` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('Assertion Failed: You need either :label or @label'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      <Fieldset />
    </template>);
  });

  test('it throws an assertion error if `@label` and `:label` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('Assertion Failed: You can have :label or @label, but not both'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      <Fieldset @label="Label">
        <:label>Hi</:label>
      </Fieldset>
    </template>);
  });
});
