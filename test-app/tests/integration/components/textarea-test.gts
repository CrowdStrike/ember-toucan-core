/* eslint-disable no-undef -- Until https://github.com/ember-cli/eslint-plugin-ember/issues/1747 is resolved... */
/* eslint-disable simple-import-sort/imports,padding-line-between-statements,decorator-position/decorator-position -- Can't fix these manually, without --fix working in .gts */

import { fillIn, render } from '@ember/test-helpers';
import { module, test } from 'qunit';

import Textarea from '@crowdstrike/ember-toucan-core/components/form/controls/textarea';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Textarea', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><Textarea data-textarea /></template>);

    assert.dom('[data-textarea]').hasTagName('textarea');
    assert.dom('[data-textarea]').hasClass('text-titles-and-attributes');
    assert.dom('[data-textarea]').doesNotHaveClass('text-disabled');
  });

  test('it disables the textarea using `@isDisabled`', async function (assert) {
    await render(<template>
      <Textarea @isDisabled={{true}} data-textarea />
    </template>);

    assert.dom('[data-textarea]').isDisabled();
    assert.dom('[data-textarea]').hasClass('text-disabled');
    assert
      .dom('[data-textarea]')
      .doesNotHaveClass('text-titles-and-attributes');
  });

  test('it spreads attributes to the underlying textarea', async function (assert) {
    await render(<template>
      <Textarea placeholder="Placeholder text" data-textarea />
    </template>);

    assert
      .dom('[data-textarea]')
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it sets the value attribute via `@value`', async function (assert) {
    await render(<template><Textarea @value="tony" data-textarea /></template>);

    assert.dom('[data-textarea]').hasValue('tony');
  });

  test('it calls `@onChange` when input is received', async function (assert) {
    let handleChange = (value: string, e: Event | InputEvent) => {
      assert.strictEqual(value, 'test', 'Expected input to match');
      assert.ok(e, 'Expected `e` to be available as the second argument');
      assert.ok(e.target, 'Expected direct access to target from `e`');
      assert.step('handleChange');
    };

    await render(<template>
      <Textarea @onChange={{handleChange}} data-textarea />
    </template>);

    assert.verifySteps([]);

    await fillIn('[data-textarea]', 'test');

    assert.verifySteps(['handleChange']);
  });
});
