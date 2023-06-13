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
      assert.dom('[data-input]').hasNoAttribute('multiple');

      // Verify defaults
      assert.dom('[data-input]').hasAttribute('type', 'file');
      assert.dom('[data-input]').hasAttribute('accept', '*');
    });

    test('it sets readonly on the input using `@isReadOnly`', async function (assert) {
      await render(<template>
        <FileInput @trigger="Select Files" @isReadOnly={{true}} data-input />
      </template>);

      assert.dom('[data-input]').hasAttribute('readonly');
    });

    test('it sets disabled on the input using `@isDisabled`', async function (assert) {
      await render(<template>
        <FileInput @trigger="Select Files" @isDisabled={{true}} data-input />
      </template>);

      assert.dom('[data-input]').isDisabled();
    });

    test('it sets accept on the input using `@accept`', async function (assert) {
      await render(<template>
        <FileInput @trigger="Select Files" @accept="image/png" data-input />
      </template>);

      assert.dom('[data-input]').hasAttribute('accept', 'image/png');
    });

    test('it sets the multiple attribute on the input using `@multiple`', async function (assert) {
      await render(<template>
        <FileInput @trigger="Select Files" @multiple={{true}} data-input />
      </template>);

      assert.dom('[data-input]').hasAttribute('multiple');
    });
  }
);
