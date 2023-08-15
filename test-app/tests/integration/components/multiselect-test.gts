import { tracked } from '@glimmer/tracking';
import {
  click,
  fillIn,
  render,
  setupOnerror,
  triggerKeyEvent,
} from '@ember/test-helpers';
import { module, test } from 'qunit';

import Multiselect from '@crowdstrike/ember-toucan-core/components/form/controls/multiselect';
import { setupRenderingTest } from 'test-app/tests/helpers';

import { MultiselectPageObject } from '@crowdstrike/ember-toucan-core/test-support';

let testColors = ['blue', 'red'];

module('Integration | Component | Multiselect', function (hooks) {
  setupRenderingTest(hooks);

  let multiselectPageObject = new MultiselectPageObject('[data-input]');

  test('it renders', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    assert.dom(multiselectPageObject.element).hasTagName('input');
    assert.dom(multiselectPageObject.element).hasAttribute('role', 'combobox');
    assert.dom(multiselectPageObject.element).hasAttribute('type', 'text');

    assert
      .dom(multiselectPageObject.container)
      .hasClass('text-titles-and-attributes');

    assert
      .dom(multiselectPageObject.container)
      .hasClass('shadow-focusable-outline');

    assert
      .dom(multiselectPageObject.container)
      .doesNotHaveClass('text-disabled');

    assert
      .dom(multiselectPageObject.container)
      .doesNotHaveClass('shadow-error-outline');

    assert
      .dom(multiselectPageObject.container)
      .doesNotHaveClass('focus-within:shadow-error-focus-outline');

    assert
      .dom(multiselectPageObject.element)
      .hasAttribute('aria-autocomplete', 'list');

    assert
      .dom(multiselectPageObject.element)
      .hasAttribute('aria-haspopup', 'listbox');

    assert
      .dom(multiselectPageObject.element)
      .hasAttribute('autocapitalize', 'none');

    assert
      .dom(multiselectPageObject.element)
      .hasAttribute('autocomplete', 'off');

    assert
      .dom(multiselectPageObject.element)
      .hasAttribute('autocorrect', 'off');

    assert
      .dom(multiselectPageObject.element)
      .hasAttribute('spellcheck', 'false');
  });

  test('it disables the component using `@isDisabled`', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        @isDisabled={{true}}
        data-input
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

    assert
      .dom(multiselectPageObject.element)
      .doesNotHaveClass('text-titles-and-attributes');
  });

  test('it sets readonly on the input using `@isReadOnly`', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        @isReadOnly={{true}}
        data-input
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

    assert
      .dom(multiselectPageObject.container)
      .hasClass('shadow-read-only-outline');

    assert.dom(multiselectPageObject.container).hasClass('bg-surface-xl');
    assert.dom(multiselectPageObject.element).hasNoClass('bg-overlay-1');
    assert.dom(multiselectPageObject.element).hasNoClass('text-disabled');
    assert
      .dom(multiselectPageObject.element)
      .hasNoClass('shadow-error-outline');
    assert
      .dom(multiselectPageObject.element)
      .hasNoClass('shadow-focusable-outline');
  });

  test('it spreads attributes to the underlying input', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        placeholder="Placeholder text"
        data-input
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

  test('it applies the error shadow when `@hasError={{true}}`', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        @hasError={{true}}
        data-input
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
      .dom(multiselectPageObject.container)
      .hasClass('shadow-error-outline');

    assert
      .dom(multiselectPageObject.container)
      .hasClass('focus-within:shadow-error-focus-outline');

    assert
      .dom(multiselectPageObject.container)
      .doesNotHaveClass('shadow-focusable-outline');
  });

  test('it opens the popover on click', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    assert.dom(multiselectPageObject.list).doesNotExist();
    assert.dom(multiselectPageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(multiselectPageObject.element as Element);

    assert.dom(multiselectPageObject.list).exists();
  });

  test('it opens the popover when the input receives input', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    assert.dom(multiselectPageObject.list).doesNotExist();
    assert.dom(multiselectPageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'b');

    assert.dom(multiselectPageObject.list).exists();
  });

  // NOTE: This ensures that when a user clicks the border or the chevron
  //       that the input gets focused
  test('it focuses the input when the container element is clicked', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    assert.dom(multiselectPageObject.list).doesNotExist();
    assert.dom(multiselectPageObject.container).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(multiselectPageObject.container as Element);

    assert.dom(multiselectPageObject.element).isFocused();
    assert.dom(multiselectPageObject.list).exists();
  });

  test('it yields the `option`, `index`, `Chip`, and `Remove` to the `:chip` block and sets the `@label` on the Remove component', async function (assert) {
    let selected = ['blue'];

    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{selected}}
        @selected={{selected}}
        data-input
      >
        <:chip as |chip|>
          <chip.Chip data-test-index="{{chip.index}}">
            {{chip.option}}
            <chip.Remove data-remove="{{chip.option}}" @label="Remove" />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option data-option>
            {{multiselect.option}}
          </multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    // Verify the `chip.Remove` `@label` argument gets set to the aria-label properly
    // for screenreaders.  Without an aria-label attribute, screenreader users
    // will have 0 context on what the button does.
    assert
      .dom(multiselectPageObject.removes?.[0])
      .hasAttribute('aria-label', 'Remove');

    // Verify the `chip.option` gets yielded back properly via the `chip` block.
    assert.dom('[data-remove="blue"]').exists();

    // Verify the chip index gets yielded back
    assert.dom('[data-test-index="0"]').exists();
  });

  test('it sets `aria-expanded` based on the popover state', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    assert.dom(multiselectPageObject.list).doesNotExist();
    assert.dom(multiselectPageObject.element).exists();

    assert.dom(multiselectPageObject.element).hasNoAttribute('aria-expanded');

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(multiselectPageObject.element as Element);

    assert.dom(multiselectPageObject.element).hasAttribute('aria-expanded');
  });

  test('it sets `aria-controls`', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    assert.dom(multiselectPageObject.element).hasAttribute('aria-controls');
  });

  test('it applies the provided `@contentClass` to the popover content list', async function (assert) {
    await render(<template>
      <Multiselect
        @options={{testColors}}
        @contentClass="test-class"
        @noResultsText="No results"
        data-input
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

    assert.dom(multiselectPageObject.list).exists();
    assert.dom(multiselectPageObject.list).hasClass('test-class');
  });

  test('it renders the provided options in the popover list', async function (assert) {
    await render(<template>
      <Multiselect
        @options={{testColors}}
        @contentClass="test-class"
        @noResultsText="No results"
        data-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove @label="Remove" />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option
            data-option
          >{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);

    assert.dom(multiselectPageObject.element).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(multiselectPageObject.element as Element);

    assert.dom('[data-option]').exists({ count: 2 });
  });

  test('it renders a selected chip for each item provided via `@selected`', async function (assert) {
    let selected = ['blue', 'red'];

    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{testColors}}
        @noResultsText="No results"
        data-input
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

  test('it sets the label of each selected chip', async function (assert) {
    let options = ['a'];

    let selected = [...options];

    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @noResultsText="No results"
        data-input
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

    assert.strictEqual(multiselectPageObject.chips?.length, 1);
    assert.dom(multiselectPageObject.chips?.[0]).hasText('a');
  });

  test('it sets `aria-selected` properly on the list item that is currently selected', async function (assert) {
    let selected = ['blue'];

    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{testColors}}
        @noResultsText="No results"
        data-input
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

    // Since `@selected=["blue"]`, we expect it to be selected
    assert
      .dom(multiselectPageObject.options?.[0])
      .hasAttribute('aria-selected', 'true');

    // ...but not the "red" one!
    assert
      .dom(multiselectPageObject.options?.[1])
      .hasAttribute('aria-selected', 'false');
  });

  test("it checks each option's checkbox based on `@selected`", async function (assert) {
    let selected = ['blue'];

    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{testColors}}
        @noResultsText="No results"
        data-input
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

    // Since `@selected=['blue']`, we expect it to be checked
    assert.dom(multiselectPageObject.checkboxes?.[0]).isChecked();

    // ...but not the "red" one!
    assert
      .dom(
        multiselectPageObject.checkboxes?.[
          multiselectPageObject.checkboxes.length - 1
        ],
      )
      .isNotChecked();
  });

  test('it provides default filtering', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'blue');

    // Filtering works as we expect
    assert.strictEqual(multiselectPageObject.options?.length, 1);
    assert.dom(multiselectPageObject.options?.[0]).hasText('blue');

    // Resetting the filter by clearing the input should
    // display all available options
    await fillIn(multiselectPageObject.element as Element, '');
    assert.strictEqual(multiselectPageObject.options?.length, 2);

    // Verify we can filter again after clearing
    await fillIn(multiselectPageObject.element as Element, 'red');
    assert.strictEqual(multiselectPageObject.options?.length, 1);
    assert.dom(multiselectPageObject.options?.[0]).hasText('red');
  });

  test('it renders `@noResultsText`', async function (assert) {
    await render(<template>
      <Multiselect @noResultsText="No items" @options={{testColors}} data-input>
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

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(
      multiselectPageObject.element as Element,
      'something-not-in-the-list',
    );

    // We should not have any list items
    assert.strictEqual(multiselectPageObject.options?.length, 0);

    // ...but we should have our no results item!
    assert.dom(multiselectPageObject.status).exists();
    assert.dom(multiselectPageObject.status).hasTagName('li');
    assert.dom(multiselectPageObject.status).hasText('No items');

    assert
      .dom(multiselectPageObject.status)
      .hasAttribute(
        'aria-live',
        'assertive',
        'Expected assertive so it is announced to screenreaders',
      );
  });

  test('it calls `@onChange` when an option is selected via mouse click and keeps the popover open', async function (assert) {
    assert.expect(8);

    let handleChange = (value: string[]) => {
      assert.deepEqual(value, ['blue'], 'Expected input to match');
      assert.step('handleChange');
    };

    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        @onChange={{handleChange}}
        data-input
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

    assert.verifySteps([]);

    assert.dom(multiselectPageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'blue');

    assert.strictEqual(multiselectPageObject.options?.length, 1);

    assert.dom(multiselectPageObject.options?.[0]).exists();

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(multiselectPageObject.options?.[0] as Element);

    assert.verifySteps(['handleChange']);

    // Verify the popover remains open
    assert.dom(multiselectPageObject.list).exists();
  });

  test('it calls `@onChange` when an option is selected via the keyboard using the `Enter` key and keeps the popover open', async function (assert) {
    assert.expect(7);

    let handleChange = (value: string[]) => {
      assert.deepEqual(value, ['blue'], 'Expected input to match');
      assert.step('handleChange');
    };

    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        @onChange={{handleChange}}
        data-input
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

    assert.verifySteps([]);
    assert.dom(multiselectPageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'blue');

    assert.strictEqual(multiselectPageObject.options?.length, 1);

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Enter',
    );

    assert.verifySteps(['handleChange']);

    // Verify the popover remains open
    assert.dom(multiselectPageObject.list).exists();
  });

  test('it calls `@onChange` with newly added values', async function (assert) {
    assert.expect(4);

    let selected = ['a', 'b', 'c'];
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    let handleChange = (value: string[]) => {
      assert.deepEqual(
        value,
        ['a', 'b', 'c', 'd'],
        'Expected "d" to be added on change',
      );
      assert.step('handleChange');
    };

    // NOTE: starting with selected options already!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @onChange={{handleChange}}
        @noResultsText="No results"
        data-input
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

    // Select another option, "d". `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'd');

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Enter',
    );

    assert.verifySteps(['handleChange']);
  });

  test('it calls `@onChange` when a chip is removed by click the "X"/remove button', async function (assert) {
    assert.expect(6);

    let selected = ['a', 'b', 'c'];
    let options = ['a', 'b', 'c'];

    let handleChange = (value: string[]) => {
      assert.deepEqual(
        value,
        ['a', 'c'],
        'Expected "b" to be removed on change',
      );

      assert.step('handleChange');
    };

    // NOTE: starting with selected options already!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @onChange={{handleChange}}
        @noResultsText="No results"
        data-input
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

    assert.strictEqual(multiselectPageObject.removes?.length, 3);

    assert.ok(
      multiselectPageObject.removes?.[1],
      'Expected the middle remove button to be available',
    );

    assert.dom(multiselectPageObject.removes?.[1]).exists();

    // Remove the middle item. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(multiselectPageObject.removes?.[1] as Element);

    assert.verifySteps(['handleChange']);
  });

  test('it removes the last selected item and calls `@onChange` when `Backspace` is pressed with an empty input', async function (assert) {
    assert.expect(4);

    let options = ['a', 'b', 'c'];
    let selected = [...options];

    let handleChange = (value: string[]) => {
      assert.deepEqual(
        value,
        ['a', 'b'],
        'Expected "b" to be removed on change',
      );
      assert.step('handleChange');
    };

    // NOTE: starting with selected options already!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @onChange={{handleChange}}
        @noResultsText="No results"
        data-input
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

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Backspace',
    );

    assert.verifySteps(['handleChange']);
  });

  test('it removes an item when it is re-selected after already being selected and calls `@onChange`', async function (assert) {
    assert.expect(4);

    let options = ['a', 'b', 'c'];
    let selected = [...options];

    let handleChange = (value: string[]) => {
      assert.deepEqual(
        value,
        ['b', 'c'],
        'Expected "a" to be removed on change as it was re-selected',
      );
      assert.step('handleChange');
    };

    // NOTE: starting with selected options already!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @onChange={{handleChange}}
        @noResultsText="No results"
        data-input
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

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'a');
    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Enter',
    );

    assert.verifySteps(['handleChange']);
  });

  /**
   * This handles the case where a user is actively filtering and presses the
   * backspace key.  For this case, we do NOT want to remove a selected chip,
   * as the user is interacting with filtering rather than attempting to delete
   * an item.
   */
  test('it does **NOT** call `@onChange` if the input has a value and the backspace key is pressed', async function (assert) {
    assert.expect(2);

    let selected = ['a', 'b', 'c'];
    let options = ['a', 'b', 'c'];

    let handleChange = () => {
      assert.step('do-not-expect-this-to-be-called!');
    };

    // NOTE: starting with selected options already!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @onChange={{handleChange}}
        @noResultsText="No results"
        data-input
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

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'testing');

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Backspace',
    );

    assert.verifySteps([]);
  });

  test('it does not render the "X"/remove button on selected chips when `@isDisabled={{true}}`', async function (assert) {
    let options = ['a', 'b', 'c'];
    let selected = [...options];

    // NOTE: starting with selected options already!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @isDisabled={{true}}
        @noResultsText="No results"
        data-input
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

    assert.strictEqual(multiselectPageObject.removes?.length, 0);
  });

  test('it does not render the "X"/remove button on selected chips when `@isReadOnly={{true}}`', async function (assert) {
    let options = ['a', 'b', 'c'];
    let selected = [...options];

    // NOTE: starting with selected options already!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @isReadOnly={{true}}
        @noResultsText="No results"
        data-input
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

    assert.strictEqual(multiselectPageObject.removes?.length, 0);
  });

  test('it uses the results from `@onFilter` to populate the filtered options', async function (assert) {
    assert.expect(6);

    let selected = ['blue'];

    let handleFilter = (value: unknown) => {
      assert.strictEqual(
        value,
        'y',
        'Expected the input to match what was entered via fillIn',
      );
      assert.step('onFilter');

      return ['yellow'];
    };

    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{testColors}}
        @onFilter={{handleFilter}}
        @noResultsText="No results"
        data-input
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

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'y');

    assert.verifySteps(['onFilter']);
    assert.strictEqual(multiselectPageObject.options?.length, 1);
    assert.dom(multiselectPageObject.options?.[0]).hasText('yellow');
  });

  test('it sets the "active" item to the first one in the list when the input gains focus', async function (assert) {
    let selected = ['blue'];

    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{testColors}}
        @noResultsText="No results"
        data-input
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

    assert.strictEqual(multiselectPageObject.options?.length, 2);

    assert.dom(multiselectPageObject.options?.[0]).exists();

    assert.strictEqual(
      multiselectPageObject.options?.[0],
      multiselectPageObject.active,
    );
  });

  test('it sets the "active" item to the next item in the list when `ArrowDown` is pressed', async function (assert) {
    let selected = ['blue'];

    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{testColors}}
        @noResultsText="No results"
        data-input
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

    assert.strictEqual(multiselectPageObject.options?.length, 2);

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowDown',
    );

    assert
      .dom(
        multiselectPageObject.options?.[
          multiselectPageObject.options.length - 1
        ],
      )
      .exists();

    assert.strictEqual(
      multiselectPageObject.options?.[multiselectPageObject.options.length - 1],
      multiselectPageObject.active,
    );
  });

  test('it sets the "active" item to the previous item in the list when `ArrowUp` is pressed', async function (assert) {
    let selected = ['red'];

    // NOTE: Setting the selected option to "red" here so that
    // the last item in the list will be active so that we can
    // move up!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{testColors}}
        @noResultsText="No results"
        data-input
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

    assert.strictEqual(multiselectPageObject.options?.length, 2);

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowUp',
    );

    assert.dom(multiselectPageObject.options?.[0]).exists();

    assert.strictEqual(
      multiselectPageObject.options?.[0],
      multiselectPageObject.active,
    );
  });

  test('it closes an open popover when the ESCAPE key is pressed', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    assert.dom(multiselectPageObject.list).exists();

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Escape',
    );

    assert.dom(multiselectPageObject.list).doesNotExist();
  });

  test('it closes an open popover when the component is blurred', async function (assert) {
    // NOTE: We add an input tag so we have something to blur to (by focusing another element)
    await render(<template>
      {{! template-lint-disable require-input-label }}
      <input placeholder="test" />

      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    assert.dom(multiselectPageObject.list).exists();

    // Now blur the element by focusing the other input element in our test

    await click('[placeholder="test"]');

    assert.dom(multiselectPageObject.list).doesNotExist();
  });

  test('it reopens the popover when any key is pressed if the popover is closed', async function (assert) {
    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
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

    // Open the popover. `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await click(multiselectPageObject.element as Element);

    // Now close it
    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Escape',
    );
    // Now reopen it
    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowDown',
    );

    assert.dom(multiselectPageObject.list).exists();
  });

  test('it makes the first option "active" when the metakey and UP arrow is pressed', async function (assert) {
    let selected = ['f'];
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the bottom of the list!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @noResultsText="No results"
        data-input
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

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowDown',
    );

    assert.dom(multiselectPageObject.options?.[1]).exists();

    // Assert that the first option is activated so we can later be sure that pressing `metaKey` and `ArrowDown` did something.
    assert.strictEqual(
      multiselectPageObject.options?.[1],
      multiselectPageObject.active,
    );

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowUp',
      {
        metaKey: true,
      },
    );

    assert.dom(multiselectPageObject.options?.[0]).exists();

    assert.strictEqual(
      multiselectPageObject.options?.[0],
      multiselectPageObject.active,
    );
  });

  test('it makes the last option "active" when the metakey and DOWN arrow is pressed', async function (assert) {
    let selected = ['a'];
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the top of the list!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @noResultsText="No results"
        data-input
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

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowDown',
      {
        metaKey: true,
      },
    );

    assert
      .dom(
        multiselectPageObject.options?.[
          multiselectPageObject.options.length - 1
        ],
      )
      .exists();

    assert.strictEqual(
      multiselectPageObject.options?.[multiselectPageObject.options.length - 1],
      multiselectPageObject.active,
    );
  });

  test('it makes the last option "active" when `PageDown` is pressed', async function (assert) {
    let selected = ['a'];
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the top of the list!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @noResultsText="No results"
        data-input
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

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'PageDown',
    );

    assert
      .dom(
        multiselectPageObject.options?.[
          multiselectPageObject.options.length - 1
        ],
      )
      .exists();

    assert.strictEqual(
      multiselectPageObject.options?.[multiselectPageObject.options.length - 1],
      multiselectPageObject.active,
    );
  });

  test('it makes the first option "active" when `PageUp` is pressed', async function (assert) {
    let selected = ['f'];
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the bottom of the list!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @noResultsText="No results"
        data-input
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

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowDown',
    );

    assert.dom(multiselectPageObject.options?.[1]).exists();

    // Assert that the first option is activated so we can later be sure that pressing `metaKey` and `ArrowDown` did something.
    assert.strictEqual(
      multiselectPageObject.options?.[1],
      multiselectPageObject.active,
    );

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'PageUp',
    );

    assert.dom(multiselectPageObject.options?.[0]).exists();

    assert.strictEqual(
      multiselectPageObject.options?.[0],
      multiselectPageObject.active,
    );
  });

  test('it makes the first option "active" when `Home` is pressed', async function (assert) {
    let selected = ['f'];
    let options = ['a', 'b', 'c', 'd', 'e', 'f'];

    // NOTE: Our selected option is currently at the bottom of the list!
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{options}}
        @noResultsText="No results"
        data-input
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

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowDown',
    );

    assert.dom(multiselectPageObject.options?.[1]).exists();

    // Assert that the first option is activated so we can later be sure that pressing `metaKey` and `ArrowDown` did something.
    assert.strictEqual(
      multiselectPageObject.options?.[1],
      multiselectPageObject.active,
    );

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Home',
    );

    assert.dom(multiselectPageObject.options?.[0]).exists();

    assert.strictEqual(
      multiselectPageObject.options?.[0],
      multiselectPageObject.active,
    );
  });

  // This tests our `resetValue` action
  test('it clears the input value when a user enters invalid text into the input without selecting anything and then blurs the input', async function (assert) {
    assert.expect(4);

    let selected = ['blue'];

    let handleChange = () => {
      assert.step('do-not-expect-this-to-be-called!');
    };

    // NOTE: We have a selected option
    // NOTE: We add an input tag so we have something to blur to (by focusing another element)
    await render(<template>
      <Multiselect
        @selected={{selected}}
        @options={{testColors}}
        @onChange={{handleChange}}
        @noResultsText="No results"
        data-input
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

      {{! template-lint-disable require-input-label }}
      <input placeholder="test" />
    </template>);

    assert.dom(multiselectPageObject.element).exists();

    // `assert.dom().exists` should narrow the type, removing `null`. But it doesn't. Thus the cast.
    await fillIn(multiselectPageObject.element as Element, 'garbage');

    // Now blur autocomplete's input by focusing another element
    await click('[placeholder="test"]');

    // Verify the input is reset to our `@selected` option
    assert.dom(multiselectPageObject.element).hasValue('');

    // NOTE: We do not expect the `@onChange`  to be called in this
    // case as we are only visually resetting to the previously
    // selected value
    assert.verifySteps([]);

    // We want to verify the original options are re-displayed
    // rather than the input being filtered to garbage
    await click(multiselectPageObject.element as Element);

    assert.strictEqual(multiselectPageObject.options?.length, 2);
  });

  test('it renders the `Select all` option when provided with `@selectAllText`', async function (assert) {
    await render(<template>
      <Multiselect
        @options={{testColors}}
        @noResultsText="No results"
        @selectAllText="Select all"
        data-input
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

    assert.dom(multiselectPageObject.selectAllCheckbox).exists();
  });

  test('it handles all possible state changes when the `Select all` option is interacted with', async function (assert) {
    assert.expect(24);

    class State {
      @tracked selected: string[] = [];
    }

    let state = new State();

    let handleChange = (values: string[]) => {
      state.selected = values;
      assert.step(values?.length > 0 ? values.join(',') : 'empty');
    };

    await render(<template>
      <Multiselect
        @selected={{state.selected}}
        @options={{testColors}}
        @onChange={{handleChange}}
        @noResultsText="No results"
        @selectAllText="Select all"
        data-input
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

    // Verify default state of `Select all` is not checked
    assert
      .dom(multiselectPageObject.selectAllCheckbox)
      .hasProperty('indeterminate', false);

    assert.dom(multiselectPageObject.selectAllCheckbox).isNotChecked();

    // Verify the list item has the proper default aria-selected attribute of false
    assert
      .dom(multiselectPageObject.selectAll)
      .hasAttribute('aria-selected', 'false');

    assert.dom(multiselectPageObject.element).exists();

    // Unchecked -> checked should make all options selected. `assert.dom().exists` should narrow the type, removing `null`.
    // But it doesn't. Thus the cast.
    await click(multiselectPageObject.selectAll as Element);

    // Verify `Select all` checkbox state
    assert
      .dom(multiselectPageObject.selectAllCheckbox)
      .hasProperty('indeterminate', false);

    assert.dom(multiselectPageObject.selectAllCheckbox).isChecked();

    // Verify the list item has the proper aria-selected attribute of true, since it's selected
    assert
      .dom(multiselectPageObject.selectAll)
      .hasAttribute('aria-selected', 'true');

    assert.verifySteps(['blue,red']);

    // Remove the "red" option by selecting it
    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowDown',
    );

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'ArrowDown',
    );

    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Enter',
    );

    // Our selected item should now only be "blue" since we removed "red" above
    assert.verifySteps(['blue']);

    // Verify the `Select all` checkbox is now indeterminate
    assert
      .dom(multiselectPageObject.selectAllCheckbox)
      .hasProperty('indeterminate', true);

    // Verify the list item has the proper aria-selected attribute of false, since the
    // checkbox is in the indeterminate state
    assert
      .dom(multiselectPageObject.selectAll)
      .hasAttribute('aria-selected', 'false');

    // When the `Select all` checkbox is indeterminate, clicking it should re-select all options
    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Enter',
    );

    assert.verifySteps(['blue,red']);

    assert
      .dom(multiselectPageObject.selectAllCheckbox)
      .hasProperty('indeterminate', false);

    assert.dom(multiselectPageObject.selectAllCheckbox).isChecked();

    // Verify the list item has the proper aria-selected attribute of true, since it's selected
    assert
      .dom(multiselectPageObject.selectAll)
      .hasAttribute('aria-selected', 'true');

    // Re-clicking the `Select all` checkbox when it's checked should un-check all options
    // Go back to the top and select it
    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Home',
    );
    await triggerKeyEvent(
      multiselectPageObject.element as Element,
      'keydown',
      'Enter',
    );

    assert.verifySteps(['empty']);

    assert
      .dom(multiselectPageObject.selectAllCheckbox)
      .hasProperty('indeterminate', false);

    assert.dom(multiselectPageObject.selectAllCheckbox).isNotChecked();

    // Verify the list item has the proper aria-selected attribute of false, since it's
    // no longer selected
    assert
      .dom(multiselectPageObject.selectAll)
      .hasAttribute('aria-selected', 'false');
  });

  test('it throws an assertion error if no `:chip` block is provided', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes('The `:chip` block is required'),
        'Expected assertion error message',
      );
    });

    await render(<template>
      <Multiselect
        @noResultsText="No results"
        @options={{testColors}}
        data-input
      >
        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);
  });

  test('it throws an assertion error if no `@label` argument is provided to the Remove component', async function (assert) {
    assert.expect(1);

    setupOnerror((e: Error) => {
      assert.ok(
        e.message.includes(
          'The Remove component "@label" argument is required',
        ),
        'Expected assertion error message',
      );
    });

    await render(<template>
      <Multiselect
        @options={{testColors}}
        @selected={{testColors}}
        @noResultsText="No results"
        data-input
      >
        <:chip as |chip|>
          <chip.Chip>
            {{chip.option}}
            <chip.Remove />
          </chip.Chip>
        </:chip>

        <:default as |multiselect|>
          <multiselect.Option>{{multiselect.option}}</multiselect.Option>
        </:default>
      </Multiselect>
    </template>);
  });
});
