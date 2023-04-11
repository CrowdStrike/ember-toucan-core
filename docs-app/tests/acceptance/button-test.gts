/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { module, test } from 'qunit';
import { click, visit, currentURL } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';


module('Acceptance | Button', function (hooks) {
  setupApplicationTest(hooks);

  test('visiting the button page', async function (assert) {

    await visit('/docs/components/button')
    assert.strictEqual(currentURL(), '/docs/components/button');

    assert.dom('h1').hasText('Button');
    assert.dom('.docfy-demo__example').hasTagName('div');

    assert.dom('.docfy-demo__example button').hasText('Button');

    // the link after button is the checkbox page
    await click('ul li:nth-child(2) ul li:nth-child(2) a')
    assert.strictEqual(currentURL(), '/docs/components/checkbox');
  });

});
