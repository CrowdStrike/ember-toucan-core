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

  test('it renders `@label` and `@hint` component arguments', async function (assert) {
    const data: TestData = {
      text: 'text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Input @label="Label" @hint="Hint" @name="text" />
      </ToucanForm>
    </template>);

    assert.dom('[data-label]').exists();
    assert.dom('[data-hint]').exists();
  });

  test('it renders a `:label` named block with a `@hint` argument', async function (assert) {
    const data: TestData = {
      text: 'text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Input @name="text" @hint="Hint">
          <:label><span data-label-block>Label</span></:label>
        </form.Input>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();

    // NOTE: `data-hint` comes from `@hint`.
    assert.dom('[data-hint]').exists();
    assert.dom('[data-hint]').hasText('Hint');
  });

  test('it renders a `:hint` named block with a `@label` argument', async function (assert) {
    const data: TestData = {
      text: 'text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Input @label="Label" @name="text">
          <:hint><span data-hint-block>Hint</span></:hint>
        </form.Input>
      </ToucanForm>
    </template>);

    // NOTE: `data-label` comes from `@label`.
    assert.dom('[data-label]').exists();
    assert.dom('[data-label]').hasText('Label');

    assert.dom('[data-hint-block]').exists();
  });

  test('it renders both a `:label` and `:hint` named block', async function (assert) {
    const data: TestData = {
      text: 'text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Input @label="Label" @name="text">
          <:label><span data-label-block>Label</span></:label>
          <:hint><span data-hint-block>Hint</span></:hint>
        </form.Input>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();
    assert.dom('[data-hint-block]').exists();
  });
});
