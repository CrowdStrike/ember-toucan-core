/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';
import { setupRenderingTest } from 'test-app/tests/helpers';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';

interface TestData {
  text?: string;
}

module('Integration | Component | ToucanForm | Input', function (hooks) {
  setupRenderingTest(hooks);

  test('it sets the readonly attribute with `@isReadOnly`', async function (assert) {
    const data: TestData = {
      text: 'text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Input
          @label="Text"
          @name="text"
          @isReadOnly={{true}}
          data-input
        />
      </ToucanForm>
    </template>);

    assert.dom('[data-input]').hasAttribute('readonly');
  });
});
