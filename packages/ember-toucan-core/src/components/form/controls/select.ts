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
} from '../../../-private/components/form/controls/select/option';
import Chevron from '../../../-private/icons/chevron';

import type { Middleware as VelcroMiddleware } from '@floating-ui/dom';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormSelectControlComponentSignature {
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

    // PR: callback type doesn't fit here as well as elsewhere. different events here. they don't make as much sense to pass along to the consumer. ditch callback type altogether?
    /**
     * Called when the user makes a selection.
     * It is called with the selected option (derived from `@options`) as its only argument.
     */
    onChange?: (option: unknown) => void;

    /**
     * `@options` forms the content of this component.
     *
     * To support a variety of data shapes, `@options` is typed as `unknown[]` and treated as though it were opaque.
     * `@options` is simply iterated over then passed back to you as a block parameter (`select.option`).
     */
    options?: unknown[];

    optionKey?: string;

    /**
     * Sets the placeholder value.
     */
    placeholder?: string;

    /**
     * The currently selected option.  If `@options` is an array of strings, provide a string.  If `@options` is an array of objects, pass the entire object.
     */
    selected?: string | Record<string, unknown> | undefined;

    /**
     * Sets what is shown in the input field.
     */
    selectedLabel?: string;

    onFilter?: (input: string) => Promise<unknown[]>;
  };
  Blocks: {
    default: [
      {
        option: unknown;
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
  };
  Element: HTMLInputElement;
}

// TODO
//
// Off the top of my head:
//
// - tests
// - the popover's scrollbar track and thumb are at their defaults. Tailwind doesn't support scrollbar styling. do we need to add a stylesheet?
// - test with a screenreader
// - add loading feedback? or wait until v2?
// - inline TODOs throughout this component, its subcomponents, and its documentation
// - bugs and minor visual tweaks?
// - SelectField

export default class ToucanFormSelectControlComponent extends Component<ToucanFormSelectControlComponentSignature> {
  @tracked activeIndex: number | null = null;
  @tracked isPopoverOpen = false;
  @tracked filteredOptions: unknown[] | undefined;

  Chevron = Chevron;
  Option = OptionComponent;
  popoverId = `popover--${guidFor(this)}`;

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

  get activeDescendant() {
    // For the case where nothing is selected on render
    if (this.activeIndex === null) {
      return null;
    }

    return `${this.popoverId}-${this.activeIndex}`;
  }

  get isDisabledOrReadOnlyOrWithoutOptions() {
    return (
      this.args.isDisabled ||
      this.args.isReadOnly ||
      this.args.options === undefined
    );
  }

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

  get options() {
    return this.filteredOptions || this.args?.options;
  }

  get selected(): string | undefined {
    let { optionKey, selected } = this.args;

    if (!selected) {
      return undefined;
    }

    return (
      typeof selected === 'object' && optionKey ? selected[optionKey] : selected
    ) as string;
  }

  #scrollActiveOptionIntoView(alignToTop?: boolean) {
    assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);

    const optionsElements = document.querySelectorAll(
      `#${this.popoverId} ${optionComponentSelector}`
    );
    const optionElement = optionsElements[this.activeIndex];

    assert(
      '`optionElement` an instance of `HTMLElement`',
      optionElement instanceof HTMLElement
    );

    optionElement?.scrollIntoView(alignToTop);
  }

  @action
  closePopover() {
    this.isPopoverOpen = false;
  }

  @action
  noop() {
    // eslint-disable @typescript-eslint/no-empty-function
    // PR: This rather than mess around with Glint and `ember-composable-functions`. Is there a better way?
  }

  @action
  onChange() {
    assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);

    assert(
      '`this.args.options` cannot be  `undefined`',
      this.args.options !== undefined
    );

    this.closePopover();

    // The null case here _shouldn't_ be possible, only satisfying TypeScript.
    this.args.onChange?.(this.options ? this.options[this.activeIndex] : null);
  }

  @action
  isEqual(one: unknown, two: unknown) {
    return emberIsEqual(one, two);
  }

  @action
  onKeydown(event: KeyboardEvent) {
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
      // Prevents space from paging down.
      event.preventDefault();

      this.onChange();

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
      this.#scrollActiveOptionIntoView(false);

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

      this.#scrollActiveOptionIntoView(false);

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
      this.#scrollActiveOptionIntoView();

      return;
    }

    if (event.key === 'ArrowUp') {
      assert('`this.activeIndex` cannot be `null`', this.activeIndex !== null);
      event.preventDefault();

      const activeIndex =
        this.activeIndex === 0 ? this.activeIndex : this.activeIndex - 1;

      this.activeIndex = activeIndex;
      this.#scrollActiveOptionIntoView();

      return;
    }
  }

  @action
  async onInput(event: Event | InputEvent) {
    assert(
      'Expected HTMLInputElement',
      event.target instanceof HTMLInputElement
    );

    const { options, optionKey, onFilter } = this.args;

    const optionsArgument = options ? [...options] : [];
    const value = event.target.value;

    let filteredOptions: unknown[] = [];

    if (!onFilter && !optionKey) {
      filteredOptions = (optionsArgument as string[])?.filter(
        (option: string) => option.toLowerCase().startsWith(value.toLowerCase())
      );
    }

    if (!onFilter && optionKey) {
      filteredOptions = optionsArgument?.filter((option) =>
        ((option as Record<string, unknown>)[optionKey] as string)
          ?.toLowerCase()
          ?.startsWith(value.toLowerCase())
      );
    }

    if (onFilter) {
      filteredOptions = await onFilter(value);
    }

    this.filteredOptions = filteredOptions;

    if (this.filteredOptions?.length > 0) {
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

    if (this.activeIndex == null) {
      this.activeIndex = 0;
    } else {
      // Wait until the options have been rendered.
      next(() => {
        this.#scrollActiveOptionIntoView(false);
      });
    }
  }
}
