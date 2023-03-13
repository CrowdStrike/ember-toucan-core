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

import type { FileEvent } from '@crowdstrike/ember-toucan-core/components/form/file-input-field';

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

type Options = {
  name: string;
  type?: string;
};

module('Integration | Component | FileInputField', function (hooks) {
  setupRenderingTest(hooks);

  function onChange(event: FileEvent) { 
    console.info('onChange', event.target?.files);
  }

  test('it renders', async function (assert) {
    await render(<template>
      <FileInputField @label="Label" @onChange={{onChange}} data-file-input-field />
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
      <FileInputField @label="Label" @hint="Hint text" @onChange={{onChange}} data-file-input-field />
    </template>);

    // For the file input field component, the only aria-describedby
    // value should be the errorId.  This is due to the way the component
    // is structured, where the label+hint are rendered inside of the
    // wrapping <label> element
    const hint = find('[data-hint]');

    assert.dom(hint).hasText('Hint text');
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        @error="Error text"
        @onChange={{onChange}}
        data-file-input-field
      />
    </template>);

    let error = find('[data-error]');

    assert.dom(error).hasText('Error text');
    assert.dom(error).hasAttribute('id');

    let errorId = error?.getAttribute('id') || '';
    assert.ok(errorId, 'Expected errorId to be truthy');

    // For the file input field component, the only aria-describedby
    // value should be the errorId.  This is due to the way the component
    // is structured, where the label+hint are rendered inside of the
    // wrapping <label> element
    let describedby =
      find('[data-file-input-field]')?.getAttribute('aria-describedby') ?? '';
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


  test('it sets the "for" attribute on the label to the "id" attribute of the file input field', async function (assert) {
    await render(<template>
      <FileInputField @label="Label" @onChange={{onChange}} data-file-input-field />
    </template>);

    let labelFor = find('label')?.getAttribute('for') || '';
    assert.ok(labelFor, 'Expected the id attribute of the label to be truthy');

    assert
      .dom('[data-file-input-field]')
      .hasAttribute(
        'id',
        labelFor,
        'Expected the for attribute on the label to match the id attribute on the checkbox'
      );
  });

  test('it disables the file input using @isDisabled', async function (assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        @isDisabled={{true}}
        @onChange={{onChange}}
        data-file-input-field
      />
    </template>);

    assert.dom('[data-file-input-field]').isDisabled();
    assert.dom('[data-file-input-field]').hasClass('text-disabled');
  });
 
  test('it spreads attributes to the underlying input', async function (assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        @onChange={{onChange}}
        placeholder="Placeholder text"
        data-file-input-field
      />
    </template>);

    assert
      .dom('[data-file-input-field]')
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it can upload a file and display the filename', async function (assert) {
    let currentFiles: File[] = [];
    const realOnChange = (event: FileEvent) => {
      if (event.target?.files) {
        currentFiles = [...event.target.files]; 
      }
    }

    await render(<template>
      <FileInputField @label="Label" @onChange={{realOnChange}} @files={{currentFiles}} data-file-input-field />
    </template>);

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
    assert.expect(8);

    let currentFiles: File[] = [];
    
    const handleChange = (e: FileEvent) => {
      let firstFile, firstFileName, filesLength;
      if (e.target?.files) {
        currentFiles = [...e.target.files]; 
         firstFile = e.target.files[0] ?? null;
         firstFileName = firstFile?.name ?? '';
         filesLength = e.target.files.length;
      }
      assert.ok(e, 'Expected `e` to be available as the only argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.ok(firstFile, 'Expected a single file to exist in the target');
      assert.strictEqual(firstFileName, 'sample.txt', 'Expected the correct filename');
      assert.strictEqual(filesLength, 1, 'Expected a single file to be uploaded');
      assert.step('handleChange');
      
    };

    await render(<template>
      <FileInputField
        @label="Label"
        @onChange={{handleChange}}
        @files={{currentFiles}}
        data-file-input-field
      />
    </template>);

    assert.verifySteps([]);

    const file = createFile(['Upload file sample'], {
      name: 'sample.txt',
      type: 'text/plain',
    });

    triggerEvent('[data-file-input-field]', 'change', { files: [file] });

    await settled();

    assert.verifySteps(['handleChange']);
  });

  test('it deletes a file', async function(assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        @onChange={{onChange}}
        data-file-input-field
      />
    </template>);

    const file = createFile(['Upload file sample'], {
      name: 'sample.txt',
      type: 'text/plain',
    });

    triggerEvent('[data-file-input-field]', 'change', { files: [file] });

    await settled();

    triggerEvent('button', 'click');
    
    await settled();

    assert.dom('ul').doesNotExist();
  });

  test('it applies the provided @rootTestSelector to the data-root-field attribute', async function (assert) {
    await render(<template>
      <FileInputField
        @label="Label"
        @onChange={{onChange}}
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
      <FileInputField @onChange={{onChange}} />
    </template>);
  });
});
