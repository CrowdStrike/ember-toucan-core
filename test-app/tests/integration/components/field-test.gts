/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import { findAll, render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import Field from '@crowdstrike/ember-toucan-core/components/form/field';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Field', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <Field as |field|>
        <field.Label>label</field.Label>
        <field.Hint data-test-hint>hint</field.Hint>
        {{! we'll handle the wiring of the label }}
        {{! template-lint-disable require-input-label }}
        <field.Control>
          <input type="text" data-test-input />
        </field.Control>
        <field.Error data-test-error>error</field.Error>
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

    assert.dom(control).exists('Expected control block to be rendered');

    assert.dom(error).exists('Expected error block to be rendered');
    assert.dom(error).hasText('error', 'Expected to have error text rendered');
  });

  test('it renders conditionally', async function (assert) {
    await render(<template>
      <div data-test-field>
        <Field as |field|>
          <field.Label>label</field.Label>
          <field.Hint data-test-hint>hint</field.Hint>
          {{! we'll handle the wiring of the label }}
          {{! template-lint-disable require-input-label }}
          <field.Control>
            <input type="text" data-test-input />
          </field.Control>
          {{! explicitly not render field.Error! }}
        </Field>
      </div>
    </template>);

    const label = 'label';
    const hint = '[data-test-hint]';
    const control = '[data-test-input]';

    assert.dom(label).exists('Expected to have label block rendered');
    assert.dom(label).hasText('label', 'Expected to have label text "label"');

    const children = findAll('[data-test-field] > div');
    assert.strictEqual(
      children.length,
      2,
      'Expected two child divs, one for hint, one for control'
    );

    assert.dom(hint).exists('Expected to have hint text rendered');
    assert.dom(hint).hasText('hint', 'Expected to have hint text "hint"');

    assert.dom(control).exists('Expected control block to be rendered');

    assert
      .dom('svg')
      .doesNotExist(
        'Expected error icon not to be shown as error block is not rendered'
      );
  });
});
