import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import { next } from '@ember/runloop';
import { isEqual as emberIsEqual } from '@ember/utils';

import { offset, size } from '@floating-ui/dom';

import OptionComponent, {
  selector as optionComponentSelector,
} from '../../../-private/components/form/controls/multiselect/option';
import RemoveComponent from '../../../-private/components/form/controls/multiselect/remove';
import Chevron from '../../../-private/icons/chevron';
import Cross from '../../../-private/icons/cross';

import type { Middleware as VelcroMiddleware } from '@floating-ui/dom';
import type { WithBoundArgs } from '@glint/template';

export type Option = string | Record<string, unknown> | undefined;

export interface ToucanFormMultiselectControlComponentSignature<
  OPTION extends Option
> {
  Args: {
    /**
     * A CSS class to add to this component's content container.
     * Commonly used to specify a `z-index`.
     */
    contentClass?: string;

    /**
     * Sets the input to an errored-state via styling.
     */
    hasError?: boolean;

    /**
     * Sets the `disabled` attribute of the input.
     */
    isDisabled?: boolean;

    /**
     * Sets the `readonly` attribute of the input.
     */
    isReadOnly?: boolean;

    /**
     * A string to display when there are no results after the user's filter.
     */
    noResultsText?: string;

    /**
     * Called when the user makes a selection.
     * It is called with the selected options (derived from `@options`) as its only argument.
     */
    onChange?: (option: OPTION[]) => void;

    /**
     * The function called when a user types into the textbox, typically used to write custom filtering logic.
     */
    onFilter?: (input: string) => OPTION[];

    /**
     * `@options` forms the content of this component.
     *
     * `@options` is simply iterated over then passed back to you as a block parameter (`multiselect.option`).
     */
    options?: OPTION[];

    /**
     * When `@options` is an array of objects, `@selected` is also an object.
     * The `@optionKey` is used to determine which key of the object should
     * be used for both filtering and displaying the selected values in the
     * selected chips.
     */
    optionKey?: OPTION extends Record<string, unknown>
      ? keyof OPTION
      : undefined;

    /**
     * The currently selected options.  If `@options` is an array of strings, provide an array of strings.  If `@options` is an array of objects, pass an array of objects matching the format of `@options`.
     */
    selected?: OPTION[];
  };
  Blocks: {
    default: [
      {
        option: OPTION;
        Option: WithBoundArgs<
          typeof OptionComponent,
          | 'index'
          | 'isActive'
          | 'isDisabled'
          | 'isReadOnly'
          | 'onClick'
          | 'onMouseover'
          | 'popoverId'
        >;
      }
    ];
    remove: [
      {
        option: Option;
        Remove: WithBoundArgs<
          typeof RemoveComponent,
          'onClick' | 'onMouseDown'
        >;
      }
    ];
  };
  Element: HTMLInputElement;
}

export default class ToucanFormMultiselectControlComponent<
  OPTION extends Option
> extends Component<ToucanFormMultiselectControlComponentSignature<OPTION>> {
  @tracked activeIndex: number | null = null;
  @tracked inputValue: string | undefined;
  @tracked isPopoverOpen = false;
  @tracked filteredOptions: OPTION[] | undefined;

  Chevron = Chevron;
  Cross = Cross;
  Option = OptionComponent;
  RemoveComponent = RemoveComponent;
  popoverId = `popover--${guidFor(this)}`;

  /**
   * The component requires the `:remove` block for accessibility reasons.
   */
  assertRequiredBlocksExist = ({
    removeBlockExists,
  }: {
    removeBlockExists: boolean;
  }) => {
    assert('The `:remove` block is required.', removeBlockExists);

    if (!removeBlockExists) {
      return false;
    }

    return true;
  };

  velcroMiddleware: VelcroMiddleware[] = [
    offset({
      mainAxis: 8,
    }),
    size({
      apply({ rects, elements }) {
        Object.assign(elements.floating.style, {
          width: `${rects.reference.width}px`,
        });
      },
    }),
  ];

  /**
   * This is required for accessibility so that we can announce to the screenreader the highlighted option as the user uses the arrow keys.
   */
  get activeDescendant() {
    // For the case where nothing is selected on render
    if (this.activeIndex === null) {
      return null;
    }

    return `${this.popoverId}-${this.activeIndex}`;
  }

  /**
   * This state is used to determine if we should add event handlers to the input element or not.
   */
  get isDisabledOrReadOnlyOrWithoutOptions() {
    return (
      this.args.isDisabled ||
      this.args.isReadOnly ||
      this.args.options === undefined
    );
  }

  /**
   * The state of the component when it is not disabled or read only.
   */
  get isEnabled() {
    return !(this.args.isDisabled || this.args.isReadOnly);
  }

  /**
   * Returns the selected items, either from component arguments, or a default
   * empty array for convenience.
   */
  get selected() {
    return this.args.selected || [];
  }

  /**
   * We apply different styles to the container based on our current state.
   */
  get styles() {
    if (this.args.isDisabled) {
      return 'shadow-focusable-outline bg-overlay-1 text-disabled pointer-events-none placeholder:text-disabled';
    }

    if (this.args.isReadOnly) {
      return 'focus:shadow-focus-outline bg-surface-xl shadow-read-only-outline text-titles-and-attributes placeholder:text-titles-and-attributes';
    }

    if (this.args.hasError) {
      return 'shadow-error-outline focus-within:shadow-error-focus-outline bg-overlay-1 text-titles-and-attributes';
    }

    return 'shadow-focusable-outline focus-within:shadow-focus-outline bg-overlay-1 text-titles-and-attributes';
  }

  /**
   * The options to render inside of the popover list.
   */
  get options() {
    return this.filteredOptions || this.args?.options;
  }

  /**
   * Attempts to scroll the active or newly highlighted item into view for the user.
   */
  scrollActiveOptionIntoView(alignToTop?: boolean) {
    assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);

    const optionsElements = document.querySelectorAll(
      `#${this.popoverId} ${optionComponentSelector}`
    );
    const optionElement = optionsElements[this.activeIndex];

    if (!optionElement) {
      return;
    }

    optionElement.scrollIntoView(alignToTop);
  }

  /**
   * Removes an option from the selected array at a particular index
   * and calls the provided `@onChange` with the updated array.
   */
  @action
  removeSelection(index: number, event: MouseEvent) {
    // We need prevent default here so that clicking the remove button
    // does not close the popover
    event.preventDefault();

    const updatedArray = [...this.selected];

    updatedArray?.splice(index, 1);

    this.args.onChange?.(updatedArray);
  }

  /**
   * Handler for when the mouse down happens on the remove button.
   * We need prevent default here as well so that clicking the remove button
   * does not close the popover.
   */
  @action
  handleRemoveMouseDown(event: MouseEvent) {
    event.preventDefault();
  }

  /**
   * Closes the popover.
   */
  @action
  closePopover() {
    this.isPopoverOpen = false;
  }

  /**
   * A noop function for our input event handlers when we are disabled,
   * in the read only state, or have no valid options.
   */
  @action
  noop() {
    // eslint-disable @typescript-eslint/no-empty-function
  }

  /**
   * Action that formats each chip's label. When `@optionKey` is not provided,
   * we assume we are dealing with an array of strings and use the raw string
   * value.  When `@optionKey` is provided, we assume each option is an object
   * and use the provided key for the lookup value.
   */
  @action
  getOptionLabel(option: Option) {
    let { optionKey } = this.args;

    if (!optionKey) {
      assert(
        'Expected `option` to be a string value',
        typeof option === 'string'
      );

      return option;
    }

    assert('Expected `@optionKey`', optionKey);

    assert(
      'Expected `option` to be an object since `@optionKey` was provided',
      typeof option === 'object'
    );

    return option[optionKey] as string;
  }

  /**
   * Action called when a new item is selected. Ultimately calls the provided
   * `@onChange` with the newly selected item.
   */
  @action
  onChange() {
    assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);

    assert(
      '`this.args.options` cannot be  `undefined`',
      this.args.options !== undefined
    );

    assert(
      '`this.options` was unexpectedly empty in an on change handler. If you see this, please report it as a bug to ember-toucan-core!',
      this.options
    );

    // This shouldn't be possible, but to satisfy TS
    if (this.activeIndex === null) {
      return;
    }

    const selected = this.selected;
    const selectedOption = this.options[this.activeIndex];

    assert(
      '`this.options[this.activeIndex]` was unexpectedly empty in an on change handler. If you see this, please report it as a bug to ember-toucan-core!',
      selectedOption
    );

    this.inputValue = undefined;

    // Below handles these two cases:
    // 1) We do NOT have the item already in `selected`.
    //    Then we need to add it to the array of `selected` and call `onChange`.
    // 2) We DO have the item already in `selected`.
    //    Then we need to _remove_ it from the array and pass the
    //    new array to `onChange`.
    let existingItemIndex = this.getOptionIndexFromSelected(selectedOption);

    if (existingItemIndex > -1) {
      // Remove the item since it already exists
      const updatedArray = [...this.selected];

      updatedArray?.splice(existingItemIndex, 1);

      this.args.onChange?.(updatedArray);
    } else {
      // Add the item since it does NOT exist
      this.args.onChange?.([...selected, selectedOption]);
    }

    this.filteredOptions = undefined;
  }

  /**
   * Returns the index of a particular option from the selected array.
   * If the item is not found in the selected array, it returns -1.
   */
  getOptionIndexFromSelected(option: Option) {
    // Handle comparing an array of strings
    if (!this.args.optionKey) {
      return (this.args.selected as string[])?.findIndex(
        (opt) => opt === option
      );
    }

    // Handle comparing when we have an array of objects
    if (this.args.optionKey) {
      const optionAsObject = option as Record<string, unknown>;
      const optionKey = this.args.optionKey as string;

      return (this.args.selected as Record<string, unknown>[])?.findIndex(
        (opt) =>
          opt[this.args.optionKey as string] === optionAsObject[optionKey]
      );
    }

    return -1;
  }

  /**
   * Compares two arguments to determine if they are equal or not.
   */
  @action
  isEqual(one: number | Option | null, two: number | Option | null) {
    return emberIsEqual(one, two);
  }

  /**
   * Action used to determine if a particular option is selected or not
   * by the user.  If the option is selected, the checkbox for that option
   * will be checked.
   */
  @action
  isSelected(option: Option) {
    if (!this.args.selected) {
      return false;
    }

    if (!option) {
      return false;
    }

    return this.getOptionIndexFromSelected(option) >= 0;
  }

  /**
   * Handle keyboard events to operate like a combobox as defined at https://www.w3.org/WAI/ARIA/apg/patterns/combobox/.
   */
  @action
  onKeydown(event: KeyboardEvent) {
    assert(
      'Expected HTMLInputElement',
      event.target instanceof HTMLInputElement
    );

    if (event.key === 'Tab') {
      return;
    }

    if (!this.isPopoverOpen) {
      // Prevents keys like ArrowDown and ArrowUp from scrolling the page.
      event.preventDefault();

      this.openPopover();

      return;
    }

    if (!this.isPopoverOpen && event.key === 'Escape') {
      this.openPopover();

      return;
    }

    // Handle the case where the user uses the backspace key
    // to remove options.  This is only a valid case when the input
    // tag they are typing into is empty.
    if (
      event.key === 'Backspace' &&
      event.target.value === '' &&
      this.args.selected &&
      this.args.selected?.length > 0
    ) {
      let updatedArray = [...this.args.selected];

      updatedArray.pop();

      this.args.onChange?.(updatedArray);
    }

    if (event.key === 'Escape') {
      this.closePopover();

      return;
    }

    if (event.key === 'Enter' && this.activeIndex !== null) {
      // Prevents a "click" event from firing and reopening the popover.
      event.preventDefault();

      this.onChange();

      return;
    }

    if (event.key === ' ' && this.activeIndex !== null) {
      return;
    }

    if (
      (event.key === 'ArrowDown' && event.metaKey) ||
      event.key === 'PageDown' ||
      event.key === 'End'
    ) {
      assert(
        '`this.args.options` cannot be  `undefined`',
        this.args.options !== undefined
      );

      // By default, arrowing up and down moves the insertion point to the beginning or end
      // of an input field. We don't want this. We want to reserve arrowing for moving
      // vertically through the list.
      event.preventDefault();

      const activeIndex = this.args.options.length - 1;

      this.activeIndex = activeIndex;
      this.scrollActiveOptionIntoView(false);

      return;
    }

    if (event.key === 'ArrowDown') {
      assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);
      assert(
        '`this.args.options` cannot be  `undefined`',
        this.args.options !== undefined
      );
      event.preventDefault();

      const activeIndex =
        this.activeIndex === this.args.options.length - 1
          ? this.activeIndex
          : this.activeIndex + 1;

      this.activeIndex = activeIndex;

      this.scrollActiveOptionIntoView(false);

      return;
    }

    if (
      (event.key === 'ArrowUp' && event.metaKey) ||
      event.key === 'PageUp' ||
      event.key === 'Home'
    ) {
      event.preventDefault();

      const activeIndex = 0;

      this.activeIndex = activeIndex;
      this.scrollActiveOptionIntoView();

      return;
    }

    if (event.key === 'ArrowUp') {
      assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);
      event.preventDefault();

      const activeIndex =
        this.activeIndex === 0 ? this.activeIndex : this.activeIndex - 1;

      this.activeIndex = activeIndex;
      this.scrollActiveOptionIntoView();

      return;
    }
  }

  /**
   * Handles filtering when a user types into the input element.
   */
  @action
  async onInput(event: Event | InputEvent) {
    assert(
      'Expected HTMLInputElement',
      event.target instanceof HTMLInputElement
    );

    const value = event.target.value;

    this.inputValue = value;

    const { options, optionKey, onFilter } = this.args;
    const optionsArgument = options ? [...options] : [];

    let filteredOptions: OPTION[] = [];

    if (!onFilter && !optionKey) {
      filteredOptions = (optionsArgument as string[])?.filter(
        (option: string) =>
          option.toLowerCase().startsWith(value.toLowerCase()) as unknown
      ) as OPTION[];
    }

    if (!onFilter && optionKey) {
      filteredOptions = optionsArgument?.filter((option) =>
        ((option as Record<string, unknown>)[optionKey] as string)
          ?.toLowerCase()
          ?.startsWith(value.toLowerCase())
      );
    }

    if (onFilter) {
      filteredOptions = onFilter(value);
    }

    this.filteredOptions = filteredOptions;

    if (this.filteredOptions?.length > 0) {
      this.activeIndex = 0;
    }
  }

  /**
   * Sets the local active index when a user uses the mouse to hover over
   * an option.
   */
  @action
  onOptionMouseover(index: number) {
    this.activeIndex = index;
  }

  /**
   * If a user clicks the border of the container or on the chevron SVG
   * we want to focus the input so that the user does not have to click
   * directly on the input tag itself.
   */
  @action
  handleContainerClick() {
    if (!this.isPopoverOpen) {
      (
        document.querySelector(
          '[data-toucan-multiselect-input]'
        ) as HTMLInputElement
      )?.focus();
    }
  }

  /**
   * Opens the popover and sets the active index if one is not set. If an active
   * index is set, it attempts to scroll the option into view.
   */
  @action
  openPopover() {
    this.isPopoverOpen = true;

    if (this.activeIndex === null) {
      this.activeIndex = 0;
    } else {
      // Wait until the options have been rendered.
      next(() => {
        this.scrollActiveOptionIntoView(false);
      });
    }
  }

  /**
   * Resets the value and filtered options when the input is blurred.
   */
  @action
  resetValue() {
    this.filteredOptions = undefined;
    this.inputValue = undefined;
  }
}
