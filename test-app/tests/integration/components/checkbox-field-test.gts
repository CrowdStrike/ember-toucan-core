/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import { click, find, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import CheckboxField from '@crowdstrike/ember-toucan-core/components/form/checkbox-field';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | CheckboxField', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" @rootTestSelector="test" data-checkbox />
    </template>);

    assert.dom('[data-label]').hasText('Label');

    assert
      .dom('[data-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided'
      );

    assert.dom('[data-checkbox]').hasTagName('input');
    assert.dom('[data-checkbox]').hasAttribute('id');
    assert.dom('[data-checkbox]').hasNoAttribute('aria-invalid');

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected error block not to be displayed as an error was not provided'
      );
    assert
      .dom('[data-root-field="test"] > [data-control]')
      .hasNoClass('shadow-error-outline');
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" @hint="Hint text" data-checkbox />
    </template>);

    let hint = find('[data-hint]');

    assert.dom(hint).hasText('Hint text');
    assert.dom(hint).hasAttribute('id');

    let hintId = hint?.getAttribute('id') || '';
    assert.ok(hintId, 'Expected hintId to be truthy');

    let describedby =
      find('[data-checkbox]')?.getAttribute('aria-describedby') || '';
    assert.ok(
      describedby.includes(hintId),
      'Expected hintId to be included in the aria-describedby'
    );
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <CheckboxField
        @label="Label"
        @error="Error text"
        @rootTestSelector="test"
        data-checkbox
      />
    </template>);

    let error = find('[data-error]');

    assert.dom(error).hasText('Error text');
    assert.dom(error).hasAttribute('id');

    let errorId = error?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected errorId to be truthy');

    let describedby =
      find('[data-checkbox]')?.getAttribute('aria-describedby') || '';
    assert.ok(
      describedby.includes(errorId),
      'Expected errorId to be included in the aria-describedby'
    );

    assert.dom('[data-checkbox]').hasAttribute('aria-invalid', 'true');

    assert
      .dom('[data-root-field="test"] > [data-control]')
      .hasClass('shadow-error-outline');
  });

  test('it sets aria-describedby when both a hint and error are provided using the hint and errorIds', async function (assert) {
    await render(<template>
      <CheckboxField
        @label="Label"
        @error="Error text"
        @hint="Hint text"
        data-checkbox
      />
    </template>);

    let errorId = find('[data-error]')?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected errorId to be truthy');

    let hintId = find('[data-hint]')?.getAttribute('id') || '';
    assert.ok(hintId, 'Expected hintId to be truthy');

    assert
      .dom('[data-checkbox]')
      .hasAttribute('aria-describedby', `${errorId} ${hintId}`);
  });

  test('it disables the checkbox using `@isDisabled`', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" @isDisabled={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').isDisabled();
  });

  test('it spreads attributes to the underlying checkbox', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" name="checkbox-name" data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').hasAttribute('name', 'checkbox-name');
  });

  test('it sets the checked-state via `@value`', async function (assert) {
    await render(<template>
      <CheckboxField @label="Label" @value={{true}} data-checkbox />
    </template>);

    assert.dom('[data-checkbox]').isChecked();
  });

  test('it calls `@onChange` when clicked with the expected checked state', async function (assert) {
    assert.expect(8);

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
      <CheckboxField
        @label="Label"
        @onChange={{handleChange}}
        @value={{false}}
        data-checkbox
      />
    </template>);

    assert.verifySteps([]);

    await click('[data-checkbox]');

    assert.verifySteps(['handleChange']);

    assert.dom('[data-checkbox]').isChecked();
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
        'Expected indeterminate state to be false as we did not provide `@isIndeterminate={{true}}`'
      );
      assert.step('handleChange');
    };

    await render(<template>
      <CheckboxField
        @label="Label"
        @onChange={{handleChange}}
        @isIndeterminate={{true}}
        data-checkbox
      />
    </template>);

    assert.verifySteps([]);

    await click('[data-checkbox]');

    assert.verifySteps(['handleChange']);
  });

  test('it applies the provided `@rootTestSelector` to the data-root-field attribute', async function (assert) {
    await render(<template>
      <CheckboxField
        @label="Label"
        @rootTestSelector="selector"
        data-checkbox
      />
    </template>);

    assert.dom('[data-root-field="selector"]').exists();
  });

  test('it throws an assertion error if no `@label` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('A "@label" argument is required'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      {{! @glint-expect-error: we are not providing @label, so this is expected }}
      <CheckboxField />
    </template>);
  });
});
