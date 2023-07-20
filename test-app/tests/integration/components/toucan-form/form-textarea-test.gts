/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';
import { setupRenderingTest } from 'test-app/tests/helpers';

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

  test('it renders `@label` and `@hint` component arguments with the character counter', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @label="Label" @hint="Hint" @name="text">
          <:secondary as |secondary|>
            <secondary.CharacterCount @max={{255}} data-character-count />
          </:secondary>
        </form.Textarea>
      </ToucanForm>
    </template>);

    assert.dom('[data-label]').exists();
    assert.dom('[data-hint]').exists();
    assert.dom('[data-character-count]').exists();
  });

  test('it renders a `:label` named block with a `@hint` argument', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @name="text" @hint="Hint">
          <:label><span data-label-block>Label</span></:label>
        </form.Textarea>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();

    // NOTE: `data-hint` comes from `@hint`.
    assert.dom('[data-hint]').exists();
    assert.dom('[data-hint]').hasText('Hint');
  });

  test('it renders a `:label` named block with a `@hint` argument with the character counter', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @name="text" @hint="Hint">
          <:label><span data-label-block>Label</span></:label>
          <:secondary as |secondary|>
            <secondary.CharacterCount @max={{255}} data-character-count />
          </:secondary>
        </form.Textarea>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();

    // NOTE: `data-hint` comes from `@hint`.
    assert.dom('[data-hint]').exists();
    assert.dom('[data-hint]').hasText('Hint');

    assert.dom('[data-character-count]').exists();
  });

  test('it renders a `:hint` named block with a `@label` argument', async function (assert) {
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
    assert.dom('[data-label]').hasText('Label');

    assert.dom('[data-hint-block]').exists();
  });

  test('it renders a `:hint` named block with a `@label` argument with the character counter', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @label="Label" @name="text">
          <:hint><span data-hint-block>Hint</span></:hint>
          <:secondary as |secondary|>
            <secondary.CharacterCount @max={{255}} data-character-count />
          </:secondary>
        </form.Textarea>
      </ToucanForm>
    </template>);

    // NOTE: `data-label` comes from `@label`.
    assert.dom('[data-label]').exists();
    assert.dom('[data-label]').hasText('Label');

    assert.dom('[data-hint-block]').exists();

    assert.dom('[data-character-count]').exists();
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

  test('it renders `:label`, `:secondary` with character counter, and `:hint` blocks', async function (assert) {
    const data: TestData = {
      text: 'multi-line text',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Textarea @label="Label" @name="text">
          <:label><span data-label-block>Label</span></:label>
          <:hint><span data-hint-block>Hint</span></:hint>
          <:secondary as |secondary|>
            <secondary.CharacterCount @max={{255}} data-character-count />
          </:secondary>
        </form.Textarea>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();
    assert.dom('[data-hint-block]').exists();
    assert.dom('[data-character-count]').exists();
  });
});
