import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { fn, hash } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import { next } from '@ember/runloop';
import { isEqual as emberIsEqual } from '@ember/utils';

import { offset, size } from '@floating-ui/dom';
import { Velcro } from 'ember-velcro';

import OptionComponent, {
  selector as optionComponentSelector,
} from '../../../-private/components/form/controls/autocomplete/option';
import Chevron from '../../../-private/icons/chevron';

import type { Middleware as VelcroMiddleware } from '@floating-ui/dom';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormAutocompleteControlComponentSignature {
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
     * A string to display when there are no results after filtering.
     */
    noResultsText: string;

    /**
     * Called when the user makes a selection.
     * It is called with the selected option (derived from `@options`) as its only argument.
     */
    onChange?: (selected: string | null) => void;

    /**
     * The function called when a user types into the textbox, typically used to write custom filtering logic.
     *
     * @return An array of options to be shown in the popover.
     */
    onFilter?: (value: string) => string[];

    /**
     * `@options` forms the content of this component.
     *
     * `@options` is simply iterated over then passed back to you as a block parameter (`select.option`).
     */
    options?: string[];

    /**
     * The currently selected option.
     */
    selected?: string | null;
  };
  Blocks: {
    default: [
      {
        option: string;
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
      },
    ];
  };
  Element: HTMLInputElement;
}

export default class ToucanFormAutocompleteControlComponent extends Component<ToucanFormAutocompleteControlComponentSignature> {
  @tracked activeIndex: number | null = null;
  @tracked inputValue = '';
  @tracked isPopoverOpen = false;
  @tracked filteredOptions: string[] | null = null;

  Chevron = Chevron;
  Option = OptionComponent;
  popoverId = `popover--${guidFor(this)}`;

  constructor(
    owner: unknown,
    args: ToucanFormAutocompleteControlComponentSignature['Args'],
  ) {
    super(owner, args);

    // We need to set our input tag's value attribute
    // if we have a selected option provided on render
    this.inputValue = this.args.selected ?? '';
  }

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
   * We apply different styles to the input tag based on our current state.
   */
  get styles() {
    if (this.args.isDisabled) {
      return 'shadow-focusable-outline bg-overlay-1 text-disabled pointer-events-none placeholder:text-disabled';
    }

    if (this.args.isReadOnly) {
      return 'focus:shadow-focus-outline bg-surface-xl shadow-read-only-outline text-titles-and-attributes placeholder:text-titles-and-attributes';
    }

    if (this.args.hasError) {
      return 'shadow-error-outline focus:shadow-error-focus-outline bg-overlay-1 text-titles-and-attributes';
    }

    return 'shadow-focusable-outline focus:shadow-focus-outline bg-overlay-1 text-titles-and-attributes';
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
      `#${this.popoverId} ${optionComponentSelector}`,
    );
    const optionElement = optionsElements[this.activeIndex];

    if (!optionElement) {
      return;
    }

    optionElement.scrollIntoView(alignToTop);
  }

  @action
  closePopover() {
    this.isPopoverOpen = false;
  }

  @action
  noop() {
    // eslint-disable @typescript-eslint/no-empty-function
  }

  /**
   * Action called when a new item is selected. Ultimately calls the provided `@onChange` with the newly selected item.
   */
  @action
  onChange() {
    assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);

    assert(
      '`this.args.options` cannot be  `undefined`',
      this.args.options !== undefined,
    );

    this.closePopover();

    assert(
      '`this.options` was unexpectedly empty in an on change handler. If you see this, please report it as a bug to ember-toucan-core!',
      this.options,
    );

    // This shouldn't be possible, but to satisfy TS
    if (this.activeIndex === null) {
      this.args.onChange?.(null);

      return;
    }

    let selectedOption = this.options[this.activeIndex];

    if (typeof selectedOption === 'string') {
      this.inputValue = selectedOption;
    }

    this.args.onChange?.(this.options[this.activeIndex] ?? null);
    this.filteredOptions = null;
  }

  @action
  isEqual(one: unknown, two: unknown) {
    return emberIsEqual(one, two);
  }

  /**
   * Handle keyboard events to operate like a combobox as defined at https://www.w3.org/WAI/ARIA/apg/patterns/combobox.
   */
  @action
  onKeydown(event: KeyboardEvent) {
    if (event.key === 'Tab') {
      return;
    }

    if (!this.isPopoverOpen) {
      // Prevents ArrowUp, ArrowDown, PageUp, PageDown, Home, and End from scrolling the page.
      event.preventDefault();

      this.openPopover();

      return;
    }

    if (!this.isPopoverOpen && event.key === 'Escape') {
      this.openPopover();

      return;
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
        '`this.args.options` cannot be `undefined`',
        this.args.options !== undefined,
      );

      // By default, arrowing up and down moves the insertion point to the beginning or end
      // of an input field. We don't want this. We want to reserve arrowing for moving
      // vertically through the list.
      event.preventDefault();

      this.activeIndex = this.args.options.length - 1;
      this.scrollActiveOptionIntoView(false);

      return;
    }

    if (event.key === 'ArrowDown') {
      assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);

      assert(
        '`this.args.options` cannot be  `undefined`',
        this.args.options !== undefined,
      );

      event.preventDefault();

      this.activeIndex =
        this.activeIndex === this.args.options.length - 1
          ? this.activeIndex
          : this.activeIndex + 1;

      this.scrollActiveOptionIntoView(false);

      return;
    }

    if (
      (event.key === 'ArrowUp' && event.metaKey) ||
      event.key === 'PageUp' ||
      event.key === 'Home'
    ) {
      event.preventDefault();

      this.activeIndex = 0;
      this.scrollActiveOptionIntoView();

      return;
    }

    if (event.key === 'ArrowUp') {
      assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);
      event.preventDefault();

      this.activeIndex =
        this.activeIndex === 0 ? this.activeIndex : this.activeIndex - 1;

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
      event.target instanceof HTMLInputElement,
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
          : null;

    if (this.filteredOptions !== null && this.filteredOptions.length > 0) {
      this.activeIndex = 0;
    }
  }

  @action
  onOptionMouseover(index: number) {
    this.activeIndex = index;
  }

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
   * Action that resets the input on blur to the selected option, if one was chosen (otherwise null).
   *
   * The use cases for this is two-fold:
   *
   * 1) The autocomplete value is optional. The user selected an option
   *    but then realized they no longer want that selected option.
   *    Since it is not required, we allow them to clear the input
   *    and call the provided `@onChange` with `null` to signal
   *    that the selection was cleared
   * 2) The autocomplete's `@selected` item is valid, but then a user
   *    enters garbage into the input and then tabs out of the
   *    element.  In that case, we don't want to store their
   *    garbage entry.  Instead, we reset it back to the selected
   *    option.
   */
  @action
  resetEverything(event: Event) {
    assert(
      'Expected HTMLInputElement',
      event.target instanceof HTMLInputElement,
    );

    if (!this.args.selected) {
      return;
    }

    // Reset our filtered options as we are going to "clear" the input
    this.filteredOptions = null;

    if (event.target.value === '') {
      this.inputValue = '';
      this.args.onChange?.(null);

      return;
    }

    if (event.target.value !== this.args.selected) {
      this.inputValue = this.args.selected;

      return;
    }
  }

  /**
   * Highlights the entered value of the input when the input is clicked.
   */
  @action
  highlightInputValue(event: Event) {
    assert(
      'Expected HTMLInputElement',
      event.target instanceof HTMLInputElement,
    );

    if (!this.args?.selected) {
      return;
    }

    event.target.select();
  }

  <template>
    <Velcro
      @middleware={{this.velcroMiddleware}}
      @placement="bottom-start"
      as |velcro|
    >
      <div data-autocomplete>
        <div class="relative flex w-full items-center">
          {{! template-lint-disable no-redundant-role }}
          <input
            aria-activedescendant={{this.activeDescendant}}
            aria-autocomplete="list"
            aria-controls={{this.popoverId}}
            aria-expanded={{this.isPopoverOpen}}
            aria-haspopup="listbox"
            autocapitalize="none"
            autocomplete="off"
            autocorrect="off"
            class="focus:outline-none w-full rounded-sm border-none py-1 pl-2 pr-6 transition-shadow
              {{this.styles}}"
            disabled={{@isDisabled}}
            readonly={{@isReadOnly}}
            role="combobox"
            spellcheck="false"
            type="text"
            value={{this.inputValue}}
            {{on
              "blur"
              (if
                this.isDisabledOrReadOnlyOrWithoutOptions
                this.noop
                this.closePopover
              )
            }}
            {{on
              "blur"
              (if
                this.isDisabledOrReadOnlyOrWithoutOptions
                this.noop
                this.resetEverything
              )
            }}
            {{on
              "click"
              (if
                this.isDisabledOrReadOnlyOrWithoutOptions
                this.noop
                this.openPopover
              )
            }}
            {{on
              "click"
              (if
                this.isDisabledOrReadOnlyOrWithoutOptions
                this.noop
                this.highlightInputValue
              )
            }}
            {{on
              "focus"
              (if
                this.isDisabledOrReadOnlyOrWithoutOptions
                this.noop
                this.openPopover
              )
            }}
            {{on
              "keydown"
              (if
                this.isDisabledOrReadOnlyOrWithoutOptions
                this.noop
                this.onKeydown
              )
            }}
            {{on
              "input"
              (if
                this.isDisabledOrReadOnlyOrWithoutOptions this.noop this.onInput
              )
            }}
            {{velcro.hook}}
            ...attributes
          />

          <this.Chevron
            class="text-text-and-icons pointer-events-none absolute right-1 top-0 ml-auto h-full transform transition-transform duration-200
              {{if this.isPopoverOpen 'rotate-180'}}"
          />
        </div>

        {{#if this.isPopoverOpen}}
          <ul
            class="border-surface-inner bg-surface-2xl max-h-listbox my-0 list-none overflow-y-auto overscroll-contain rounded-sm border py-1 pl-0 shadow-xl
              {{if @contentClass @contentClass}}"
            id={{this.popoverId}}
            role="listbox"
            {{velcro.loop}}
          >
            {{#if this.options}}
              {{#each this.options as |option index|}}
                {{yield
                  (hash
                    Option=(component
                      this.Option
                      isActive=(this.isEqual index this.activeIndex)
                      isDisabled=@isDisabled
                      isSelected=(this.isEqual @selected option)
                      isReadOnly=@isReadOnly
                      onClick=(fn this.onChange index)
                      onMouseover=(fn this.onOptionMouseover index)
                      popoverId=this.popoverId
                      index=index
                    )
                    option=option
                  )
                }}
              {{/each}}
            {{else}}
              <li
                aria-live="assertive"
                class="text-titles-and-attributes my-0 flex cursor-default items-center px-3 py-2 leading-4"
                role="status"
              >{{@noResultsText}}</li>
            {{/if}}
          </ul>
        {{/if}}
      </div>
    </Velcro>
  </template>
}
