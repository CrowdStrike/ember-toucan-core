/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import {
  find,
  render,
  settled,
  setupOnerror,
  triggerEvent,
} from '@ember/test-helpers';
import { module, test } from 'qunit';

import FileInputField from '@crowdstrike/ember-toucan-core/components/form/file-input-field';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | FileInputField', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <FileInputField @label="Label" data-file-input-field />
    </template>);

    assert.dom('[data-label]').hasText('Label');

    assert
      .dom('[data-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided'
      );

    assert.dom('[data-file-input-field]').hasTagName('input');
    assert.dom('[data-file-input-field]').hasAttribute('id');
    assert
      .dom('[data-file-input-field]')
      .hasClass('text-titles-and-attributes');

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected hint block not to be displayed as an error was not provided'
      );
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <FileInputField @label="Label" @hint="Hint text" data-file-input-field />
    </template>);

    const hint = find('[data-hint]');

    assert.dom(hint).hasText('Hint text');
    assert.dom(hint).hasAttribute('id');

    const hintId = hint?.getAttribute('id') || '';
    assert.ok(hintId, 'Expected hintId to be truthy');

    const describedby =
      find('[data-file-input-field]')?.getAttribute('aria-describedby') || '';
    assert.ok(
      describedby.includes(hintId),
      'Expected hintId to be included in the aria-describedby'
    );
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        @error="Error text"
        data-file-input-field
      />
    </template>);

    let error = find('[data-error]');

    assert.dom(error).hasText('Error text');
    assert.dom(error).hasAttribute('id');

    let errorId = error?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected errorId to be truthy');

    let describedby =
      find('[data-file-input-field]')?.getAttribute('aria-describedby') || '';
    assert.ok(
      describedby.includes(errorId),
      'Expected errorId to be included in the aria-describedby'
    );

    assert.dom('[data-file-input-field]').hasAttribute('aria-invalid', 'true');

    assert.dom('[data-file-input-field]').hasClass('shadow-error-outline');
    assert
      .dom('[data-file-input-field]')
      .doesNotHaveClass('shadow-focusable-outline');
  });

  test('it sets aria-describedby when both a hint and error are provided using the hint and error ids', async function (assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        @error="Error text"
        @hint="Hint text"
        data-textarea
      />
    </template>);

    let errorId = find('[data-error]')?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected errorId to be truthy');

    let hintId = find('[data-hint]')?.getAttribute('id') || '';
    assert.ok(hintId, 'Expected hintId to be truthy');

    assert
      .dom('[data-textarea]')
      .hasAttribute('aria-describedby', `${errorId} ${hintId}`);
  });

  test('it disables the file input using @isDisabled', async function (assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        @isDisabled={{true}}
        data-file-input-field
      />
    </template>);

    assert.dom('[data-file-input-field]').isDisabled();
    assert.dom('[data-file-input-field]').hasClass('text-disabled');
  });

  test('it spreads attributes to the underlying textarea', async function (assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        placeholder="Placeholder text"
        data-file-input-field
      />
    </template>);

    assert
      .dom('[data-file-input-field]')
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it can upload a file and display the filename', async function (assert) {
    await render(<template>
      <FileInputField @label="Label" data-file-input-field />
    </template>);

    type Options = {
      name: string;
      type?: string;
    };
    // https://medium.com/@chrisdmasters/acceptance-testing-file-uploads-in-ember-2-5-1c9c8dbe5368
    function createFile(
      content = ['Some sample content'],
      options: Options = { name: '', type: '' }
    ) {
      const { name, type } = options;

      const file = new File(content, name, {
        type: type ? type : 'text/plain',
      });

      return file;
    }

    const file = createFile(['Upload file sample'], {
      name: 'sample.txt',
      type: 'text/plain',
    });

    triggerEvent('[data-file-input-field]', 'change', { files: [file] });

    await settled();

    assert.dom('[data-files] [data-file-name]').hasText('sample.txt');
    // currently: rounding to the nearest KB
    // this file is very small so result is 0 KB
    assert.dom('[data-files] [data-file-size]').hasText('0 KB');
  });

  test('it calls @onChange when input is received', async function (assert) {
    type Options = {
      name: string;
      type?: string;
    };
    assert.expect(6);

    let handleChange = (files: FileList, e: Event | InputEvent) => {
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.strictEqual(files.length, 1, 'Expected a single file to be uploaded');
      assert.step('handleChange');
    };

    await render(<template>
      <FileInputField
        @label="Label"
        @onChange={{handleChange}}
        data-file-input-field
      />
    </template>);

    assert.verifySteps([]);

    // https://medium.com/@chrisdmasters/acceptance-testing-file-uploads-in-ember-2-5-1c9c8dbe5368
    function createFile(
      content = ['Some sample content'],
      options: Options = { name: '', type: '' }
    ) {
      const { name, type } = options;

      const file = new File(content, name, {
        type: type ? type : 'text/plain',
      });

      return file;
    }

    const file = createFile(['Upload file sample'], {
      name: 'sample.txt',
      type: 'text/plain',
    });

    triggerEvent('[data-file-input-field]', 'change', { files: [file] });

    await settled();

    assert.verifySteps(['handleChange']);
  });

  test('it applies the provided @rootTestSelector to the data-root-field attribute', async function (assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        @rootTestSelector="selector"
        data-file-input-field
      />
    </template>);

    assert.dom('[data-root-field="selector"]').exists();
  });

  test('it throws an assertion error if no @label is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('A "@label" argument is required'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      {{! @glint-expect-error: we are not providing @label, so this is expected }}
      <FileInputField />
    </template>);
  });
});
