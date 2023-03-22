/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { render, triggerEvent } from '@ember/test-helpers';
import { module, test } from 'qunit';

import DeleteButton from '@crowdstrike/ember-toucan-core/components/form/file-input/delete-button';
import { setupRenderingTest } from 'test-app/tests/helpers';

// note: linter complains about importing this from another test
type Options = {
  name: string;
  type?: string;
};

// https://medium.com/@chrisdmasters/acceptance-testing-file-uploads-in-ember-2-5-1c9c8dbe5368
export function createFile(
  content = ['Some sample content'],
  options: Options = { name: '', type: '' }
) {
  const { name, type } = options;

  const file = new File(content, name, {
    type: type ? type : 'text/plain',
  });

  return file;
}

module(
  'Integration | Component | Form | FileInput | DeleteButton',
  function (hooks) {
    setupRenderingTest(hooks);

    const file = createFile();

    test('it renders', async function (assert) {
      assert.expect(8);

      function onDelete(file: File, event: Event | InputEvent) {
        assert.ok(file);
        assert.ok(event);
        assert.strictEqual(file.name, '', 'File has correct name');
        assert.strictEqual(file.size, 19, 'File has the correct size');
        assert.step('onDelete');
      }

      await render(<template>
        <DeleteButton
          @deleteLabel="Delete File"
          @onDelete={{onDelete}}
          @file={{file}}
        />
      </template>);
      assert.dom('button').exists();

      assert.verifySteps([]);

      await triggerEvent('button', 'click', { file });

      assert.verifySteps(['onDelete']);
    });
  }
);
