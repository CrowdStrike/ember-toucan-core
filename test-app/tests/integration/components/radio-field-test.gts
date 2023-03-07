/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import { click, find, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import RadioField from '@crowdstrike/ember-toucan-core/components/form/radio-field';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | RadioField', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @rootTestSelector="test"
        data-radio
      />
    </template>);

    assert.dom('[data-label]').hasText('Label');

    assert
      .dom('[data-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided'
      );

    assert.dom('[data-radio]').hasTagName('input');
    assert.dom('[data-radio]').hasAttribute('id');
    assert.dom('[data-radio]').hasNoAttribute('aria-invalid');

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected error block not to be displayed as an error was not provided'
      );
    assert.dom('[data-control]').hasNoClass('shadow-error-outline');
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <RadioField @value="option" @label="Label" @hint="Hint text" data-radio />
    </template>);

    assert.dom('[data-hint]').hasText('Hint text');
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @error="Error text"
        @rootTestSelector="test"
        data-radio
      />
    </template>);

    let error = find('[data-error]');

    assert.dom(error).hasText('Error text');
    assert.dom(error).hasAttribute('id');

    let errorId = error?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected errorId to be truthy');

    // For the radio-field component, the only aria-describedby
    // value should be the errorId.  This is due to the way the component
    // is structured, where the label+hint are rendered inside of the
    // wrapping <label> element
    let describedby =
      find('[data-radio]')?.getAttribute('aria-describedby') || '';
    assert.ok(
      describedby.includes(errorId),
      'Expected errorId to be included in the aria-describedby'
    );

    assert.dom('[data-radio]').hasAttribute('aria-invalid', 'true');
  });

  test('it sets the "for" attribute on the label to the "id" attribute of the radio', async function (assert) {
    await render(<template>
      <RadioField @value="option" @label="Label" data-radio />
    </template>);

    let labelFor = find('[data-control] > label')?.getAttribute('for') || '';
    assert.ok(labelFor, 'Expected the id attribute of the label to be truthy');

    assert
      .dom('[data-radio]')
      .hasAttribute(
        'id',
        labelFor,
        'Expected the for attribute on the label to match the id attribute on the radio'
      );
  });

  test('it disables the radio using `@isDisabled`', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @isDisabled={{true}}
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').isDisabled();
  });

  test('it spreads attributes to the underlying radio', async function (assert) {
    await render(<template>
      <RadioField @value="option" @label="Label" name="radio-name" data-radio />
    </template>);

    assert.dom('[data-radio]').hasAttribute('name', 'radio-name');
  });

  test('it sets the checked-state via `@isChecked`', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @isChecked={{true}}
        data-radio
      />
    </template>);

    assert.dom('[data-radio]').isChecked();
  });

  test('it calls `@onChange` when clicked with the expected checked state', async function (assert) {
    assert.expect(7);

    let handleChange = (value: string, e: Event | InputEvent) => {
      assert.strictEqual(value, 'option', 'Expected value to matched');
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.step('handleChange');
    };

    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @onChange={{handleChange}}
        data-radio
      />
    </template>);

    assert.verifySteps([]);

    await click('[data-radio]');

    assert.verifySteps(['handleChange']);

    assert.dom('[data-radio]').isChecked();
  });

  test('it applies the provided `@rootTestSelector` to the data-root-field attribute', async function (assert) {
    await render(<template>
      <RadioField
        @value="option"
        @label="Label"
        @rootTestSelector="selector"
        data-radio
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
      <RadioField @value="option" />
    </template>);
  });

  test('it throws an assertion error if no `@value` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('A "@value" argument is required'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      {{! @glint-expect-error: we are not providing @value, so this is expected }}
      <RadioField @label="Label" />
    </template>);
  });
});
