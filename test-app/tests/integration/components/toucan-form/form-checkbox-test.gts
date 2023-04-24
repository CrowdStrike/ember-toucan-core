/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';
import { setupRenderingTest } from 'test-app/tests/helpers';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';

interface TestData {
  checked?: boolean;
}

module('Integration | Component | ToucanForm | Checkbox', function (hooks) {
  setupRenderingTest(hooks);

  test('it sets the readonly attribute with `@isReadOnly`', async function (assert) {
    const data: TestData = {
      checked: false,
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Checkbox
          @label="Checked"
          @name="checked"
          @isReadOnly={{true}}
          data-checkbox
        />
      </ToucanForm>
    </template>);

    assert.dom('[data-checkbox]').hasAttribute('readonly');
  });
});
