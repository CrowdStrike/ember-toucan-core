import { click, fillIn, render, triggerKeyEvent } from '@ember/test-helpers';
import { module, test } from 'qunit';

import Autocomplete from '@crowdstrike/ember-toucan-core/components/form/controls/autocomplete';
import { setupRenderingTest } from 'test-app/tests/helpers';

import { AutocompletePageObject } from '@crowdstrike/ember-toucan-core/test-support';

let testColors = ['blue', 'red'];

module('Integration | Component | Autocomplete', function (hooks) {
  setupRenderingTest(hooks);

  let autocompletePageObject = new AutocompletePageObject('[data-input]');

  test('it renders', async function (assert) {
    await render(<template><Autocomplete @noResultsText="No results" data-input /></template>);

    assert.dom(autocompletePageObject.element).hasTagName('input');
    assert.dom(autocompletePageObject.element).hasClass('text-titles-and-attributes');
    assert.dom(autocompletePageObject.element).hasClass('shadow-focusable-outline');
    assert.dom(autocompletePageObject.element).doesNotHaveClass('text-disabled');
    assert.dom(autocompletePageObject.element).doesNotHaveClass('shadow-error-outline');
    assert.dom(autocompletePageObject.element).hasAttribute('aria-autocomplete', 'list');
    assert.dom(autocompletePageObject.element).hasAttribute('aria-haspopup', 'listbox');
    assert.dom(autocompletePageObject.element).hasAttribute('autocapitalize', 'none');
    assert.dom(autocompletePageObject.element).hasAttribute('autocomplete', 'off');
    assert.dom(autocompletePageObject.element).hasAttribute('autocorrect', 'off');
    assert.dom(autocompletePageObject.element).hasAttribute('role', 'combobox');
    assert.dom(autocompletePageObject.element).hasAttribute('spellcheck', 'false');
    assert.dom(autocompletePageObject.element).hasAttribute('type', 'text');

    assert
      .dom(autocompletePageObject.element)
      .doesNotHaveClass('focus:shadow-error-focus-outline');
  });

  test('it disables the autocomplete using `@isDisabled`', async function (assert) {
    await render(<template>
      <Autocomplete @isDisabled={{true}} @noResultsText="No results" data-input />
    </template>);

    assert.dom(autocompletePageObject.element).isDisabled();
    assert.dom(autocompletePageObject.element).hasClass('text-disabled');

    assert
      .dom(autocompletePageObject.element)
      .doesNotHaveClass('text-titles-and-attributes');
  });

  test('it sets readonly on the autocomplete using `@isReadOnly`', async function (assert) {
    await render(<template>
      <Autocomplete @isReadOnly={{true}} @noResultsText="No results" data-input />
    </template>);

    assert.dom(autocompletePageObject.element).hasAttribute('readonly');
    assert.dom(autocompletePageObject.element).hasClass('shadow-read-only-outline');
    assert.dom(autocompletePageObject.element).hasClass('bg-surface-xl');
    assert.dom(autocompletePageObject.element).hasNoClass('bg-overlay-1');
    assert.dom(autocompletePageObject.element).hasNoClass('text-disabled');
    assert.dom(autocompletePageObject.element).hasNoClass('shadow-error-outline');
    assert.dom(autocompletePageObject.element).hasNoClass('shadow-focusable-outline');
  });

  test('it spreads attributes to the underlying autocomplete', async function (assert) {
    await render(<template>
      <Autocomplete @noResultsText="No results" placeholder="Placeholder text" data-input />
    </template>);

    assert
      .dom(autocompletePageObject.element)
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it applies the error shadow when `@hasError={{true}}`', async function (assert) {
    await render(<template>
      <Autocomplete @hasError={{true}} @noResultsText="No results" data-input />
    </template>);

    assert.dom(autocompletePageObject.element).hasClass('shadow-error-outline');

    assert
      .dom(autocompletePageObject.element)
      .hasClass('focus:shadow-error-focus-outline');

    assert
      .dom(autocompletePageObject.element)
      .doesNotHaveClass('shadow-focusable-outline');
  });

  test('it opens the popover on click', async function (assert) {
    await render(<template>
      <Autocomplete @noResultsText="No results" @options={{testColors}} data-input />
    </template>);

    assert.dom(autocompletePageObject.list).doesNotExist();
    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.dom(autocompletePageObject.list).exists();
  });

  test('it opens the popover when the input receives input', async function (assert) {
    await render(<template>
      <Autocomplete @noResultsText="No results" @options={{testColors}} data-input />
    </template>);

    assert.dom(autocompletePageObject.list).doesNotExist();

    assert.dom(autocompletePageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(autocompletePageObject.element as Element, 'b');

    assert.dom(autocompletePageObject.list).exists();
  });

  test('it sets `aria-expanded` based on the popover state', async function (assert) {
    await render(<template>
      <Autocomplete @noResultsText="No results" @options={{testColors}} data-input as |autocomplete|>
        <autocomplete.Option data-option>
          {{autocomplete.option}}
        </autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.list).doesNotExist();
    assert.dom(autocompletePageObject.element).exists();
    assert.dom(autocompletePageObject.element).hasNoAttribute('aria-expanded');

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.dom(autocompletePageObject.element).hasAttribute('aria-expanded');
  });

  test('it sets `aria-controls`', async function (assert) {
    await render(<template>
      <Autocomplete @noResultsText="No results" @options={{testColors}} data-input as |autocomplete|>
        <autocomplete.Option>
          {{autocomplete.option}}
        </autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).hasAttribute('aria-controls');
  });

  test('it applies the provided `@contentClass` to the popover content list', async function (assert) {
    await render(<template>
      <Autocomplete
        @options={{testColors}}
        @contentClass="test-class"
        @noResultsText="No results"
        data-input
      />
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.dom(autocompletePageObject.list).exists();
    assert.dom(autocompletePageObject.list).hasClass('test-class');
  });

  test('it renders the provided options in the popover list', async function (assert) {
    await render(<template>
      <Autocomplete
        @options={{testColors}}
        @contentClass="test-class"
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>
          {{autocomplete.option}}
        </autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.strictEqual(autocompletePageObject.options?.length, 2)
  });

  test('it sets the value attribute via `@selected`', async function (assert) {
    await render(<template>
      <Autocomplete
        @selected="blue"
        @options={{testColors}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>
          {{autocomplete.option}}
        </autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).hasValue('blue');
  });

  test('it sets `aria-selected` properly on the list item that is currently selected', async function (assert) {
    await render(<template>
      <Autocomplete
        @selected="blue"
        @options={{testColors}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    // Since `@selected="blue"`, we expect it to be selected
    assert
      .dom(autocompletePageObject.options?.[0])
      .hasAttribute('aria-selected', 'true');

    // ...but not the "red" one!
    assert
      .dom(autocompletePageObject.options?.[autocompletePageObject.options?.length - 1])
      .hasAttribute('aria-selected', 'false');
  });

  test('it provides default filtering', async function (assert) {
    await render(<template>
      <Autocomplete @noResultsText="No results" @options={{testColors}} data-input as |autocomplete|>
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(autocompletePageObject.element as Element, 'blue');

    // Filtering works as we expect
    assert.strictEqual(autocompletePageObject.options?.length, 1);
    assert.dom(autocompletePageObject.options?.[0]).hasText('blue');

    // Resetting the filter by clearing the input should
    // display all available options
    await fillIn(autocompletePageObject.element as Element, '');
    assert.strictEqual(autocompletePageObject.options?.length, 2);

    // Verify we can filter again after clearing
    await fillIn(autocompletePageObject.element as Element, 'red');
    assert.strictEqual(autocompletePageObject.options?.length, 1);
    assert.dom(autocompletePageObject.options?.[0]).hasText('red');
  });

  test('it uses the provided `@noResultsText` when no results are found with filtering', async function (assert) {
    await render(<template>
      <Autocomplete
        @options={{testColors}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(autocompletePageObject.element as Element, 'something-not-in-the-list');

    // We should not have any list items
    assert.strictEqual(autocompletePageObject.options?.length, 0);

    // ...but we should have our no results item!
    assert.dom(autocompletePageObject.status).exists();
    assert.dom(autocompletePageObject.status).hasTagName('li');
    assert.dom(autocompletePageObject.status).hasText('No results');

    assert
      .dom(autocompletePageObject.status)
      .hasAttribute(
        'aria-live',
        'assertive',
        'Expected assertive so it is announced to screenreaders'
      );
  });

  test('it calls `@onChange` when an option is selected via mouse click', async function (assert) {
    assert.expect(7);

    let handleChange = (value: unknown) => {
      assert.strictEqual(value, 'blue', 'Expected input to match');
      assert.step('handleChange');
    };

    await render(<template>
      <Autocomplete
        @noResultsText="No results"
        @options={{testColors}}
        @onChange={{handleChange}}
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.verifySteps([]);

    assert.dom(autocompletePageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(autocompletePageObject.element as Element, 'blue');

    assert.strictEqual(autocompletePageObject.options?.length, 1);

    assert.dom(autocompletePageObject.options?.[0]).exists();

    // Open the popover
    await click(autocompletePageObject.options?.[0] as Element);

    assert.verifySteps(['handleChange']);
  });

  test('it calls `@onChange` when an option is selected using the `Enter` key', async function (assert) {
    assert.expect(6);

    let handleChange = (value: unknown) => {
      assert.strictEqual(value, 'blue', 'Expected input to match');
      assert.step('handleChange');
    };

    await render(<template>
      <Autocomplete
        @noResultsText="No results"
        @options={{testColors}}
        @onChange={{handleChange}}
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.verifySteps([]);

    assert.dom(autocompletePageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(autocompletePageObject.element as Element, 'blue');

    assert.strictEqual(autocompletePageObject.options?.length, 1);

    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'Enter');

    assert.verifySteps(['handleChange']);
  });

  test('it uses the results from `@onFilter` to populate the filtered options', async function (assert) {
    assert.expect(7);

    let handleFilter = (value: string) => {
      assert.strictEqual(
        value,
        'y',
        'Expected the input to match what was entered via fillIn'
      );
      assert.step('onFilter');

      return ['yellow'];
    };

    await render(<template>
      <Autocomplete
        @selected="blue"
        @options={{testColors}}
        @onFilter={{handleFilter}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(autocompletePageObject.element as Element, 'y');

    assert.verifySteps(['onFilter']);
    assert.strictEqual(autocompletePageObject.options?.length, 1);

    assert.dom(autocompletePageObject.options?.[0]).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    assert.dom(autocompletePageObject.options?.[0] as Element).hasText('yellow');
  });

  test('it sets the "active" item to the first one in the list when the autocomplete gains focus', async function (assert) {
    await render(<template>
      <Autocomplete
        @selected="blue"
        @options={{testColors}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.strictEqual(autocompletePageObject.options?.length, 2)
    assert.dom(autocompletePageObject.options?.[0]).exists();

    assert
      .strictEqual(autocompletePageObject.options?.[0], autocompletePageObject.active)
  });

  test('it sets the "active" item to the next item in the list when `ArrowDown` is pressed', async function (assert) {
    await render(<template>
      <Autocomplete
        @selected="blue"
        @options={{testColors}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.strictEqual(autocompletePageObject.options?.length, 2)

    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'ArrowDown');

    assert.dom(autocompletePageObject.options?.[1]).exists();

    assert
      .strictEqual(autocompletePageObject.options?.[1], autocompletePageObject.active)
  });

  test('it sets the "active" item to the previous item in the list when `ArrowUp` is pressed', async function (assert) {
    // NOTE: Setting the selected option to "red" here so that
    // the last item in the list will be active so that we can
    // move up!
    await render(<template>
      <Autocomplete
        @selected="red"
        @options={{testColors}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.strictEqual(autocompletePageObject.options?.length, 2)
    assert.dom(autocompletePageObject.options?.[0]).exists();

    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'ArrowUp');

    assert.dom(autocompletePageObject.options?.[0]).exists();

    assert
      .strictEqual(autocompletePageObject.options?.[0], autocompletePageObject.active)
  });

  test('it closes an open popover when `Escape` is pressed', async function (assert) {
    await render(<template>
      <Autocomplete @noResultsText="No results" @options={{testColors}} data-input as |autocomplete|>
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.dom(autocompletePageObject.list).exists();

    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'Escape');

    assert.dom(autocompletePageObject.list).doesNotExist();
  });

  test('it closes an open popover when the component is blurred', async function (assert) {
    await render(<template>
      {{! template-lint-disable require-input-label }}
      <input placeholder="test" />

      <Autocomplete @noResultsText="No results" @options={{testColors}} data-input as |autocomplete|>
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.dom(autocompletePageObject.list).exists();

    // Now blur the element
    await click('[placeholder="test"]');

    assert.strictEqual(autocompletePageObject.list, null);
  });

  test('it reopens the popover when any key is pressed if the popover is closed', async function (assert) {
    await render(<template>
      <Autocomplete @noResultsText="No results" @options={{testColors}} data-input as |autocomplete|>
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    // Now close it
    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'Escape');

    // Now reopen it
    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'ArrowDown');

    assert.dom(autocompletePageObject.list).exists();
  });

  test('it makes the first option "active" when the `metakey` and `ArrowUp` are pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the bottom of the list!
    await render(<template>
      <Autocomplete
        @selected="f"
        @options={{options}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    // Activate the second option so we can later be sure that pressing `metaKey` and `ArrowUp` did something.
    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'ArrowDown' );

    assert.dom(autocompletePageObject.options?.[1]).exists();

    assert
      .strictEqual(autocompletePageObject.options?.[1], autocompletePageObject.active)

    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'ArrowUp', {
      metaKey: true,
    });

    assert.dom(autocompletePageObject.options?.[0]).exists();

    assert
     .strictEqual(autocompletePageObject.options?.[0], autocompletePageObject.active)
  });

  test('it makes the last option "active" when the `metaKey` and `ArrowDown` are pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the top of the list!
    await render(<template>
      <Autocomplete
        @selected="a"
        @options={{options}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.dom(autocompletePageObject.options?.[0]).exists();

    // Assert that the first option is activated so we can later be sure that pressing `metaKey` and `ArrowDown` did something.
    assert
      .strictEqual(autocompletePageObject.options?.[0], autocompletePageObject.active)

    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'ArrowDown', {
      metaKey: true,
    });

    assert.dom(autocompletePageObject.options?.[options.length - 1]).exists();

    assert
     .strictEqual(autocompletePageObject.options?.[options.length - 1], autocompletePageObject.active)
  });

  test('it makes the last option "active" when `PageDown` is pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the top of the list!
    await render(<template>
      <Autocomplete
        @selected="a"
        @options={{options}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    // Assert that the first option is activated so we can later be sure that pressing `metaKey` and `ArrowDown` did something.
    assert
      .strictEqual(autocompletePageObject.options?.[0], autocompletePageObject.active)

    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'PageDown');

    assert.dom(autocompletePageObject.options?.[options.length - 1]).exists();

    assert
     .strictEqual(autocompletePageObject.options?.[options.length - 1], autocompletePageObject.active)
  });

  test('it makes the first option "active" when `PageUp` is pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the bottom of the list!
    await render(<template>
      <Autocomplete
        @selected="f"
        @options={{options}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    // Activate the second option so we can later be sure that pressing `PageUp` did something.
    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'ArrowDown' );

    assert.dom(autocompletePageObject.options?.[1]).exists();

    assert
      .strictEqual(autocompletePageObject.options?.[1], autocompletePageObject.active)

    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'PageUp');

    assert.dom(autocompletePageObject.options?.[0]).exists();

    assert
     .strictEqual(autocompletePageObject.options?.[0], autocompletePageObject.active)
  });

  test('it makes the first option "active" when `Home` is pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the bottom of the list!
    await render(<template>
      <Autocomplete
        @selected="f"
        @options={{options}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    // Activate the second option so we can later be sure that pressing `Home` did something.
    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'ArrowDown' );

    assert.dom(autocompletePageObject.options?.[1]).exists();

    assert
      .strictEqual(autocompletePageObject.options?.[1], autocompletePageObject.active)

    await triggerKeyEvent(autocompletePageObject.element as Element, 'keydown', 'Home');

    assert.dom(autocompletePageObject.options?.[0]).exists();

    assert
     .strictEqual(autocompletePageObject.options?.[0], autocompletePageObject.active)
  });

  /**
   * This test covers the case where we have a selected option,
   * the user clears the input completely, and then the component's
   * input tag is blurred.  In that case, we want to clear the input
   * and reset their selection to null.
   */
  test('it calls `@onChange` with null after a user clears their original input selection', async function (assert) {
    assert.expect(5);

    let handleChange = (value: unknown) => {
      assert.strictEqual(value, null, 'Expected `value` to be null');
      assert.step('handleChange');
    };

    // NOTE: We have a selected option
    // NOTE: We add an input tag so we have something to blur to (by focusing another element)
    await render(<template>
      <Autocomplete
        @selected="blue"
        @options={{testColors}}
        @onChange={{handleChange}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>

      {{! template-lint-disable require-input-label }}
      <input placeholder="test" />
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    await fillIn(autocompletePageObject.element as Element, '');

    // Now blur autocomplete's input by focusing another element
    await click('[placeholder="test"]');

    assert.dom(autocompletePageObject.element).hasValue('');
    assert.verifySteps(['handleChange']);
  });

  test('it reverts to the selected option when a user enters garbage after previously having a valid selection', async function (assert) {
    assert.expect(4);

    let handleChange = () => {
      assert.step('do-not-expect-this-to-be-called!');
    };

    // NOTE: We have a selected option
    // NOTE: We add an input tag so we have something to blur to (by focusing another element)
    await render(<template>
      <Autocomplete
        @selected="blue"
        @options={{testColors}}
        @onChange={{handleChange}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>

      {{! template-lint-disable require-input-label }}
      <input placeholder="test" />
    </template>);

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    // Enter garbage into the input
    await fillIn(autocompletePageObject.element as Element, 'some-garbage');

    // Now blur autocomplete's input by focusing another element
    await click('[placeholder="test"]');

    // Verify the input is reset to our `@selected` option
    assert.dom(autocompletePageObject.element).hasValue('blue');

    // NOTE: We do not expect the `@onChange`  to be called in this
    // case as we are only visually resetting to the previously
    // selected value
    assert.verifySteps([]);

    // We want to verify the original options are re-displayed
    // rather than the input being filtered to garbage
    await click(autocompletePageObject.element as Element);

    assert.strictEqual(autocompletePageObject.options?.length, 2);
  });

  test('it reselects the entered input value when there is a selected item and the input regains focus', async function (assert) {
    await render(<template>
      <Autocomplete
        @selected="blue"
        @options={{testColors}}
        @noResultsText="No results"
        data-input
        as |autocomplete|
      >
        <autocomplete.Option>{{autocomplete.option}}</autocomplete.Option>
      </Autocomplete>
    </template>);

    assert.strictEqual(
      document.getSelection()?.toString(),
      '',
      'Expected nothing to be selected by default as we have not interacted with the component'
    );

    assert.dom(autocompletePageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(autocompletePageObject.element as Element);

    assert.strictEqual(
      document.getSelection()?.toString(),
      'blue',
      'Expected "blue" to be selected since that is our `@selected` value'
    );
  });
});
