/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import {
  render,
} from '@ember/test-helpers'
import { module, test } from 'qunit';

import FileInput from '@crowdstrike/ember-toucan-core/components/form/controls/file-input';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Form | Controls | FileInput', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <FileInput
        @trigger='Select Files'
        />
    </template>);

    assert.dom('input').exists();
    assert.dom('[data-trigger]').hasText('Select Files');
  });
});
