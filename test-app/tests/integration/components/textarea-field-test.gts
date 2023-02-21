/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import { find, render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import TextareaField from '@crowdstrike/ember-toucan-core/components/form/textarea-field';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | TextareaField', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <TextareaField @label="Label" data-test-textarea />
    </template>);

    assert.dom('[data-textarea-label]').hasText('Label');

    assert
      .dom('[data-textarea-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided'
      );

    assert.dom('[data-test-textarea]').hasTagName('textarea');
    assert.dom('[data-test-textarea]').hasAttribute('id');
    assert.dom('[data-test-textarea]').hasClass('text-titles-and-attributes');

    assert
      .dom('[data-textarea-error]')
      .doesNotExist(
        'Expected hint block not to be displayed as an error was not provided'
      );
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <TextareaField @label="Label" @hint="Hint text" data-test-textarea />
    </template>);

    let hint = find('[data-textarea-hint]');

    assert.dom(hint).hasText('Hint text');
    assert.dom(hint).hasAttribute('id');

    let hintId = hint?.getAttribute('id') || '';
    assert.ok(hintId, 'Expected hint ID to be truthy');

    let describedby =
      find('[data-test-textarea]')?.getAttribute('aria-describedby') || '';
    assert.ok(
      describedby.includes(hintId),
      'Expected hintId to be included in the aria-describedby'
    );
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <TextareaField @label="Label" @error="Error text" data-test-textarea />
    </template>);

    let error = find('[data-textarea-error]');

    assert.dom(error).hasText('Error text');
    assert.dom(error).hasAttribute('id');

    let errorId = error?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected error ID to be truthy');

    let describedby =
      find('[data-test-textarea]')?.getAttribute('aria-describedby') || '';
    assert.ok(
      describedby.includes(errorId),
      'Expected errorId to be included in the aria-describedby'
    );

    assert.dom('[data-test-textarea]').hasAttribute('aria-invalid', 'true');
  });

  test('it sets aria-describedby when both a hint and error are provided using the hint and error IDs', async function (assert) {
    await render(<template>
      <TextareaField
        @label="Label"
        @error="Error text"
        @hint="Hint text"
        data-test-textarea
      />
    </template>);

    let errorId = find('[data-textarea-error]')?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected error ID to be truthy');

    let hintId = find('[data-textarea-hint]')?.getAttribute('id') || '';
    assert.ok(hintId, 'Expected hint ID to be truthy');

    assert
      .dom('[data-test-textarea]')
      .hasAttribute('aria-describedby', `${errorId} ${hintId}`);
  });

  test('it disables the textarea using `@isDisabled`', async function (assert) {
    await render(<template>
      <TextareaField @label="Label" @isDisabled={{true}} data-test-textarea />
    </template>);

    assert.dom('[data-test-textarea]').isDisabled();
    assert.dom('[data-test-textarea]').hasClass('text-disabled');
  });

  test('it spreads attributes to the underlying textarea', async function (assert) {
    await render(<template>
      <TextareaField
        @label="Label"
        placeholder="Placeholder text"
        data-test-textarea
      />
    </template>);

    assert
      .dom('[data-test-textarea]')
      .hasAttribute('placeholder', 'Placeholder text');
  });
});
