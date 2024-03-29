import { click, fillIn, find, render, setupOnerror } from '@ember/test-helpers';
import { module, test } from 'qunit';

import Multiselect from '@crowdstrike/ember-toucan-core/components/form/fields/multiselect';
import { setupRenderingTest } from 'test-app/tests/helpers';

import { MultiselectPageObject } from '@crowdstrike/ember-toucan-core/test-support';

let testColors = ['blue', 'red'];

module('Integration | Component | Fields | Multiselect', function (hooks) {
  setupRenderingTest(hooks);

  let multiselectPageObject = new MultiselectPageObject(
    '[data-multiselect-input]',
  );

  test('it renders', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @noResultsText="No results"
        @options={{testColors}}
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom('[data-label]').hasText('Label');

    assert
      .dom('[data-hint]')
      .doesNotExist(
        'Expected hint block not to be displayed as a hint was not provided',
      );

    assert.dom(multiselectPageObject.element).hasTagName('input');
    assert.dom(multiselectPageObject.element).hasAttribute('id');

    assert
      .dom('[data-error]')
      .doesNotExist(
        'Expected hint block not to be displayed as an error or @hint was not provided',
      );

    assert.dom('[data-lock-icon]').doesNotExist();
  });

  test('it renders with a hint', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @hint="Hint text"
        @options={{testColors}}
        @noResultsText="No results"
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

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

    assert.dom(multiselectPageObject.element).exists();

    let describedby =
      multiselectPageObject.element?.getAttribute('aria-describedby') || '';

    assert.ok(
      describedby.includes(hintId),
      'Expected hintId to be included in the aria-describedby',
    );
  });

  test('it renders with a hint and label block', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-multiselect
      >
        <:label><span data-label>label block content</span></:label>
        <:hint><span data-hint>hint block content</span></:hint>

        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

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
        @noResultsText="No results"
        @options={{testColors}}
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

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
      multiselectPageObject.element?.getAttribute('aria-describedby') || '';

    assert.ok(
      describedby.includes(errorId),
      'Expected errorId to be included in the aria-describedby',
    );

    assert
      .dom(multiselectPageObject.element)
      .hasAttribute('aria-invalid', 'true');

    assert
      .dom(multiselectPageObject.container)
      .hasClass('shadow-error-outline');

    assert
      .dom(multiselectPageObject.container)
      .hasClass('focus-within:shadow-error-focus-outline');

    assert
      .dom(multiselectPageObject.container)
      .doesNotHaveClass('shadow-focusable-outline');
  });

  test('it sets aria-describedby when both a hint and error are provided using the hint and errorIds', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @error="Error text"
        @hint="Hint text"
        @noResultsText="No results"
        @options={{testColors}}
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

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
      .dom(multiselectPageObject.element)
      .hasAttribute('aria-describedby', `${errorId} ${hintId}`);
  });

  test('it disables the input using `@isDisabled` and renders a lock icon', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @isDisabled={{true}}
        @noResultsText="No results"
        @options={{testColors}}
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom(multiselectPageObject.element).isDisabled();
    assert.dom(multiselectPageObject.element).hasClass('text-disabled');

    assert.dom('[data-lock-icon]').exists();
  });

  test('it sets readonly on the input using `@isReadOnly` and renders a lock icon', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @isReadOnly={{true}}
        @noResultsText="No results"
        @options={{testColors}}
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom(multiselectPageObject.element).hasAttribute('readonly');

    assert.dom('[data-lock-icon]').exists();
  });

  test('it spreads attributes to the underlying input', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @noResultsText="No results"
        @options={{testColors}}
        placeholder="Placeholder text"
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert
      .dom(multiselectPageObject.element)
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it applies the provided `@rootTestSelector` to the data-root-field attribute', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @noResultsText="No results"
        @options={{testColors}}
        @rootTestSelector="selector"
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

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
        @noResultsText="No results"
        @options={{testColors}}
        @selected={{testColors}}
        placeholder="Placeholder text"
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.strictEqual(multiselectPageObject.chips?.length, 2);

    assert.dom(multiselectPageObject.chips?.[0]).hasText('blue');
    assert.dom(multiselectPageObject.chips?.[1]).hasText('red');
  });

  // NOTE: This functionality is deeply tested in the Control, as it can
  // get pretty complex.  This test is to ensure `@onChange` is generally
  // working.
  test('it calls `@onChange` when an option is selected', async function (assert) {
    assert.expect(7);

    let options = ['blue', 'red'];

    let handleChange = (value: unknown) => {
      assert.deepEqual(value, ['blue'], 'Expected selected option to match');
      assert.step('handleChange');
    };

    await render(<template>
      <Multiselect
        @label="Label"
        @noResultsText="No results"
        @options={{options}}
        @onChange={{handleChange}}
        data-multiselect-input
        as |combobox|
      >
        <combobox.Option data-option>{{combobox.option}}</combobox.Option>
      </Multiselect>
    </template>);

    assert.verifySteps([]);

    assert.dom(multiselectPageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'blue');

    assert.strictEqual(multiselectPageObject.options?.length, 1);

    assert.dom(multiselectPageObject.options?.[0]).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(multiselectPageObject.options?.[0] as Element);

    assert.verifySteps(['handleChange']);
  });

  // NOTE: This functionality is tested more in-depth via the control component
  // integration test.  We simply want to ensure the component argument gets
  // passed through in this test.
  test('it renders the `Select all` option', async function (assert) {
    await render(<template>
      <Multiselect
        @label="Label"
        @noResultsText="No results"
        @selectAllText="Select all"
        @options={{testColors}}
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom(multiselectPageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(multiselectPageObject.element as Element);

    assert.dom(multiselectPageObject.selectAll).exists();
    assert.dom(multiselectPageObject.selectAll).hasText('Select all');
  });

  test('it throws an assertion error if no `@label` is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes(
          'Assertion Failed: You need either :label or @label',
        ),
        'Expected assertion error message',
      );
    });

    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-multiselect-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

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
          'Assertion Failed: You can have :label or @label, but not both',
        ),
        'Expected assertion error message',
      );
    });

    await render(<template>
      <Multiselect
        @label="Label"
        @noResultsText="No results"
        @options={{testColors}}
        data-multiselect-input
      >
        <:label>Label</:label>

        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);
  });
});
