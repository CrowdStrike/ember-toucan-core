/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { click, fillIn, render } from '@ember/test-helpers';
import { module, test } from 'qunit';
import { setupRenderingTest } from 'test-app/tests/helpers';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';

import type { ErrorRecord } from 'ember-headless-form';

interface TestData {
  comment?: string;
  firstName?: string;
  radio?: string;
  termsAndConditions?: boolean;
}

module('Integration | Component | ToucanForm', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><ToucanForm data-toucan-form /></template>);

    assert.dom('[data-toucan-form]').exists();
    assert.dom('[data-toucan-form]').hasTagName('form');
  });

  test('it allows consumers to render their own components', async function (assert) {
    await render(<template>
      <ToucanForm>
        <div data-custom-content />
      </ToucanForm>
    </template>);

    assert.dom('[data-custom-content]').exists();
  });

  test('it yields a Field from ember-headless-form', async function (assert) {
    const data: { field?: string } = {};

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Field @name="field" as |field|>
          <field.Label for="test">Test</field.Label>
          <field.Input data-test-field />
        </form.Field>
      </ToucanForm>
    </template>);

    assert.dom('[data-test-field]').exists();
  });

  test('it sets the yielded component values based on `@data`', async function (assert) {
    const data: TestData = {
      comment: 'textarea',
      firstName: 'input',
      radio: 'option-2',
      termsAndConditions: true,
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @label="Comment" @name="comment" data-textarea />
        <form.Input @label="Input" @name="firstName" data-input />
        <form.Checkbox
          @label="Terms"
          @name="termsAndConditions"
          data-checkbox
        />
        <form.RadioGroup @label="Radios" @name="radio" as |group|>
          <group.RadioField @label="option-1" @value="option-1" data-radio-1 />
          <group.RadioField @label="option-2" @value="option-2" data-radio-2 />
        </form.RadioGroup>
      </ToucanForm>
    </template>);

    assert.dom('[data-textarea]').hasAttribute('name', 'comment');
    assert.dom('[data-textarea]').hasValue('textarea');

    assert.dom('[data-input]').hasAttribute('name', 'firstName');
    assert.dom('[data-input]').hasValue('input');

    assert.dom('[data-checkbox]').hasAttribute('name', 'termsAndConditions');
    assert.dom('[data-checkbox]').isChecked();

    assert.dom('[data-radio-1]').hasAttribute('name', 'radio');
    assert.dom('[data-radio-2]').hasAttribute('name', 'radio');

    assert.dom('[data-radio-1]').isNotChecked();
    assert.dom('[data-radio-2]').isChecked();
  });

  test('it triggers validation and shows error messages in the Toucan Core components', async function (assert) {
    const data: TestData = {};

    const formValidateCallback = ({
      comment,
      firstName,
      radio,
      termsAndConditions,
    }: TestData) => {
      let errors: ErrorRecord<TestData> = {};

      if (!comment) {
        errors.comment = [
          {
            type: 'required',
            value: comment,
            message: 'Comment is required',
          },
        ];
      }

      if (!firstName) {
        errors.firstName = [
          {
            type: 'required',
            value: firstName,
            message: 'First name is required',
          },
        ];
      }

      if (!radio) {
        errors.radio = [
          {
            type: 'required',
            value: radio,
            message: 'One radio must be selected',
          },
        ];
      }

      if (!termsAndConditions) {
        errors.termsAndConditions = [
          {
            type: 'required',
            value: termsAndConditions,
            message: 'Terms must be checked',
          },
        ];
      }

      return Object.keys(errors).length === 0 ? undefined : errors;
    };

    await render(<template>
      <ToucanForm @data={{data}} @validate={{formValidateCallback}} as |form|>
        <form.Textarea
          @label="Comment"
          @name="comment"
          @rootTestSelector="data-textarea-wrapper"
          data-textarea
        />

        <form.Input
          @label="First name"
          @name="firstName"
          @rootTestSelector="data-input-wrapper"
          data-input
        />

        <form.Checkbox
          @label="Terms and Conditions"
          @name="termsAndConditions"
          @rootTestSelector="data-checkbox-wrapper"
          data-checkbox
        />

        <form.RadioGroup
          @label="Radios"
          @name="radio"
          @rootTestSelector="data-radio-wrapper"
          as |group|
        >
          <group.RadioField @label="option-1" @value="option-1" data-radio-1 />
          <group.RadioField @label="option-2" @value="option-2" data-radio-2 />
        </form.RadioGroup>

        <button type="submit" data-test-submit>Submit</button>
      </ToucanForm>
    </template>);

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected no errors present since we have not submitted yet'
      );

    await click('[data-test-submit]');

    assert
      .dom('[data-error]')
      .exists('Expected errors to be triggered due to validation');

    // Verify individual error messages
    assert
      .dom('[data-root-field="data-textarea-wrapper"] [data-error]')
      .hasText('Comment is required');
    assert
      .dom('[data-root-field="data-input-wrapper"] [data-error]')
      .hasText('First name is required');
    assert
      .dom('[data-root-field="data-checkbox-wrapper"] [data-error]')
      .hasText('Terms must be checked');
    assert
      .dom('[data-root-field="data-radio-wrapper"] [data-error]')
      .hasText('One radio must be selected');

    // Satisfy the validation and submit the form
    await fillIn('[data-textarea]', 'A comment.');
    await fillIn('[data-input]', 'CrowdStrike');
    await click('[data-test-submit]');
    await click('[data-checkbox]');
    await click('[data-radio-2]');

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected errors to be removed due to satisfying validation'
      );
  });
});
