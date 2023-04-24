/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';
import { setupRenderingTest } from 'test-app/tests/helpers';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';

interface TestData {
  radio?: string;
}

module('Integration | Component | ToucanForm | RadioGroup', function (hooks) {
  setupRenderingTest(hooks);

  test('it sets the readonly attribute with `@isReadOnly` at the root', async function (assert) {
    const data: TestData = {
      radio: 'option-2',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.RadioGroup
          @label="Radios"
          @name="radio"
          @isReadOnly={{true}}
          as |group|
        >
          <group.RadioField @label="option-1" @value="option-1" data-radio-1 />
          <group.RadioField @label="option-2" @value="option-2" data-radio-2 />
        </form.RadioGroup>
      </ToucanForm>
    </template>);

    assert.dom('[data-radio-1]').hasAttribute('readonly');
    assert.dom('[data-radio-2]').hasAttribute('readonly');
  });

  test('it sets the readonly attribute with `@isReadOnly` on individual radios', async function (assert) {
    const data: TestData = {
      radio: 'option-2',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.RadioGroup @label="Radios" @name="radio" as |group|>
          <group.RadioField @label="option-1" @value="option-1" data-radio-1 />
          <group.RadioField
            @label="option-2"
            @value="option-2"
            @isReadOnly={{true}}
            data-radio-2
          />
        </form.RadioGroup>
      </ToucanForm>
    </template>);

    assert.dom('[data-radio-1]').hasNoAttribute('readonly');
    assert.dom('[data-radio-2]').hasAttribute('readonly');
  });
});
