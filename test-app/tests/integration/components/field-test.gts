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
        <field.Error @error="error" data-test-error />
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

  test('it provides ids for accessibility attributes', async function (assert) {
    await render(<template>
      <Field as |field|>
        <span data-test-id>{{field.id}}</span>
        <span data-test-hintId>{{field.hintId}}</span>
        <span data-test-errorId>{{field.errorId}}</span>
      </Field>
    </template>);

    assert.dom('[data-test-id]').hasAnyText();
    assert.dom('[data-test-hintId]').hasAnyText();
    assert.dom('[data-test-errorId]').hasAnyText();
  });

  test('it renders an array of errors', async function (assert) {
    let testErrors = ['error 1', 'error 2'];

    await render(<template>
      <Field as |field|>
        <field.Error @error={{testErrors}} data-test-error />
      </Field>
    </template>);

    assert
      .dom('[data-test-error]')
      .exists('Expected error block to be rendered');

    assert.dom('[data-error-item]').exists({ count: 2 });

    assert
      .dom('[data-error-item="0"]')
      .hasText('error 1', 'Expected to have first error text rendered');

    assert
      .dom('[data-error-item="1"]')
      .hasText('error 2', 'Expected to have first error text rendered');
  });
});
