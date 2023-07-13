import { render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import CharacterCount from '@crowdstrike/ember-toucan-core/components/form/controls/character-count';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Controls | CharacterCount', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <CharacterCount @current={{5}} @max={{100}} data-character-count />
    </template>);

    assert.dom('[data-character-count]').hasText('5 / 100');
    assert.dom('[data-character-count]').doesNotHaveClass('text-critical');
  });

  test('it throws an error if no @current arg is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('An "@current" argument is required'),
        'Expected assertion error message'
      );
    });
    await render(<template>
      {{! @glint-expect-error: we are missing the @current arg, so an error is expected }}
      <CharacterCount @max={{100}} data-character-count />
    </template>);
  });

  test('it throws an error if no @max arg is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('An "@max" argument is required'),
        'Expected assertion error message'
      );
    });
    await render(<template>
      {{! @glint-expect-error: we are missing the @max arg, so an error is expected }}
      <CharacterCount @current={{100}} data-character-count />
    </template>);
  });

  test('it sets `text-critical` when `@current` is greater than `@max`', async function (assert) {
    await render(<template>
      <CharacterCount @current={{101}} @max={{100}} data-character-count />
    </template>);

    assert.dom('[data-character-count]').hasClass('text-critical');
  });
});
