/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { module, test } from 'qunit';
import { visit, currentURL } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';

module('Acceptance | Button', function (hooks) {
  setupApplicationTest(hooks);

  test('visiting the button page', async function (assert) {

    await visit('/docs/components/button')
    assert.strictEqual(currentURL(), '/docs/components/button');
  });

});
