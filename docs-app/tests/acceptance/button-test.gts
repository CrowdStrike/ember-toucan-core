/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { module, test } from 'qunit';
import { click, visit, currentURL } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';
import sinon from 'sinon';
import chai, {expect } from 'chai';
import sinonChai from 'sinon-chai';

module('Acceptance | Button', function (hooks) {
  setupApplicationTest(hooks);
  chai.use(sinonChai);

  let consoleSpy: sinon.SinonStub;

   hooks.beforeEach(function() {
    consoleSpy = sinon.stub(console, 'error');
  });

  hooks.afterEach(function() {
    sinon.restore();
  });

  test('visiting the button page', async function (assert) {

    await visit('/docs/components/button')
    assert.strictEqual(currentURL(), '/docs/components/button');

    assert.dom('h1').hasText('Button');
    assert.dom('.docfy-demo__example').hasTagName('div');

    assert.dom('.docfy-demo__example button').hasText('Button');

    expect(consoleSpy).to.not.be.called;
    // the link after button is the checkbox page
    await click('ul li:nth-child(2) ul li:nth-child(2) a')
    assert.strictEqual(currentURL(), '/docs/components/checkbox');
  });

});
