import { click, fillIn, find, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import Multiselect from '@crowdstrike/ember-toucan-core/components/form/fields/multiselect';
import { setupRenderingTest } from 'test-app/tests/helpers';

let testColors = ['blue', 'red'];

module('Integration | Component | Fields | Multiselect', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template>
      <Multiselect @label="Label" @options={{testColors}} data-multiselect>
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom('[data-label]').hasText('Label');

    assert
      .dom('[data-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided'
      );

    assert.dom('[data-multiselect]').hasTagName('input');
    assert.dom('[data-multiselect]').hasAttribute('id');

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected hint block not to be displayed as an error or @hint was not provided'
      );

    assert.dom('[data-lock-icon]').doesNotExist();
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @hint="Hint text"
        @options={{testColors}}
        data-multiselect
      >
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    let hint = find('[data-hint]');

    assert.dom(hint).hasText('Hint text');
    assert.dom(hint).hasAttribute('id');

    let hintId = hint?.getAttribute('id') || '';

    assert.ok(hintId, 'Expected hintId to be truthy');

    let describedby =
      find('[data-multiselect]')?.getAttribute('aria-describedby') || '';

    assert.ok(
      describedby.includes(hintId),
      'Expected hintId to be included in the aria-describedby'
    );
  });

  test('it renders with a hint and label block', async function (assert) {
    await render(<template>
      <Multiselect @options={{testColors}} data-multiselect>
        <:label><span data-label>label block content</span></:label>
        <:hint><span data-hint>hint block content</span></:hint>

        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom('[data-hint]').hasText('hint block content');
    assert.dom('[data-label]').hasText('label block content');
  });

  test('it renders with an error', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @error="Error text"
        @options={{testColors}}
        data-multiselect
      >
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    let error = find('[data-error]');

    assert.dom(error).hasText('Error text');
    assert.dom(error).hasAttribute('id');

    let errorId = error?.getAttribute('id') || '';

    assert.ok(errorId, 'Expected errorId to be truthy');

    let describedby =
      find('[data-multiselect]')?.getAttribute('aria-describedby') || '';

    assert.ok(
      describedby.includes(errorId),
      'Expected errorId to be included in the aria-describedby'
    );

    assert.dom('[data-multiselect]').hasAttribute('aria-invalid', 'true');

    assert.dom('[data-multiselect-container]').hasClass('shadow-error-outline');
    assert
      .dom('[data-multiselect-container]')
      .hasClass('focus-within:shadow-error-focus-outline');
    assert
      .dom('[data-multiselect-container]')
      .doesNotHaveClass('shadow-focusable-outline');
  });

  test('it sets aria-describedby when both a hint and error are provided using the hint and errorIds', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @error="Error text"
        @hint="Hint text"
        @options={{testColors}}
        data-multiselect
      >
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    let errorId = find('[data-error]')?.getAttribute('id') || '';

    assert.ok(errorId, 'Expected errorId to be truthy');

    let hintId = find('[data-hint]')?.getAttribute('id') || '';

    assert.ok(hintId, 'Expected hintId to be truthy');

    assert
      .dom('[data-multiselect]')
      .hasAttribute('aria-describedby', `${errorId} ${hintId}`);
  });

  test('it disables the input using `@isDisabled` and renders a lock icon', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @isDisabled={{true}}
        @options={{testColors}}
        data-multiselect
      >
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom('[data-multiselect]').isDisabled();
    assert.dom('[data-multiselect]').hasClass('text-disabled');

    assert.dom('[data-lock-icon]').exists();
  });

  test('it sets readonly on the input using `@isReadOnly` and renders a lock icon', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @isReadOnly={{true}}
        @options={{testColors}}
        data-multiselect
      >
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom('[data-multiselect]').hasAttribute('readonly');

    assert.dom('[data-lock-icon]').exists();
  });

  test('it spreads attributes to the underlying input', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @options={{testColors}}
        placeholder="Placeholder text"
        data-multiselect
      >
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert
      .dom('[data-multiselect]')
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it applies the provided `@rootTestSelector` to the data-root-field attribute', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @options={{testColors}}
        @rootTestSelector="selector"
        data-multiselect
      >
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom('[data-root-field="selector"]').exists();
  });

  test('it sets renders selected chips via `@selected`', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @options={{testColors}}
        @selected={{testColors}}
        placeholder="Placeholder text"
        data-multiselect
      >
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom('[data-multiselect-selected-option]').exists({ count: 2 });

    let [firstChip, secondChip] = document.querySelectorAll(
      '[data-multiselect-selected-option]'
    );

    assert.dom(firstChip).hasText('blue');
    assert.dom(secondChip).hasText('red');
  });

  // NOTE: This functionality is deeply tested in the Control, as it can
  // get pretty complex.  This test is to ensure `@onChange` is generally
  // working.
  test('it calls `@onChange` when an option is selected', async function (assert) {
    assert.expect(5);

    let options = ['blue', 'red'];

    let handleChange = (value: unknown) => {
      assert.deepEqual(value, ['blue'], 'Expected selected option to match');
      assert.step('handleChange');
    };

    await render(<template>
      <Multiselect
        @label="Label"
        @options={{options}}
        @onChange={{handleChange}}
        data-multiselect
        as |combobox|
      >
        <combobox.Option data-option>{{combobox.option}}</combobox.Option>
      </Multiselect>
    </template>);

    assert.verifySteps([]);

    await fillIn('[data-multiselect]', 'blue');

    assert.dom('[role="option"]').exists({ count: 1 });

    await click('[role="option"]');

    assert.verifySteps(['handleChange']);
  });

  test('it throws an assertion error if no `@label` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes(
          'Assertion Failed: You need either :label or @label'
        ),
        'Expected assertion error message'
      );
    });

    await render(<template>
      <Multiselect @options={{testColors}} data-multiselect>
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);
  });

  test('it throws an assertion error if a `@label` and :label are provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes(
          'Assertion Failed: You can have :label or @label, but not both'
        ),
        'Expected assertion error message'
      );
    });

    await render(<template>
      <Multiselect @label="Label" @options={{testColors}} data-multiselect>
        <:label>Label</:label>
        <:noResults>No results</:noResults>

        <:remove as |remove|>
          <remove.Remove @label="Remove" />
        </:remove>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);
  });
});
