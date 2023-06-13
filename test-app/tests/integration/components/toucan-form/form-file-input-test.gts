/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';
import { setupRenderingTest } from 'test-app/tests/helpers';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';

const testFile = new File(['Some sample content'], 'file.txt', {
  type: 'text/plain',
});

interface TestData {
  files?: File[];
}

module('Integration | Component | ToucanForm | FileInput', function (hooks) {
  setupRenderingTest(hooks);

  test('it sets the readonly attribute with `@isReadOnly`', async function (assert) {
    const data: TestData = {
      files: [testFile],
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.FileInput
          @label="Files"
          @name="files"
          @isReadOnly={{true}}
          @deleteLabel="Delete"
          @trigger="Select files"
          data-file-input
        />
      </ToucanForm>
    </template>);

    assert.dom('[data-file-input]').hasAttribute('readonly');
  });

  test('it renders `@label` and `@hint` component arguments', async function (assert) {
    const data: TestData = {
      files: [testFile],
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.FileInput
          @label="Files"
          @hint="Hint"
          @name="files"
          @isReadOnly={{true}}
          @deleteLabel="Delete"
          @trigger="Select files"
          data-file-input
        />
      </ToucanForm>
    </template>);

    assert.dom('[data-label]').exists();
    assert.dom('[data-hint]').exists();
  });

  test('it renders a `:label` named block with a `@hint` argument', async function (assert) {
    const data: TestData = {
      files: [testFile],
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.FileInput
          @hint="Hint"
          @name="files"
          @isReadOnly={{true}}
          @deleteLabel="Delete"
          @trigger="Select files"
          data-file-input
        >
          <:label><span data-label-block>Label</span></:label>
        </form.FileInput>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();

    // NOTE: `data-hint` comes from `@hint`.
    assert.dom('[data-hint]').exists();
    assert.dom('[data-hint]').hasText('Hint');
  });

  test('it renders a `:hint` named block with a `@label` argument', async function (assert) {
    const data: TestData = {
      files: [testFile],
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.FileInput
          @label="Label"
          @name="files"
          @isReadOnly={{true}}
          @deleteLabel="Delete"
          @trigger="Select files"
          data-file-input
        >
          <:hint><span data-hint-block>Hint</span></:hint>
        </form.FileInput>
      </ToucanForm>
    </template>);

    // NOTE: `data-label` comes from `@label`.
    assert.dom('[data-label]').exists();
    assert.dom('[data-label]').hasText('Label');

    assert.dom('[data-hint-block]').exists();
  });

  test('it renders both a `:label` and `:hint` named block', async function (assert) {
    const data: TestData = {
      files: [testFile],
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.FileInput
          @name="files"
          @isReadOnly={{true}}
          @deleteLabel="Delete"
          @trigger="Select files"
          data-file-input
        >
          <:label><span data-label-block>Label</span></:label>
          <:hint><span data-hint-block>Hint</span></:hint>
        </form.FileInput>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();
    assert.dom('[data-hint-block]').exists();
  });
});