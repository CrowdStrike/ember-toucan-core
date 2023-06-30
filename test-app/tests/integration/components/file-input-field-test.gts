/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { tracked } from '@glimmer/tracking';
import { find, render, setupOnerror, triggerEvent } from '@ember/test-helpers';
import { module, test } from 'qunit';

import FileInputField from '@crowdstrike/ember-toucan-core/components/form/fields/file-input';
import { setupRenderingTest } from 'test-app/tests/helpers';

import type { FileEvent } from '@crowdstrike/ember-toucan-core/components/form/fields/file-input';

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

// some sample files for the "multiple" tests
const avocado = createFile(['Upload file sample'], {
  name: 'avocado.txt',
  type: 'text/plain',
});

const banana = createFile(['Upload file sample'], {
  name: 'banana.txt',
  type: 'text/plain',
});

module('Integration | Component | Fields | FileInput', function (hooks) {
  setupRenderingTest(hooks);

  function onChange() {
    console.info('onChange');
  }

  test('it renders', async function (assert) {
    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @onChange={{onChange}}
        data-file-input-field
      />
    </template>);

    assert.dom('[data-label]').hasText('Label');
    assert.dom('label').hasClass('text-body-and-labels');

    assert.dom('[data-trigger]').hasText('Select Files');

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

    assert.dom('[data-upload-icon]').exists();
    assert.dom('[data-lock-icon]').doesNotExist();
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @hint="Hint text"
        @onChange={{onChange}}
        data-file-input-field
      />
    </template>);

    assert.dom('[data-hint]').hasText('Hint text');
  });

  test('it renders with a hint and label block', async function (assert) {
    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @trigger="Select Files"
        @onChange={{onChange}}
        data-file-input-field
      >
        <:label><span data-label>label block content</span></:label>
        <:hint><span data-hint>hint block content</span></:hint>
      </FileInputField>
    </template>);

    assert.dom('[data-hint]').hasText('hint block content');
    assert.dom('[data-label]').hasText('label block content');
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @error="Error text"
        @onChange={{onChange}}
        data-file-input-field
      />
    </template>);

    let error = find('[data-error]');

    assert.dom(error).hasText('Error text');
    assert.dom(error).hasAttribute('id');

    let errorId = error?.getAttribute('id') ?? '';

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

    assert
      .dom('[data-file-input-field]')
      .doesNotHaveClass('shadow-focusable-outline');
  });

  test('it sets the "for" attribute on the label to the "id" attribute of the file input field', async function (assert) {
    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @onChange={{onChange}}
        data-file-input-field
      />
    </template>);

    let labelFor = find('label')?.getAttribute('for') ?? '';

    assert.ok(labelFor, 'Expected the id attribute of the label to be truthy');

    assert
      .dom('[data-file-input-field]')
      .hasAttribute(
        'id',
        labelFor,
        'Expected the for attribute on the label to match the id attribute on the input'
      );
  });

  test('it disables the file input using `@isDisabled` and renders a lock icon', async function (assert) {
    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @isDisabled={{true}}
        @onChange={{onChange}}
        data-file-input-field
      />
    </template>);

    assert.dom('[data-file-input-field]').isDisabled();
    assert.dom('[data-file-input-field]').hasClass('text-disabled');

    assert.dom('[data-lock-icon]').exists();
    assert.dom('[data-upload-icon]').doesNotExist();

    assert.dom('label').hasClass('text-disabled');
  });

  test('it sets readonly on the input using `@isReadOnly` and renders a lock icon', async function (assert) {
    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @isReadOnly={{true}}
        @onChange={{onChange}}
        data-file-input-field
      />
    </template>);

    assert.dom('[data-file-input-field]').hasAttribute('readonly');

    assert.dom('[data-lock-icon]').exists();
    assert.dom('[data-upload-icon]').doesNotExist();
  });

  test('it spreads attributes to the underlying file-input-field', async function (assert) {
    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @onChange={{onChange}}
        placeholder="Placeholder text"
        data-file-input-field
      />
    </template>);

    assert
      .dom('[data-file-input-field]')
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it can accept a file using @onChange and display the filename', async function (assert) {
    assert.expect(12);

    class Context {
      @tracked currentFiles: File[] = [];
    }

    let ctx = new Context();

    // Note: typescript can't tell the assert is checking the event
    // so it's complaining that the event is unused
    /* eslint-disable @typescript-eslint/no-unused-vars */
    const realOnChange = (files: File[], event: FileEvent) => {
      const [firstFile] = files;

      ctx.currentFiles = files;

      assert.ok(event, 'Expected `e` to be available as the second argument');
      assert.ok(event.target, 'Expected direct access to target from `e`');
      assert.ok(firstFile, 'Expected a single file to exist in the target');
      assert.ok(
        firstFile instanceof File,
        'Expected first file to be an instanceOf File'
      );
      assert.strictEqual(
        firstFile?.name,
        'sample.txt',
        'Expected the correct filename'
      );
      assert.strictEqual(firstFile?.size, 18, 'Expected the correct file size');
      assert.strictEqual(
        files.length,
        1,
        'Expected a single file to be uploaded'
      );
      assert.step('realOnChange');
    };

    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @onChange={{realOnChange}}
        @files={{ctx.currentFiles}}
        multiple="true"
        data-file-input-field
      />
    </template>);

    assert.verifySteps([]);

    const file = createFile(['Upload file sample'], {
      name: 'sample.txt',
      type: 'text/plain',
    });

    await triggerEvent('[data-file-input-field]', 'change', { files: [file] });

    assert.verifySteps(['realOnChange']);

    assert.dom('[data-files] [data-file-name]').hasText('sample.txt');

    // currently: rounding to the nearest KB
    // this file is very small so result is 0 KB
    assert.dom('[data-files] [data-file-size]').hasText('0 KB');
  });

  test('it deletes a file', async function (assert) {
    class Context {
      @tracked currentFiles: File[] = [];
    }

    let ctx = new Context();

    const realOnChange = (files: File[]) => {
      ctx.currentFiles = files;
    };

    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @onChange={{realOnChange}}
        @files={{ctx.currentFiles}}
        multiple="true"
        data-file-input-field
      />
    </template>);

    const file = createFile(['Upload file sample'], {
      name: 'sample.txt',
      type: 'text/plain',
    });

    // Verify no files
    assert.dom('[data-files]').doesNotExist();

    await triggerEvent('[data-file-input-field]', 'change', { files: [file] });

    // Verify files are there
    assert.dom('[data-files]').exists();
    await triggerEvent('[data-delete-file]', 'click');

    // Verify the `ul` is gone as all files are deleted
    assert.dom('[data-files]').doesNotExist();
  });

  test('it can handle the multiple attribute correctly when multiple=false', async function (assert) {
    class Context {
      @tracked currentFiles: File[] | [] = [];
      @tracked triggerText = '';
    }

    let ctx = new Context();

    ctx.triggerText = 'Browse Files';

    const realOnChange = (files: File[]) => {
      ctx.currentFiles = files;

      if (ctx.currentFiles.length > 0) {
        ctx.triggerText = 'Replace files';
      }
    };

    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger={{ctx.triggerText}}
        @onChange={{realOnChange}}
        @files={{ctx.currentFiles}}
        @multiple={{false}}
        data-file-input-field
      />
    </template>);

    assert.dom('[data-file-input-field]').doesNotHaveAttribute('multiple');

    await triggerEvent('[data-file-input-field]', 'change', {
      files: [avocado, banana],
    });
    assert.dom('ul').exists('List of files exist');
    assert.dom('li').exists({ count: 1 }, 'A single list item exists');
    assert.dom('li [data-file-name]').hasText('avocado.txt');

    // replace with the banana.txt file
    await triggerEvent('[data-file-input-field]', 'change', {
      files: [banana],
    });

    assert
      .dom('li [data-file-name]')
      .hasText('banana.txt', 'Without multiple, files are replaced');
    assert
      .dom('[data-trigger]')
      .hasText(
        'Replace files',
        'For single file input field, trigger text indicates a replace'
      );
  });

  test('it can handle the multiple attribute correctly when multiple=true', async function (assert) {
    class Context {
      @tracked currentFiles: File[] | [] = [];
    }

    let ctx = new Context();

    const realOnChange = (files: File[], event: FileEvent) => {
      ctx.currentFiles = files;
    };

    ctx.currentFiles = [banana];

    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @onChange={{realOnChange}}
        @files={{ctx.currentFiles}}
        @multiple={{true}}
        data-file-input-field
      />
    </template>);

    assert.dom('[data-file-input-field]').hasAttribute('multiple');
    assert.dom('li').exists({ count: 1 }, 'A single list item exists');

    await triggerEvent('[data-file-input-field]', 'change', {
      files: [avocado, banana],
    });

    assert.dom('ul').exists('List of files exist');
    assert
      .dom('li')
      .exists(
        { count: 3 },
        'Three list items exist, two were added to the original item'
      );

    // banana.txt existed from before, then avocado.txt and banana.txt are added to the list
    assert.dom('ul > li:nth-child(1) [data-file-name]').hasText('banana.txt');
    assert
      .dom('ul > li:nth-child(2) [data-file-name]')
      .hasText('avocado.txt', 'With multiple, files are additive');
    assert.dom('ul > li:nth-child(3) [data-file-name]').hasText('banana.txt');
  });

  test('it applies the provided @rootTestSelector to the data-root-field attribute', async function (assert) {
    await render(<template>
      <FileInputField
        @deleteLabel="Delete File"
        @label="Label"
        @trigger="Select Files"
        @onChange={{onChange}}
        @rootTestSelector="selector"
        data-file-input-field
      />
    </template>);

    assert.dom('[data-root-field="selector"]').exists();
  });

  test('it throws an assertion error if there is no @label or :label', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes(
          'Assertion Failed: You need either :label or @label'
        ),
        'Expected assertion error message'
      );
    });

    await render(<template>
      <FileInputField
        @deleteLabel="Delete file"
        @trigger="Select Files"
        @onChange={{onChange}}
      />
    </template>);
  });

  test('it throws an assertion error if both `@label` and `:label` are provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes(
          'Assertion Failed: You can have :label or @label, but not both'
        ),
        'Expected assertion error message'
      );
    });

    await render(<template>
      <FileInputField
        @deleteLabel="Delete file"
        @trigger="Select Files"
        @label="Label"
        @onChange={{onChange}}
      >
        <:label>Hello</:label>
      </FileInputField>
    </template>);
  });

  test('it throws an assertion error if no @trigger is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('A "@trigger" argument is required'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      {{! @glint-expect-error: we are not providing @label, so this is expected }}
      <FileInputField
        @onChange={{onChange}}
        @label="Label"
        @deleteLabel="Delete File"
      />
    </template>);
  });

  test('it throws an assertion error if no @deleteLabel is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('A "@deleteLabel" argument is required'),
        'Expected assertion error message'
      );
    });

    await render(<template>
      {{! @glint-expect-error: we are not providing @label, so this is expected }}
      <FileInputField
        @onChange={{onChange}}
        @label="Label"
        @trigger="Select Files"
      />
    </template>);
  });
});
