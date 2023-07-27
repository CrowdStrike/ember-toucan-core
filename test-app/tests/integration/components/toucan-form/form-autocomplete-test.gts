import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';
import { setupRenderingTest } from 'test-app/tests/helpers';

const options = ['blue', 'red', 'yellow'];

interface TestData {
  selection?: string;
}

module('Integration | Component | ToucanForm | Autocomplete', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders `@label` and `@hint` component arguments', async function (assert) {
    const data: TestData = {
      selection: '',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Autocomplete
          @label="Label"
          @hint="Hint"
          @name="selection"
          @noResultsText="No results"
          @options={{options}}
          data-autocomplete
          as |autocomplete|
        >
          <autocomplete.Option data-option>
            {{autocomplete.option}}
          </autocomplete.Option>
        </form.Autocomplete>
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
        <form.Autocomplete
          @hint="Hint"
          @name="selection"
          @noResultsText="No results"
          @options={{options}}
          data-autocomplete
        >
          <:label><span data-label-block>Label</span></:label>
          <:default as |autocomplete|>
            <autocomplete.Option data-option>
              {{autocomplete.option}}
            </autocomplete.Option>
          </:default>
        </form.Autocomplete>
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
        <form.Autocomplete
          @label="Label"
          @name="selection"
          @noResultsText="No results"
          @options={{options}}
          data-autocomplete
        >
          <:hint><span data-hint-block>Hint</span></:hint>
          <:default as |autocomplete|>
            <autocomplete.Option data-option>
              {{autocomplete.option}}
            </autocomplete.Option>
          </:default>
        </form.Autocomplete>
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
        <form.Autocomplete
          @name="selection"
          @noResultsText="No results"
          @options={{options}}
          data-autocomplete
        >
          <:label><span data-label-block>Label</span></:label>
          <:hint><span data-hint-block>Hint</span></:hint>
          <:default as |autocomplete|>
            <autocomplete.Option data-option>
              {{autocomplete.option}}
            </autocomplete.Option>
          </:default>
        </form.Autocomplete>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();
    assert.dom('[data-hint-block]').exists();
  });
});
