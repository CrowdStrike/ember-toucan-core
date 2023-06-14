/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { currentURL, visit } from '@ember/test-helpers';
import { module, test } from 'qunit';
import { setupApplicationTest } from 'ember-qunit';

module('Acceptance | Button', function (hooks) {
  setupApplicationTest(hooks);

  test('visiting the button page', async function (assert) {
    await visit('/docs/components/button');
    assert.strictEqual(currentURL(), '/docs/components/button');
  });
});
