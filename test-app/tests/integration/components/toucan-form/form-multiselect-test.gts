import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';
import { setupRenderingTest } from 'test-app/tests/helpers';

const options = ['blue', 'red', 'yellow'];

interface TestData {
  selection?: string[];
}

module('Integration | Component | ToucanForm | Multiselect', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders `@label` and `@hint` component arguments', async function (assert) {
    const data: TestData = {
      selection: undefined,
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Multiselect
          @label="Label"
          @hint="Hint"
          @name="selection"
          @noResultsText="No results"
          @options={{options}}
          data-multiselect
        >
          <:chip as |chip|>
            <chip.Chip>
              {{chip.option}}
              <chip.Remove @label="Remove" />
            </chip.Chip>
          </:chip>

          <:default as |multiselect|>
            <multiselect.Option>{{multiselect.option}}</multiselect.Option>
          </:default>
        </form.Multiselect>
      </ToucanForm>
    </template>);

    assert.dom('[data-label]').exists();
    assert.dom('[data-hint]').exists();
  });

  test('it renders a `:label` named block with a `@hint` argument', async function (assert) {
    const data: TestData = {
      selection: undefined,
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Multiselect
          @hint="Hint"
          @name="selection"
          @noResultsText="No results"
          @options={{options}}
          data-autocomplete
        >
          <:label><span data-label-block>Label</span></:label>

          <:chip as |chip|>
            <chip.Chip>
              {{chip.option}}
              <chip.Remove @label="Remove" />
            </chip.Chip>
          </:chip>
          <:default as |multiselect|>
            <multiselect.Option>{{multiselect.option}}</multiselect.Option>
          </:default>
        </form.Multiselect>
      </ToucanForm>
    </template> );

    assert.dom('[data-label-block]').exists();

    // NOTE: `data-hint` comes from `@hint`.
    assert.dom('[data-hint]').exists();
    assert.dom('[data-hint]').hasText('Hint');
  });

  test('it renders a `:hint` named block with a `@label` argument', async function (assert) {
    const data: TestData = {
      selection: undefined,
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Multiselect
          @label="Label"
          @name="selection"
          @noResultsText="No results"
          @options={{options}}
          data-autocomplete
        >
          <:hint><span data-hint-block>Hint</span></:hint>

          <:chip as |chip|>
            <chip.Chip>
              {{chip.option}}
              <chip.Remove @label="Remove" />
            </chip.Chip>
          </:chip>

          <:default as |multiselect|>
            <multiselect.Option>{{multiselect.option}}</multiselect.Option>
          </:default>
        </form.Multiselect>
      </ToucanForm>
    </template>);

    // NOTE: `data-label` comes from `@label`.
    assert.dom('[data-label]').exists();
    assert.dom('[data-label]').hasText('Label');

    assert.dom('[data-hint-block]').exists();
  });

  test('it renders both a `:label` and `:hint` named block', async function (assert) {
    const data: TestData = {
      selection: undefined,
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.Multiselect
          @name="selection"
          @noResultsText="No results"
          @options={{options}}
          data-autocomplete
        >
          <:label><span data-label-block>Label</span></:label>
          <:hint><span data-hint-block>Hint</span></:hint>

          <:chip as |chip|>
            <chip.Chip>
              {{chip.option}}
              <chip.Remove @label="Remove" />
            </chip.Chip>
          </:chip>

          <:default as |multiselect|>
            <multiselect.Option>{{multiselect.option}}</multiselect.Option>
          </:default>

        </form.Multiselect>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();
    assert.dom('[data-hint-block]').exists();
  });
});
