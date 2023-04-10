import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';
import { hbs } from 'ember-cli-htmlbars';
import { setupRenderingTest } from 'docs-app/tests/helpers';

module('Integration | Docs | Button (base-demo)', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(
      hbs`<DocfyDemoComponentsButtonBaseDemo />`);

      assert.dom('button').hasText('Button');
  });

});
