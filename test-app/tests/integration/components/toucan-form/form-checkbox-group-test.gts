/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */
import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';
import { setupRenderingTest } from 'test-app/tests/helpers';

import ToucanForm from '@crowdstrike/ember-toucan-form/components/toucan-form';

interface TestData {
  checkboxes?: Array<string>;
}

module(
  'Integration | Component | ToucanForm | CheckboxGroup',
  function (hooks) {
    setupRenderingTest(hooks);

    test('it sets the readonly attribute with `@isReadOnly` at the root', async function (assert) {
      const data: TestData = {
        checkboxes: [],
      };

      await render(<template>
        <ToucanForm @data={{data}} as |form|>
          <form.CheckboxGroup
            @label="Checkboxes"
            @name="checkboxes"
            @isReadOnly={{true}}
            as |group|
          >
            <group.CheckboxField
              @label="Option 1"
              @value="option-1"
              data-checkbox-group-1
            />
            <group.CheckboxField
              @label="Option 2"
              @value="option-2"
              data-checkbox-group-2
            />
            <group.CheckboxField
              @label="Option 3"
              @value="option-3"
              data-checkbox-group-3
            />
          </form.CheckboxGroup>
        </ToucanForm>
      </template>);

      assert.dom('[data-checkbox-group-1]').hasAttribute('readonly');
      assert.dom('[data-checkbox-group-2]').hasAttribute('readonly');
      assert.dom('[data-checkbox-group-3]').hasAttribute('readonly');
    });

    test('it sets the readonly attribute with `@isReadOnly` on individual checkboxes', async function (assert) {
      const data: TestData = {
        checkboxes: [],
      };

      await render(<template>
        <ToucanForm @data={{data}} as |form|>
          <form.CheckboxGroup @label="Checkboxes" @name="checkboxes" as |group|>
            <group.CheckboxField
              @label="Option 1"
              @value="option-1"
              data-checkbox-group-1
            />
            <group.CheckboxField
              @label="Option 2"
              @value="option-2"
              @isReadOnly={{true}}
              data-checkbox-group-2
            />
            <group.CheckboxField
              @label="Option 3"
              @value="option-3"
              data-checkbox-group-3
            />
          </form.CheckboxGroup>
        </ToucanForm>
      </template>);

      assert.dom('[data-checkbox-group-1]').hasNoAttribute('readonly');
      assert.dom('[data-checkbox-group-2]').hasAttribute('readonly');
      assert.dom('[data-checkbox-group-3]').hasNoAttribute('readonly');
    });

    test('it renders `@label` and `@hint` component arguments', async function (assert) {
      const data: TestData = {
        checkboxes: [],
      };

      await render(<template>
        <ToucanForm @data={{data}} as |form|>
          <form.CheckboxGroup
            @label="Label"
            @hint="Hint"
            @name="checkboxes"
            as |group|
          >
            <group.CheckboxField
              @label="Option 1"
              @value="option-1"
              data-checkbox-group-1
            />
            <group.CheckboxField
              @label="Option 2"
              @value="option-2"
              @isReadOnly={{true}}
              data-checkbox-group-2
            />
            <group.CheckboxField
              @label="Option 3"
              @value="option-3"
              data-checkbox-group-3
            />
          </form.CheckboxGroup>
        </ToucanForm>
      </template>);

      assert.dom('[data-label]').exists();
      assert.dom('[data-hint]').exists();
    });

    test('it renders a `:label` named block with a `@hint` argument', async function (assert) {
      const data: TestData = {
        checkboxes: [],
      };

      await render(<template>
        <ToucanForm @data={{data}} as |form|>
          <form.CheckboxGroup @hint="Hint" @name="checkboxes">
            <:label><span data-label-block>Label</span></:label>
            <:default as |group|>
              <group.CheckboxField
                @label="Option 1"
                @value="option-1"
                data-checkbox-group-1
              />
              <group.CheckboxField
                @label="Option 2"
                @value="option-2"
                @isReadOnly={{true}}
                data-checkbox-group-2
              />
              <group.CheckboxField
                @label="Option 3"
                @value="option-3"
                data-checkbox-group-3
              />
            </:default>
          </form.CheckboxGroup>
        </ToucanForm>
      </template>);

      assert.dom('[data-label-block]').exists();

      // NOTE: `data-hint` comes from `@hint`.
      assert.dom('[data-hint]').exists();
      assert.dom('[data-hint]').hasText('Hint');
    });

    test('it renders a `:hint` named block with a `@label` argument', async function (assert) {
      const data: TestData = {
        checkboxes: [],
      };

      await render(<template>
        <ToucanForm @data={{data}} as |form|>
          <form.CheckboxGroup @label="Label" @name="checkboxes">
            <:hint><span data-hint-block>Hint</span></:hint>
            <:default as |group|>
              <group.CheckboxField
                @label="Option 1"
                @value="option-1"
                data-checkbox-group-1
              />
              <group.CheckboxField
                @label="Option 2"
                @value="option-2"
                @isReadOnly={{true}}
                data-checkbox-group-2
              />
              <group.CheckboxField
                @label="Option 3"
                @value="option-3"
                data-checkbox-group-3
              />
            </:default>
          </form.CheckboxGroup>
        </ToucanForm>
      </template>);

      // NOTE: `data-label` comes from `@label`.
      assert.dom('[data-label]').exists();
      assert.dom('[data-label]').hasText('Label');

      assert.dom('[data-hint-block]').exists();
    });

    test('it renders both a `:label` and `:hint` named block', async function (assert) {
      const data: TestData = {
        checkboxes: [],
      };

      await render(<template>
        <ToucanForm @data={{data}} as |form|>
          <form.CheckboxGroup @name="checkboxes">
            <:label><span data-label-block>Label</span></:label>
            <:hint><span data-hint-block>Hint</span></:hint>
            <:default as |group|>
              <group.CheckboxField
                @label="Option 1"
                @value="option-1"
                data-checkbox-group-1
              />
              <group.CheckboxField
                @label="Option 2"
                @value="option-2"
                @isReadOnly={{true}}
                data-checkbox-group-2
              />
              <group.CheckboxField
                @label="Option 3"
                @value="option-3"
                data-checkbox-group-3
              />
            </:default>
          </form.CheckboxGroup>
        </ToucanForm>
      </template>);

      assert.dom('[data-label-block]').exists();
      assert.dom('[data-hint-block]').exists();
    });
  }
);
