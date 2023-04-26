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

  test('it renders `@label` and `@hint` component arguments', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @label="Label" @hint="Hint" @name="text" />
      </ToucanForm>
    </template>);

    assert.dom('[data-label]').exists();
    assert.dom('[data-hint]').exists();
  });

  test('it renders a `:label` named block', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @name="text">
          <:label><span data-label-block>Label</span></:label>
        </form.Textarea>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();
  });

  test('it renders a `:hint` named block with a @label arg', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @label="Label" @name="text">
          <:hint><span data-hint-block>Hint</span></:hint>
        </form.Textarea>
      </ToucanForm>
    </template>);

    // NOTE: `data-label` comes from `@label`.
    assert.dom('[data-label]').exists();
    assert.dom('[data-hint-block]').exists();
  });

  test('it renders both a `:label` and `:hint` named block', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @label="Label" @name="text">
          <:label><span data-label-block>Label</span></:label>
          <:hint><span data-hint-block>Hint</span></:hint>
        </form.Textarea>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();
    assert.dom('[data-hint-block]').exists();
  });
});
