import { render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import CharacterCount from '@crowdstrike/ember-toucan-core/components/form/controls/character-count';
import { setupRenderingTest } from 'test-app/tests/helpers';

module('Integration | Component | Controls | CharacterCount', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {

    await render(<template>
      <CharacterCount @id="123" @current={{5}} @max={{100}} data-character-count />
    </template>);

    assert
      .dom('[data-character-count]')
      .hasText('5 / 100');
  });

  test('it errors if no input id is provided', async function(assert) {

    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('An "@id" argument is required'),
        'Expected assertion error message'
      );
    });

    
    await render(<template>
      {{! @glint-expect-error: we are not providing @id, so this is expected }}
      <CharacterCount @current={{5}} @max={{100}} data-character-count />
    </template>);
  })
});
