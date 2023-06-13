/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import FileInput from '@crowdstrike/ember-toucan-core/components/form/controls/file-input';
import { setupRenderingTest } from 'test-app/tests/helpers';

module(
  'Integration | Component | Form | Controls | FileInput',
  function (hooks) {
    setupRenderingTest(hooks);

    test('it renders', async function (assert) {
      await render(<template>
        <FileInput @trigger="Select Files" data-input />
      </template>);

      assert.dom('[data-input]').exists();

      assert.dom('[data-input]').hasNoAttribute('readonly');
    });

    test('it sets readonly on the input using `@isReadOnly`', async function (assert) {
      await render(<template>
        <FileInput @trigger="Select Files" @isReadOnly={{true}} data-input />
      </template>);

      assert.dom('[data-input]').hasAttribute('readonly');
    });
  }
);
