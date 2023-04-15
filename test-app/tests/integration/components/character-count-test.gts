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

    assert
      .dom('[data-character-count]')
      .hasText('5 / 100');
  });

});
