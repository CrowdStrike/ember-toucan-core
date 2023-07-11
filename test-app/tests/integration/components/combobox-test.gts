import { click, fillIn, render, triggerKeyEvent } from '@ember/test-helpers';
import { module, test } from 'qunit';

import ComboboxControl from '@crowdstrike/ember-toucan-core/components/form/controls/combobox';
import { setupRenderingTest } from 'test-app/tests/helpers';

let testColors = ['blue', 'red'];

module('Integration | Component | Combobox', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    await render(<template><ComboboxControl data-combobox /></template>);

    assert.dom('[data-combobox]').hasTagName('input');
    assert.dom('[data-combobox]').hasClass('text-titles-and-attributes');
    assert.dom('[data-combobox]').hasClass('shadow-focusable-outline');
    assert.dom('[data-combobox]').doesNotHaveClass('text-disabled');
    assert.dom('[data-combobox]').doesNotHaveClass('shadow-error-outline');
    assert
      .dom('[data-combobox]')
      .doesNotHaveClass('focus:shadow-error-focus-outline');

    assert.dom('[data-combobox]').hasAttribute('aria-autocomplete', 'list');
    assert.dom('[data-combobox]').hasAttribute('aria-haspopup', 'listbox');
    assert.dom('[data-combobox]').hasAttribute('autocapitalize', 'none');
    assert.dom('[data-combobox]').hasAttribute('autocomplete', 'off');
    assert.dom('[data-combobox]').hasAttribute('autocorrect', 'off');
    assert.dom('[data-combobox]').hasAttribute('role', 'combobox');
    assert.dom('[data-combobox]').hasAttribute('spellcheck', 'false');
    assert.dom('[data-combobox]').hasAttribute('type', 'text');
  });

  test('it disables the combobox using `@isDisabled`', async function (assert) {
    await render(<template>
      <ComboboxControl @isDisabled={{true}} data-combobox />
    </template>);

    assert.dom('[data-combobox]').isDisabled();
    assert.dom('[data-combobox]').hasClass('text-disabled');
    assert
      .dom('[data-combobox]')
      .doesNotHaveClass('text-titles-and-attributes');
  });

  test('it sets readonly on the combobox using `@isReadOnly`', async function (assert) {
    await render(<template>
      <ComboboxControl @isReadOnly={{true}} data-combobox />
    </template>);

    assert.dom('[data-combobox]').hasAttribute('readonly');

    assert.dom('[data-combobox]').hasClass('shadow-read-only-outline');
    assert.dom('[data-combobox]').hasClass('bg-surface-xl');
    assert.dom('[data-combobox]').hasNoClass('bg-overlay-1');
    assert.dom('[data-combobox]').hasNoClass('text-disabled');
    assert.dom('[data-combobox]').hasNoClass('shadow-error-outline');
    assert.dom('[data-combobox]').hasNoClass('shadow-focusable-outline');
  });

  test('it spreads attributes to the underlying combobox', async function (assert) {
    await render(<template>
      <ComboboxControl placeholder="Placeholder text" data-combobox />
    </template>);

    assert
      .dom('[data-combobox]')
      .hasAttribute('placeholder', 'Placeholder text');
  });

  test('it applies the error shadow when `@hasError={{true}}`', async function (assert) {
    await render(<template>
      <ComboboxControl @hasError={{true}} data-combobox />
    </template>);

    assert.dom('[data-combobox]').hasClass('shadow-error-outline');
    assert.dom('[data-combobox]').hasClass('focus:shadow-error-focus-outline');
    assert.dom('[data-combobox]').doesNotHaveClass('shadow-focusable-outline');
  });

  test('it opens the popover on click', async function (assert) {
    await render(<template>
      <ComboboxControl @options={{testColors}} data-combobox />
    </template>);

    assert.dom('[role="listbox"]').doesNotExist();

    await click('[data-combobox]');

    assert.dom('[role="listbox"]').exists();
  });

  test('it opens the popover when the input receives input', async function (assert) {
    await render(<template>
      <ComboboxControl @options={{testColors}} data-combobox />
    </template>);

    assert.dom('[role="listbox"]').doesNotExist();

    await fillIn('[data-combobox]', 'b');

    assert.dom('[role="listbox"]').exists();
  });

  test('it sets `aria-expanded` based on the popover state', async function (assert) {
    await render(<template>
      <ComboboxControl @options={{testColors}} data-combobox as |combobox|>
        <combobox.Option data-option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    assert.dom('[role="listbox"]').doesNotExist();

    assert.dom('[data-combobox]').hasNoAttribute('aria-expanded');

    await click('[data-combobox]');

    assert.dom('[data-combobox]').hasAttribute('aria-expanded');
  });

  test('it sets `aria-controls`', async function (assert) {
    await render(<template>
      <ComboboxControl @options={{testColors}} data-combobox as |combobox|>
        <combobox.Option data-option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    assert.dom('[data-combobox]').hasAttribute('aria-controls');
  });

  test('it applies the provided `@contentClass` to the popover content list', async function (assert) {
    await render(<template>
      <ComboboxControl
        @options={{testColors}}
        @contentClass="test-class"
        data-combobox
      />
    </template>);

    await click('[data-combobox]');

    assert.dom('[role="listbox"]').exists();
    assert.dom('[role="listbox"]').hasClass('test-class');
  });

  test('it renders the provided options in the popover list', async function (assert) {
    await render(<template>
      <ComboboxControl
        @options={{testColors}}
        @contentClass="test-class"
        data-combobox
        as |combobox|
      >
        <combobox.Option data-option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await click('[data-combobox]');

    assert.dom('[role="option"]').exists({ count: 2 });
    assert.dom('[data-option]').exists({ count: 2 });
  });

  test('it sets the value attribute via `@selected`', async function (assert) {
    await render(<template>
      <ComboboxControl
        @selected="blue"
        @options={{testColors}}
        data-combobox
        as |combobox|
      >
        <combobox.Option data-option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    assert.dom('[data-combobox]').hasValue('blue');
  });

  test('it sets the value attribute via `@selected` and `@optionKey` when `@selected` is an object', async function (assert) {
    let options = [
      {
        label: 'Blue',
        value: 'blue',
      },
    ];

    let selected = options[0];

    await render(<template>
      <ComboboxControl
        @selected={{selected}}
        @options={{options}}
        @optionKey="label"
        data-combobox
        as |combobox|
      >
        <combobox.Option data-option>{{combobox.option.label}}</combobox.Option>
      </ComboboxControl>
    </template>);

    assert.dom('[data-combobox]').hasValue('Blue');
  });

  test('it sets `aria-selected` properly on the list item that is currently selected', async function (assert) {
    await render(<template>
      <ComboboxControl
        @selected="blue"
        @options={{testColors}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await click('[data-combobox]');

    // Since `@selected="blue"`, we expect it to be selected
    assert
      .dom('[role="option"]:first-child')
      .hasAttribute('aria-selected', 'true');

    // ...but not the "red" one!
    assert
      .dom('[role="option"]:last-child')
      .hasAttribute('aria-selected', 'false');
  });

  test('it provides default filtering when `@options` is an array of strings', async function (assert) {
    await render(<template>
      <ComboboxControl @options={{testColors}} data-combobox as |combobox|>
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await fillIn('[data-combobox]', 'blue');

    // Filtering works as we expect
    assert.dom('[role="option"]').exists({ count: 1 });
    assert.dom('[role="option"]').hasText('blue');

    // Resetting the filter by clearing the input should
    // display all available options
    await fillIn('[data-combobox]', '');
    assert.dom('[role="option"]').exists({ count: 2 });

    // Verify we can filter again after clearing
    await fillIn('[data-combobox]', 'red');
    assert.dom('[role="option"]').exists({ count: 1 });
    assert.dom('[role="option"]').hasText('red');
  });

  test('it provides default filtering when `@options` is an array of objects and is provided with `@optionKey`', async function (assert) {
    let options = [
      {
        label: 'Blue',
        value: 'blue',
      },
      {
        label: 'Red',
        value: 'red',
      },
    ];

    await render(<template>
      <ComboboxControl
        @options={{options}}
        @optionKey="label"
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option.label}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await fillIn('[data-combobox]', 'blue');

    // Filtering works as we expect
    assert.dom('[role="option"]').exists({ count: 1 });
    // NOTE: We should be using option.label (capitalized "Blue" instead of "blue")
    assert.dom('[role="option"]').hasText('Blue');

    // Resetting the filter by clearing the input should
    // display all available options
    await fillIn('[data-combobox]', '');
    assert.dom('[role="option"]').exists({ count: 2 });

    // Verify we can filter again after clearing
    await fillIn('[data-combobox]', 'red');
    assert.dom('[role="option"]').exists({ count: 1 });
    // NOTE: We should be using option.label (capitalized "Red" instead of "red")
    assert.dom('[role="option"]').hasText('Red');
  });

  test('it uses the provided `@noResultsText` when no results are found with filtering', async function (assert) {
    await render(<template>
      <ComboboxControl
        @options={{testColors}}
        @noResultsText="No results"
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await fillIn('[data-combobox]', 'something-not-in-the-list');

    // We should not have any list items
    assert.dom('[role="option"]').exists({ count: 0 });

    // ...but we should have our no results item!
    assert.dom('[role="status"]').exists();
    assert.dom('[role="status"]').hasTagName('li');
    assert.dom('[role="status"]').hasText('No results');
    assert
      .dom('[role="status"]')
      .hasAttribute(
        'aria-live',
        'assertive',
        'Expected assertive so it is announced to screenreaders'
      );
  });

  test('it calls `@onChange` when an option is selected via mouse click', async function (assert) {
    assert.expect(5);

    let handleChange = (value: unknown) => {
      assert.strictEqual(value, 'blue', 'Expected input to match');
      assert.step('handleChange');
    };

    await render(<template>
      <ComboboxControl
        @options={{testColors}}
        @onChange={{handleChange}}
        data-combobox
        as |combobox|
      >
        <combobox.Option data-option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    assert.verifySteps([]);

    await fillIn('[data-combobox]', 'blue');

    assert.dom('[role="option"]').exists({ count: 1 });

    await click('[role="option"]');

    assert.verifySteps(['handleChange']);
  });

  test('it calls `@onChange` when an option is selected via the keyboard with ENTER', async function (assert) {
    assert.expect(5);

    let handleChange = (value: unknown) => {
      assert.strictEqual(value, 'blue', 'Expected input to match');
      assert.step('handleChange');
    };

    await render(<template>
      <ComboboxControl
        @options={{testColors}}
        @onChange={{handleChange}}
        data-combobox
        as |combobox|
      >
        <combobox.Option data-option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    assert.verifySteps([]);

    await fillIn('[data-combobox]', 'blue');

    assert.dom('[role="option"]').exists({ count: 1 });

    await triggerKeyEvent('[data-combobox]', 'keydown', 'Enter');

    assert.verifySteps(['handleChange']);
  });

  test('it uses the results from `@onFilter` to populate the filtered options', async function (assert) {
    assert.expect(5);

    let handleFilter = (value: unknown) => {
      assert.strictEqual(
        value,
        'y',
        'Expected the input to match what was entered via fillIn'
      );
      assert.step('onFilter');

      return ['yellow'];
    };

    await render(<template>
      <ComboboxControl
        @selected="blue"
        @options={{testColors}}
        @onFilter={{handleFilter}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await fillIn('[data-combobox]', 'y');

    assert.verifySteps(['onFilter']);

    assert.dom('[role="option"]').exists({ count: 1 });
    assert.dom('[role="option"]').hasText('yellow');
  });

  test('it sets the "active" item to the first one in the list when the combobox gains focus', async function (assert) {
    await render(<template>
      <ComboboxControl
        @selected="blue"
        @options={{testColors}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await click('[data-combobox]');

    assert.dom('[role="option"]').exists({ count: 2 });

    assert
      .dom('[role="option"]:first-child')
      .hasAttribute('data-active', 'true');
    assert
      .dom('[role="option"]:last-child')
      .hasAttribute('data-active', 'false');
  });

  test('it sets the "active" item to the next item in the list when using the DOWN arrow', async function (assert) {
    await render(<template>
      <ComboboxControl
        @selected="blue"
        @options={{testColors}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await click('[data-combobox]');

    assert.dom('[role="option"]').exists({ count: 2 });

    await triggerKeyEvent('[data-combobox]', 'keydown', 'ArrowDown');

    assert
      .dom('[role="option"]:first-child')
      .hasAttribute('data-active', 'false');
    assert
      .dom('[role="option"]:last-child')
      .hasAttribute('data-active', 'true');
  });

  test('it sets the "active" item to the previous item in the list when using the UP arrow', async function (assert) {
    // NOTE: Setting the selected option to "red" here so that
    // the last item in the list will be active so that we can
    // move up!
    await render(<template>
      <ComboboxControl
        @selected="red"
        @options={{testColors}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await click('[data-combobox]');

    assert.dom('[role="option"]').exists({ count: 2 });

    await triggerKeyEvent('[data-combobox]', 'keydown', 'ArrowUp');

    assert
      .dom('[role="option"]:first-child')
      .hasAttribute('data-active', 'true');
    assert
      .dom('[role="option"]:last-child')
      .hasAttribute('data-active', 'false');
  });

  test('it closes an open popover when the ESCAPE key is pressed', async function (assert) {
    await render(<template>
      <ComboboxControl @options={{testColors}} data-combobox as |combobox|>
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    await click('[data-combobox]');

    assert.dom('[role="listbox"]').exists();

    await triggerKeyEvent('[data-combobox]', 'keydown', 'Escape');

    assert.dom('[role="listbox"]').doesNotExist();
  });

  test('it closes an open popover when the component is blurred', async function (assert) {
    await render(<template>
      {{! template-lint-disable require-input-label }}
      <input placeholder="test" data-input />

      <ComboboxControl @options={{testColors}} data-combobox as |combobox|>
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    // Open the popover
    await click('[data-combobox]');

    assert.dom('[role="listbox"]').exists();

    // Now blur the elment
    await click('[data-input]');

    assert.dom('[role="listbox"]').doesNotExist();
  });

  test('it reopens the popover when any key is pressed if the popover is closed', async function (assert) {
    await render(<template>
      <ComboboxControl @options={{testColors}} data-combobox as |combobox|>
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    // Open the popover by clicking it
    await click('[data-combobox]');

    // Now close it
    await triggerKeyEvent('[data-combobox]', 'keydown', 'Escape');
    // Now reopen it
    await triggerKeyEvent('[data-combobox]', 'keydown', 'ArrowDown');

    assert.dom('[role="listbox"]').exists();
  });

  test('it makes the first option "active" when the metakey and UP arrow is pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the bottom of the list!
    await render(<template>
      <ComboboxControl
        @selected="f"
        @options={{options}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    // Open the popover by clicking it
    await click('[data-combobox]');

    await triggerKeyEvent('[data-combobox]', 'keydown', 'ArrowUp', {
      metaKey: true,
    });

    assert
      .dom('[role="option"]:first-child')
      .hasAttribute('data-active', 'true');
    // Verify our last item is no longer "active"
    assert
      .dom('[role="option"]:last-child')
      .hasAttribute('data-active', 'false');
  });

  test('it makes the last option "active" when the metakey and DOWN arrow is pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the top of the list!
    await render(<template>
      <ComboboxControl
        @selected="a"
        @options={{options}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    // Open the popover by clicking it
    await click('[data-combobox]');

    await triggerKeyEvent('[data-combobox]', 'keydown', 'ArrowDown', {
      metaKey: true,
    });

    assert
      .dom('[role="option"]:last-child')
      .hasAttribute('data-active', 'true');

    // Verify our first item is no longer "active"
    assert
      .dom('[role="option"]:first-child')
      .hasAttribute('data-active', 'false');
  });

  test('it makes the last option "active" when the PAGEDOWN key is pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the top of the list!
    await render(<template>
      <ComboboxControl
        @selected="a"
        @options={{options}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    // Open the popover by clicking it
    await click('[data-combobox]');

    await triggerKeyEvent('[data-combobox]', 'keydown', 'PageDown');

    assert
      .dom('[role="option"]:last-child')
      .hasAttribute('data-active', 'true');

    // Verify our first item is no longer "active"
    assert
      .dom('[role="option"]:first-child')
      .hasAttribute('data-active', 'false');
  });

  test('it makes the first option "active" when the PAGEUP key is pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the bottom of the list!
    await render(<template>
      <ComboboxControl
        @selected="f"
        @options={{options}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    // Open the popover by clicking it
    await click('[data-combobox]');

    await triggerKeyEvent('[data-combobox]', 'keydown', 'PageUp');

    assert
      .dom('[role="option"]:first-child')
      .hasAttribute('data-active', 'true');
    // Verify our last item is no longer "active"
    assert
      .dom('[role="option"]:last-child')
      .hasAttribute('data-active', 'false');
  });

  test('it makes the first option "active" when the HOME key is pressed', async function (assert) {
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the bottom of the list!
    await render(<template>
      <ComboboxControl
        @selected="f"
        @options={{options}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    // Open the popover by clicking it
    await click('[data-combobox]');

    await triggerKeyEvent('[data-combobox]', 'keydown', 'Home');

    assert
      .dom('[role="option"]:first-child')
      .hasAttribute('data-active', 'true');
    // Verify our last item is no longer "active"
    assert
      .dom('[role="option"]:last-child')
      .hasAttribute('data-active', 'false');
  });

  /**
   * This test covers the case where we have a selected option,
   * the user clears the input completely, and then the component's
   * input tag is blurred.  In that case, we want to clear the input
   * and reset their selection to null.
   */
  test('it calls `@onChange` with null after a user clears their original input selection', async function (assert) {
    assert.expect(4);

    let handleChange = (value: unknown) => {
      assert.strictEqual(value, null, 'Expected `value` to be null');
      assert.step('handleChange');
    };

    // NOTE: We have a selected option
    // NOTE: We add an input tag so we have something to blur to (by focusing another element)
    await render(<template>
      <ComboboxControl
        @selected="blue"
        @options={{testColors}}
        @onChange={{handleChange}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>

      {{! template-lint-disable require-input-label }}
      <input placeholder="test" data-input />
    </template>);

    await click('[data-combobox]');

    // Clear the input
    await fillIn('[data-combobox]', '');

    // Now blur the elment
    await click('[data-input]');

    assert.dom('[data-combobox]').hasValue('');
    assert.verifySteps(['handleChange']);
  });

  test('it reverts to the selected option when a user enters garbage after previously having a valid selection (with `@selected` as a string)', async function (assert) {
    assert.expect(3);

    let handleChange = () => {
      assert.step('do-not-expect-this-to-be-called!');
    };

    // NOTE: We have a selected option
    // NOTE: We add an input tag so we have something to blur to (by focusing another element)
    await render(<template>
      <ComboboxControl
        @selected="blue"
        @options={{testColors}}
        @onChange={{handleChange}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>

      {{! template-lint-disable require-input-label }}
      <input placeholder="test" data-input />
    </template>);

    await click('[data-combobox]');

    // Enter garbage into the input
    await fillIn('[data-combobox]', 'some-garbage');

    // Now blur the elment
    await click('[data-input]');

    // Verify the input is reset to our `@selected` option
    assert.dom('[data-combobox]').hasValue('blue');

    // NOTE: We do not expect the `@onChange`  to be called in this
    // case as we are only visually resetting to the previously
    // selected value
    assert.verifySteps([]);

    // We want to verify the original options are re-displayed
    // rather than the input being filtered to garbage
    await click('[data-combobox]');

    assert.dom('[role="option"]').exists({ count: 2 });
  });

  test('it reverts to the selected option when a user enters garbage after previously having a valid selection (with `@selected` as an object)', async function (assert) {
    assert.expect(3);

    let options = [
      {
        label: 'Blue',
        value: 'blue',
      },
      {
        label: 'Red',
        value: 'red',
      },
    ];

    let selected = options[0];

    let handleChange = () => {
      assert.step('do-not-expect-this-to-be-called!');
    };

    // NOTE: We have a selected option
    // NOTE: We add an input tag so we have something to blur to (by focusing another element)
    await render(<template>
      <ComboboxControl
        @selected={{selected}}
        @options={{options}}
        @optionKey="label"
        @onChange={{handleChange}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option.label}}</combobox.Option>
      </ComboboxControl>

      {{! template-lint-disable require-input-label }}
      <input placeholder="test" data-input />
    </template>);

    await click('[data-combobox]');

    // Enter garbage into the input
    await fillIn('[data-combobox]', 'some-garbage');

    // Now blur the elment
    await click('[data-input]');

    // Verify the input is reset to our `@selected` option
    assert.dom('[data-combobox]').hasValue('Blue');

    // NOTE: We do not expect the `@onChange`  to be called in this
    // case as we are only visually resetting to the previously
    // selected value
    assert.verifySteps([]);

    // We want to verify the original options are re-displayed
    // rather than the input being filtered to garbage
    await click('[data-combobox]');

    assert.dom('[role="option"]').exists({ count: 2 });
  });

  test('it reselects the entered input value when there is a selected item and the input regains focus', async function (assert) {
    await render(<template>
      <ComboboxControl
        @selected="blue"
        @options={{testColors}}
        data-combobox
        as |combobox|
      >
        <combobox.Option>{{combobox.option}}</combobox.Option>
      </ComboboxControl>
    </template>);

    assert.strictEqual(
      document.getSelection()?.toString(),
      '',
      'Expected nothing to be selected by default as we have not interacted with the component'
    );

    await click('[data-combobox]');

    assert.strictEqual(
      document.getSelection()?.toString(),
      'blue',
      'Expected "blue" to be selected since that is our `@selected` value'
    );
  });
});
