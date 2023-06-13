/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';
import { setupRenderingTest } from 'test-app/tests/helpers';

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

  test('it renders `@label` and `@hint` component arguments', async function (assert) {
    const data: TestData = {
      radio: 'option-2',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.RadioGroup @label="Label" @hint="Hint" @name="radio" as |group|>
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

    assert.dom('[data-label]').exists();
    assert.dom('[data-hint]').exists();
  });

  test('it renders a `:label` named block with a `@hint` argument', async function (assert) {
    const data: TestData = {
      radio: 'option-2',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.RadioGroup @hint="Hint" @name="radio">
          <:label><span data-label-block>Label</span></:label>
          <:default as |group|>
            <group.RadioField
              @label="option-1"
              @value="option-1"
              data-radio-1
            />
            <group.RadioField
              @label="option-2"
              @value="option-2"
              @isReadOnly={{true}}
              data-radio-2
            />
          </:default>
        </form.RadioGroup>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();

    // NOTE: `data-hint` comes from `@hint`.
    assert.dom('[data-hint]').exists();
    assert.dom('[data-hint]').hasText('Hint');
  });

  test('it renders a `:hint` named block with a `@label` argument', async function (assert) {
    const data: TestData = {
      radio: 'option-2',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.RadioGroup @label="Label" @name="radio">
          <:hint><span data-hint-block>Hint</span></:hint>
          <:default as |group|>
            <group.RadioField
              @label="option-1"
              @value="option-1"
              data-radio-1
            />
            <group.RadioField
              @label="option-2"
              @value="option-2"
              @isReadOnly={{true}}
              data-radio-2
            />
          </:default>
        </form.RadioGroup>
      </ToucanForm>
    </template>);

    // NOTE: `data-label` comes from `@label`.
    assert.dom('[data-label]').exists();
    assert.dom('[data-label]').hasText('Label');

    assert.dom('[data-hint-block]').exists();
  });

  test('it renders both a `:label` and `:hint` named block', async function (assert) {
    const data: TestData = {
      radio: 'option-2',
    };

    await render(<template>
      <ToucanForm @data={{data}} as |form|>
        <form.RadioGroup @name="radio">
          <:label><span data-label-block>Label</span></:label>
          <:hint><span data-hint-block>Hint</span></:hint>
          <:default as |group|>
            <group.RadioField
              @label="option-1"
              @value="option-1"
              data-radio-1
            />
            <group.RadioField
              @label="option-2"
              @value="option-2"
              @isReadOnly={{true}}
              data-radio-2
            />
          </:default>
        </form.RadioGroup>
      </ToucanForm>
    </template>);

    assert.dom('[data-label-block]').exists();
    assert.dom('[data-hint-block]').exists();
  });
});
