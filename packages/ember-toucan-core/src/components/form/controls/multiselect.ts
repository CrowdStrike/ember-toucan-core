import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import { next } from '@ember/runloop';
import { isEqual as emberIsEqual } from '@ember/utils';

import { offset, size } from '@floating-ui/dom';

import ChipComponent from '../../../-private/components/form/controls/multiselect/chip';
import OptionComponent, {
  selector as optionComponentSelector,
} from '../../../-private/components/form/controls/multiselect/option';
import RemoveComponent from '../../../-private/components/form/controls/multiselect/remove';
import Chevron from '../../../-private/icons/chevron';
import Cross from '../../../-private/icons/cross';

import type { Middleware as VelcroMiddleware } from '@floating-ui/dom';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormMultiselectControlComponentSignature {
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
     * Called when the user makes a selection.
     * It is called with the selected options (derived from `@options`) as its only argument.
     */
    onChange?: (options: string[]) => void;

    /**
     * The function called when a user types into the textbox, typically used to write custom filtering logic.
     */
    onFilter?: (value: string) => string[];

    /**
     * `@options` forms the content of this component.
     *
     * `@options` is simply iterated over then passed back to you as a block parameter (`multiselect.option`).
     */
    options?: string[];

    /**
     * The currently selected option.
     */
    selected?: string[];
  };
  Blocks: {
    chip: [
      {
        /**
         * The selected option index.
         */
        index: number;

        /**
         * The selected option value.
         */
        option: string;

        /**
         * The Chip component used to render an option.
         */
        Chip: WithBoundArgs<typeof ChipComponent, 'index'>;

        /**
         * The Chip component's remove button component.  It is only displayed
         * if the multiselect is not in a readonly or disabled state.
         */
        Remove: WithBoundArgs<
          typeof RemoveComponent,
          'isVisible' | 'onClick' | 'onMouseDown'
        >;
      }
    ];
    default: [
      {
        /**
         * The selected option value.
         */
        option: string;

        /**
         * The Option component rendered inside of the popover list.
         */
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
    noResults: [];
  };
  Element: HTMLInputElement;
}

export default class ToucanFormMultiselectControlComponent extends Component<ToucanFormMultiselectControlComponentSignature> {
  @tracked activeIndex: number | null = null;
  @tracked inputValue = '';
  @tracked isPopoverOpen = false;
  @tracked filteredOptions: string[] | null = null;

  Chevron = Chevron;
  Cross = Cross;
  Option = OptionComponent;
  ChipComponent = ChipComponent;
  RemoveComponent = RemoveComponent;
  popoverId = `popover--${guidFor(this)}`;

  /**
   * The component requires these blocks to properly construct the
   * multiselect.
   */
  assertRequiredBlocksExist = ({
    chipBlockExists,
    noResultsBlockExists,
  }: {
    chipBlockExists: boolean;
    noResultsBlockExists: boolean;
  }) => {
    assert('The `:chip` block is required.', chipBlockExists);
    assert('The `:noResults` block is required.', noResultsBlockExists);

    return chipBlockExists && noResultsBlockExists;
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

    this.inputValue = '';

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

    this.filteredOptions = null;
  }

  /**
   * Returns the index of a particular option from the selected array.
   * If the item is not found in the selected array, it returns -1.
   */
  getOptionIndexFromSelected(option: string) {
    return (
      this.args.selected?.findIndex((selected) => selected === option) ?? -1
    );
  }

  /**
   * Compares two arguments to determine if they are equal or not.
   */
  @action
  isEqual(one: unknown, two: unknown) {
    return emberIsEqual(one, two);
  }

  /**
   * Action used to determine if a particular option is selected or not
   * by the user.  If the option is selected, the checkbox for that option
   * will be checked.
   */
  @action
  isSelected(option: string) {
    return !this.args.selected || !option
      ? false
      : this.getOptionIndexFromSelected(option) >= 0;
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

    this.filteredOptions =
      this.args.options && this.args.onFilter
        ? this.args.onFilter(value)
        : this.args.options
        ? this.args.options.filter((option) => {
            return option.toLowerCase().startsWith(value.toLowerCase());
          })
        : [];

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
      const inputElement = document.querySelector(
        '[data-toucan-multiselect-input]'
      );

      assert(
        '`inputElement` must be an instance of `HTMLInputElement`',
        inputElement instanceof HTMLInputElement
      );

      inputElement.focus();
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
  resetInputValueAndFilteredOptions() {
    this.filteredOptions = null;
    this.inputValue = '';
  }
}
