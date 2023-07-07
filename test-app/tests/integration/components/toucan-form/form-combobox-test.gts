import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';
import { setupRenderingTest } from 'test-app/tests/helpers';

interface TestData {
  selection?: string;
}

module('Integration | Component | ToucanForm | Combobox', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders `@label` and `@hint` component arguments', async function (assert) {
    const data: TestData = {
      selection: '',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Combobox
          @label="Label"
          @hint="Hint"
          @name="selection"
          data-combobox
          as |combobox|
        >
          {{! Need to figure out these types }}
          {{! @glint-expect-error }}
          <combobox.Option data-option>{{combobox.option}}</combobox.Option>
        </form.Combobox>
      </ToucanForm>
    </template>);

    assert.dom('[data-label]').exists();
    assert.dom('[data-hint]').exists();
  });

  test('it renders a `:label` named block with a `@hint` argument', async function (assert) {
    const data: TestData = {
      selection: '',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Combobox @hint="Hint" @name="selection" data-combobox>
          <:label><span data-label-block>Label</span></:label>
          <:default as |combobox|>
            {{! Need to figure out these types }}
            {{! @glint-expect-error }}
            <combobox.Option data-option>{{combobox.option}}</combobox.Option>
          </:default>
        </form.Combobox>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();

    // NOTE: `data-hint` comes from `@hint`.
    assert.dom('[data-hint]').exists();
    assert.dom('[data-hint]').hasText('Hint');
  });

  test('it renders a `:hint` named block with a `@label` argument', async function (assert) {
    const data: TestData = {
      selection: '',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Combobox @label="Label" @name="selection" data-combobox>
          <:hint><span data-hint-block>Hint</span></:hint>
          <:default as |combobox|>
            {{! Need to figure out these types }}
            {{! @glint-expect-error }}
            <combobox.Option data-option>{{combobox.option}}</combobox.Option>
          </:default>
        </form.Combobox>
      </ToucanForm>
    </template>);

    // NOTE: `data-label` comes from `@label`.
    assert.dom('[data-label]').exists();
    assert.dom('[data-label]').hasText('Label');

    assert.dom('[data-hint-block]').exists();
  });

  test('it renders both a `:label` and `:hint` named block', async function (assert) {
    const data: TestData = {
      selection: '',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Combobox @name="selection" data-combobox>
          <:label><span data-label-block>Label</span></:label>
          <:hint><span data-hint-block>Hint</span></:hint>
          <:default as |combobox|>
            {{! Need to figure out these types }}
            {{! @glint-expect-error }}
            <combobox.Option data-option>{{combobox.option}}</combobox.Option>
          </:default>
        </form.Combobox>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();
    assert.dom('[data-hint-block]').exists();
  });
});
