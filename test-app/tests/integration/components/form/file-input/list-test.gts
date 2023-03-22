/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import List from '@crowdstrike/ember-toucan-core/components/form/file-input/list';
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

module('Integration | Component | Form | FileInput | List', function (hooks) {
  setupRenderingTest(hooks);

  const file1 = createFile(['Beef patty'], { name: 'BeefPatty.txt' });
  const file2 = createFile(['Dosa'], { name: 'Dosa.txt' });

  test('it renders', async function (assert) {
    const files = [file1, file2];

    function onDelete(file: File, event: Event | InputEvent) {
      console.info('onDelete', file, event);
    }

    await render(<template>
      <List
        @deleteLabel="Delete File"
        @onDelete={{onDelete}}
        @files={{files}}
      />
    </template>);

    assert.dom('ul').exists();
    assert.dom('li:first-child').exists();
    assert.dom('li:nth-child(2)').exists();
    assert.dom('button').exists();
    assert.dom('li:first-child [data-file-name]').hasText('BeefPatty.txt');
    assert.dom('li:nth-child(2) [data-file-name]').hasText('Dosa.txt');
  });
});
