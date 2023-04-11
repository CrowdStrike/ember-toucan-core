/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | ToucanForm', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><ToucanForm data-toucan-form /></template>);

    assert.dom('[data-toucan-form]').exists();
    assert.dom('[data-toucan-form]').hasTagName('form');
  });

  test('it allows consumers to render their own components', async function (assert) {
    await render(<template>
      <ToucanForm>
        <div data-custom-content />
      </ToucanForm>
    </template>);

    assert.dom('[data-custom-content]').exists();
  });

  test('it yields a Textarea component', async function (assert) {
    await render(<template>
      <ToucanForm as |form|>
        <form.Textarea @label="Textarea" @name="textarea" data-textarea />
      </ToucanForm>
    </template>);

    assert.dom('[data-textarea]').exists();
    assert.dom('[data-textarea]').hasTagName('textarea');
  });
});
