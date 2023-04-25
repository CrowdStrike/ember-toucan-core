/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';
import { setupRenderingTest } from 'test-app/tests/helpers';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';

interface TestData {
  text?: string;
}

module('Integration | Component | ToucanForm | Textarea', function (hooks) {
  setupRenderingTest(hooks);

  test('it sets the readonly attribute with `@isReadOnly`', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea
          @label="Text"
          @name="text"
          @isReadOnly={{true}}
          data-textarea
        />
      </ToucanForm>
    </template>);

    assert.dom('[data-textarea]').hasAttribute('readonly');
  });
});
