/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { on } from '@ember/modifier';
import {
  click,
  fillIn,
  render,
  triggerEvent,
  triggerKeyEvent,
} from '@ember/test-helpers';
import { module, test } from 'qunit';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';
import { setupRenderingTest } from 'test-app/tests/helpers';

import type { ErrorRecord } from 'ember-headless-form';

const testFile = new File(['Some sample content'], 'file.txt', {
  type: 'text/plain',
});

const options = ['blue', 'red', 'yellow'];

interface TestData {
  autocomplete?: string;
  checkboxes?: string[];
  comment?: string;
  files?: File[];
  firstName?: string;
  multiselect?: string[];
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

  test('it yields `submit` from ember-headless-form', async function (assert) {
    interface FormData {
      name?: string;
      email?: string;
    }

    assert.expect(3);

    const data: FormData = {};

    const handleSubmit = (data: FormData) => {
      assert.deepEqual(
        data,
        { name: 'text', email: 'a@b.com' },
        'Expected form data to match'
      );
      assert.step('onSubmit');
    };

    await render(<template>
      <ToucanForm @data={{data}} @onSubmit={{handleSubmit}} as |form|>
        <form.Input @label="Input" @name="name" data-name />
        <form.Input @label="Email" @name="email" data-email />

        <button
          type="button"
          data-test-submit
          {{on "click" form.submit}}
        >Submit</button>
      </ToucanForm>
    </template>);

    await fillIn('[data-name]', 'text');
    await fillIn('[data-email]', 'a@b.com');

    await click('[data-test-submit]');

    assert.verifySteps(['onSubmit']);
  });

  test('it yields `reset` from ember-headless-form', async function (assert) {
    interface FormData {
      name?: string;
      email?: string;
    }

    const data: FormData = {
      name: 'Simon',
      email: 'a@b.com',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Input @label="Input" @name="name" data-name />
        <form.Input @label="Email" @name="email" data-email />

        <button
          type="button"
          data-test-reset
          {{on "click" form.reset}}
        >Submit</button>
      </ToucanForm>
    </template>);

    await fillIn('[data-name]', 'Nicole');
    await fillIn('[data-email]', 'x@yz.com');

    await click('[data-test-reset]');

    assert.dom('[data-name]').hasValue('Simon');
    assert.dom('[data-email]').hasValue('a@b.com');
  });

  test('it sets the yielded component values based on `@data`', async function (assert) {
    const data: TestData = {
      autocomplete: 'blue',
      checkboxes: ['option-1', 'option-3'],
      comment: 'multi-line text',
      files: [testFile],
      firstName: 'single line text',
      multiselect: ['red', 'yellow'],
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

        <form.CheckboxGroup @label="Checkboxes" @name="checkboxes" as |group|>
          <group.CheckboxField
            @label="Option 1"
            @value="option-1"
            data-checkbox-group-1
          />
          <group.CheckboxField
            @label="Option 2"
            @value="option-2"
            data-checkbox-group-2
          />
          <group.CheckboxField
            @label="Option 3"
            @value="option-3"
            data-checkbox-group-3
          />
        </form.CheckboxGroup>

        <form.FileInput
          @label="Files"
          @name="files"
          @trigger="Select files"
          @deleteLabel="Delete"
        />

        <form.Autocomplete
          @label="Autocomplete"
          @name="autocomplete"
          @options={{options}}
          data-autocomplete
          as |autocomplete|
        >
          <autocomplete.Option
            data-option
          >{{autocomplete.option}}</autocomplete.Option>
        </form.Autocomplete>

        <form.Multiselect
          @label="Multiselect"
          @name="multiselect"
          @options={{options}}
          data-multiselect
        >
          <:noResults>No results</:noResults>

          <:remove as |remove|>
            <remove.Remove @label="Remove" />
          </:remove>

          <:default as |multiselect|>
            <multiselect.Option>{{multiselect.option}}</multiselect.Option>
          </:default>
        </form.Multiselect>
      </ToucanForm>
    </template>);

    assert.dom('[data-textarea]').hasAttribute('name', 'comment');
    assert.dom('[data-textarea]').hasValue('multi-line text');

    assert.dom('[data-input]').hasAttribute('name', 'firstName');
    assert.dom('[data-input]').hasValue('single line text');

    assert.dom('[data-checkbox]').hasAttribute('name', 'termsAndConditions');
    assert.dom('[data-checkbox]').isChecked();

    // Radio group
    assert.dom('[data-radio-1]').hasAttribute('name', 'radio');
    assert.dom('[data-radio-2]').hasAttribute('name', 'radio');

    assert.dom('[data-radio-1]').isNotChecked();
    assert.dom('[data-radio-2]').isChecked();

    // Checkbox group
    assert.dom('[data-checkbox-group-1]').hasAttribute('name', 'checkboxes');
    assert.dom('[data-checkbox-group-2]').hasAttribute('name', 'checkboxes');
    assert.dom('[data-checkbox-group-3]').hasAttribute('name', 'checkboxes');

    assert.dom('[data-checkbox-group-1]').isChecked();
    assert.dom('[data-checkbox-group-2]').isNotChecked();
    assert.dom('[data-checkbox-group-3]').isChecked();

    // File input
    assert.dom('[data-files] [data-file-name]').hasText('file.txt');

    // Autocomplete
    assert.dom('[data-autocomplete]').hasAttribute('name', 'autocomplete');
    assert.dom('[data-autocomplete]').hasValue('blue');

    // Multiselect
    assert.dom('[data-multiselect]').hasAttribute('name', 'multiselect');
    assert.dom('[data-multiselect-selected-option]').exists({ count: 2 });

    let [firstChip, secondChip] = document.querySelectorAll(
      '[data-multiselect-selected-option]'
    );

    assert.dom(firstChip).hasText('red');
    assert.dom(secondChip).hasText('yellow');
  });

  test('it triggers validation and shows error messages in the Toucan Core components', async function (assert) {
    assert.expect(20);

    const handleSubmit = ({ files, ...data }: TestData) => {
      // Checking deep equality on files can get really tricky due
      // to properties on the File object prototype like `arrayBuffer, `lastModifiedDate`,
      // and `lastModified`.  Due to that, we will assert `files` separately from the other
      // submitted values.
      assert.ok(files, 'Expected files to be included');
      assert.strictEqual(
        files?.length,
        1,
        'Expected only a single file to be added'
      );
      assert.strictEqual(files?.[0]?.name, 'file.txt');
      assert.strictEqual(files?.[0]?.type, 'text/plain');

      // Now we assert the string/boolean based values
      assert.deepEqual(
        data,
        {
          autocomplete: 'red',
          checkboxes: ['option-2'],
          comment: 'A comment.',
          firstName: 'CrowdStrike',
          multiselect: ['blue'],
          radio: 'option-2',
          termsAndConditions: true,
        },
        'Expected test data to match selections'
      );
      assert.step('onSubmit');
    };

    const data: TestData = {};

    const formValidateCallback = ({
      autocomplete,
      checkboxes,
      comment,
      files,
      firstName,
      multiselect,
      radio,
      termsAndConditions,
    }: TestData) => {
      let errors: ErrorRecord<TestData> = {};

      if (!checkboxes) {
        errors.checkboxes = [
          {
            type: 'required',
            value: checkboxes,
            message: 'One checkbox must be selected',
          },
        ];
      }

      if (!autocomplete) {
        errors.autocomplete = [
          {
            type: 'required',
            value: autocomplete,
            message: 'One autocomplete item must be selected',
          },
        ];
      }

      if (!multiselect) {
        errors.multiselect = [
          {
            type: 'required',
            value: multiselect,
            message: 'One multiselect item must be selected',
          },
        ];
      }

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

      if (!files) {
        errors.files = [
          {
            type: 'required',
            value: files,
            message: 'A file must be added',
          },
        ];
      }

      return Object.keys(errors).length === 0 ? undefined : errors;
    };

    await render(<template>
      <ToucanForm
        @data={{data}}
        @validate={{formValidateCallback}}
        @onSubmit={{handleSubmit}}
        as |form|
      >
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

        <form.CheckboxGroup
          @label="Checkboxes"
          @name="checkboxes"
          @rootTestSelector="data-checkbox-group-wrapper"
          as |group|
        >
          <group.CheckboxField
            @label="Option 1"
            @value="option-1"
            data-checkbox-group-1
          />
          <group.CheckboxField
            @label="Option 2"
            @value="option-2"
            data-checkbox-group-2
          />
          <group.CheckboxField
            @label="Option 3"
            @value="option-3"
            data-checkbox-group-3
          />
        </form.CheckboxGroup>

        <form.FileInput
          @label="Files"
          @name="files"
          @trigger="Select files"
          @deleteLabel="Delete"
          @rootTestSelector="data-file-input-wrapper"
          data-file-input-field
        />

        <form.Autocomplete
          @label="Autocomplete"
          @name="autocomplete"
          @options={{options}}
          @rootTestSelector="data-autocomplete-wrapper"
          data-autocomplete
          as |autocomplete|
        >
          <autocomplete.Option data-option>
            {{autocomplete.option}}
          </autocomplete.Option>
        </form.Autocomplete>

        <form.Multiselect
          @label="Multiselect"
          @name="multiselect"
          @options={{options}}
          @rootTestSelector="data-multiselect-wrapper"
          data-multiselect
        >
          <:noResults>No results</:noResults>

          <:remove as |remove|>
            <remove.Remove @label="Remove" />
          </:remove>

          <:default as |multiselect|>
            <multiselect.Option>{{multiselect.option}}</multiselect.Option>
          </:default>
        </form.Multiselect>

        <button type="submit" data-test-submit>Submit</button>
      </ToucanForm>
    </template>);

    assert.verifySteps([]);

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected no errors present since we have not submitted yet'
      );

    await click('[data-test-submit]');

    // Since we have errors, we still do not expect our submit to be called
    assert.verifySteps([]);

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
    assert
      .dom('[data-root-field="data-checkbox-group-wrapper"] [data-error]')
      .hasText('One checkbox must be selected');
    assert
      .dom('[data-root-field="data-file-input-wrapper"] [data-error]')
      .hasText('A file must be added');
    assert
      .dom('[data-root-field="data-autocomplete-wrapper"] [data-error]')
      .hasText('One autocomplete item must be selected');
    assert
      .dom('[data-root-field="data-multiselect-wrapper"] [data-error]')
      .hasText('One multiselect item must be selected');

    // Satisfy the validation and submit the form
    await fillIn('[data-textarea]', 'A comment.');
    await fillIn('[data-input]', 'CrowdStrike');
    await click('[data-checkbox]');
    await click('[data-radio-2]');
    await click('[data-checkbox-group-2]');
    await triggerEvent('[data-file-input-field]', 'change', {
      files: [testFile],
    });
    await fillIn('[data-autocomplete]', 'red');
    await triggerKeyEvent('[data-autocomplete]', 'keydown', 'Enter');
    await fillIn('[data-multiselect]', 'blue');
    await triggerKeyEvent('[data-multiselect]', 'keydown', 'Enter');

    await click('[data-test-submit]');

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected errors to be removed due to satisfying validation'
      );

    assert.verifySteps(['onSubmit']);
  });
});
