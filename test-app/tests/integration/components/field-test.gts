import { render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import Field from '@crowdstrike/ember-toucan-core/components/form/field';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Field', function (hooks) {
  setupRenderingTest(hooks);

  module('named blocks', function () {
    test('it renders', async function (assert) {
      await render(<template>
        <Field>
          <:label>label</:label>
          <:hint><span data-test-hint>hint</span></:hint>
          <:control>
            <input type="text" data-test-input />
          </:control>
          <:error><span data-test-error>error</span></:error>
        </Field>
      </template>);

      const label = 'label';
      const hint = '[data-test-hint]';
      const error = '[data-test-error]';
      const control = '[data-test-input]';

      assert.dom(label).exists('Expected to have label block rendered');
      assert.dom(label).hasText('label', 'Expected to have label text "label"');

      assert.dom(hint).exists('Expected to have hint text rendered');
      assert.dom(hint).hasText('hint', 'Expected to have hint text "hint"');

      assert.dom(control).exists('Control named block is rendered');

      assert.dom(error).exists('Error block exists');
      assert
        .dom(error)
        .hasText('error', 'Expected to have error text rendered');
    });

    test('does not conditionally render blocks', async function (assert) {
      await render(<template>
        <div data-test-field>
          <Field>
            <:label>label</:label>
            <:hint><span data-test-hint>hint</span></:hint>
          </Field>
        </div>
      </template>);

      const label = 'label';
      const hint = '[data-test-hint]';

      assert.dom(label).exists('Expected to have label block rendered');
      assert.dom(label).hasText('label', 'Expected to have label text "label"');

      assert.dom(hint).exists('Expected to have hint text rendered');
      assert.dom(hint).hasText('hint', 'Expected to have hint text "hint"');

      let childDivs = document.querySelectorAll('[data-test-field] > div');
      assert.strictEqual(
        childDivs.length,
        2,
        'Expect 1 div for hint, 1 div for error'
      );

      assert.dom('svg').exists('The error icon is still displayed');
      assert.dom('input').doesNotExist('The control does not exist');
    });
  });

  module('contextual components', function () {
    test('it renders', async function (assert) {
      await render(<template>
        <Field as |field|>
          <field.Label>label</field.Label>
          <field.Hint><span data-test-hint>hint</span></field.Hint>
          <field.Control>
            <input type="text" data-test-input />
          </field.Control>
          <field.Error><span data-test-error>error</span></field.Error>
        </Field>
      </template>);

      const label = 'label';
      const hint = '[data-test-hint]';
      const error = '[data-test-error]';
      const control = '[data-test-input]';

      assert.dom(label).exists('Expected to have label block rendered');
      assert.dom(label).hasText('label', 'Expected to have label text "label"');

      assert.dom(hint).exists('Expected to have hint text rendered');
      assert.dom(hint).hasText('hint', 'Expected to have hint text "hint"');

      assert.dom(control).exists('Control named block is rendered');

      assert.dom(error).exists('Error block exists');
      assert
        .dom(error)
        .hasText('error', 'Expected to have error text rendered');
    });

    // TODO: Checkpoint: finish this
    test('it renders conditionally', async function (assert) {
      await render(<template>
        <Field as |field|>
          <field.Label>label</field.Label>
          <field.Hint><span data-test-hint>hint</span></field.Hint>
          <field.Control>
            <input type="text" data-test-input />
          </field.Control>
        </Field>
      </template>);

      const label = 'label';
      const hint = '[data-test-hint]';
      const error = '[data-test-error]';
      const control = '[data-test-input]';

      assert.dom(label).exists('Expected to have label block rendered');
      assert.dom(label).hasText('label', 'Expected to have label text "label"');

      assert.dom(hint).exists('Expected to have hint text rendered');
      assert.dom(hint).hasText('hint', 'Expected to have hint text "hint"');

      assert.dom(control).exists('Control named block is rendered');

      assert
        .dom('svg')
        .doesNotExist('Error block does not exist (no error icon shown)');
      assert
        .dom(error)
        .hasText('error', 'Expected to have error text rendered');
    });
  });
});
