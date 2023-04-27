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
  });

});
