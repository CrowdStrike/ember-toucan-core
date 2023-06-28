import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { action } from '@ember/object';
import { guidFor } from '@ember/object/internals';
import { next } from '@ember/runloop';

import { offset, size } from '@floating-ui/dom';

import Option, {
  selector as optionSelector,
} from '../../../-private/components/form/controls/select/option';
import Chevron from '../../../-private/icons/chevron';

import type { Middleware as VelcroMiddleware } from '@floating-ui/dom';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormSelectControlComponentSignature {
  Args: {
    /**
     * Sets the input to an errored-state via styling.
     */
    hasError?: boolean;

    /**
     * Sets the values to be selected on render.
     */
    initialSelectedValues?: string[];

    /**
     * Sets the `disabled` attribute of the input.
     */
    isDisabled?: boolean;

    /**
     * Sets the `readonly` attribute of the input.
     */
    isReadOnly?: boolean;

    /**
     * Set to allow multiple option to be selected at once.
     */
    isMultiple?: boolean;

    // PR: callback type doesn't fit here as well as elsewhere. different events here. they don't make as much sense to pass along to the consumer. ditch callback type altogether?
    /**
     * The function called when a new selection is made.
     */
    onChange?: (values: string[]) => void;

    /**
     * A CSS class to add to the popover.
     * Commonly used to specify a `z-index`.
     */
    popoverClass?: string;
  };
  Blocks: {
    default: [
      {
        Option: WithBoundArgs<
          typeof Option,
          'activeOption' | 'onMouseover' | 'onClick' | 'selectedOptions'
        >;
      }
    ];
  };
  Element: HTMLInputElement;
}

type SelectedOption = {
  label: string;
  value: string;
};

// TODO
//
// The foundational work is done. And adding supporting for `@isMultiple` should (😬) be straightforward.
// There's still a decent amount of work left. Off the top of my head:
//
// - need final decisions from Mary on how filtering behaves with the single-select
// - need final visual design
// - tests
// - the popover's scrollbar track and thumb are at their defaults. Tailwind doesn't support scrollbar styling. do we need to add a stylesheet?
// - test with a screenreader
// - add loading feedback?
// - support for loading feedback?
// - probably a bunch of little things and a few bugs
// - `this.args.popoverClass` continues to bum me out 🤷‍♂️

// SOMETHING TO CONSIDER?
//
// This component's API is different from the other components in that consumers only set its
// initial value (via `this.args.initialSelectedValues`). We set `this.selectedOptions` based off of `this.args.initialSelectedValues`
// and from then on maintain the state of `this.selectedOptions` ourselves. We do this because we need to know when selections change
// so that we can go digging through the DOM to put together an updated array of labels and values that make up `this.selectedOptions`.
//
// This is a consequence of our API design, where we don't support an `this.args.options` array and instead let the consumer
// provide options freely in the template. If we supported `this.args.options` instead, we'd have no need to go digging through the
// DOM for labels and values and thus could let the consumer maintain what is selected and what isn't.
//
// There's also the changeset concern you brought up. Are changesets akin to controlled components in React? If so, I wonder if how
// we've implemented this component won't be incompatbile with changesets in spirit, if not practically. Managing selection state
// internally means consuming components won't control it.

export default class ToucanFormSelectControlComponent extends Component<ToucanFormSelectControlComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormSelectControlComponentSignature['Args']
  ) {
    super(owner, args);

    if (this.args.initialSelectedValues !== undefined) {
      assert(
        '`this.args.initialSelectedValues.length` can contain at most one value when `this.args.isMultiple` is falsy',
        !(!this.args.isMultiple && this.args.initialSelectedValues.length > 1)
      );
    }

    // PR: These functions can't be called until after first render because they query the DOM.
    // Is there a better runloop callback to use? Haaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaalp.
    next(() => {
      // PR: Because they assert, these functions will throw if the consumer doesn't render options in the `{{yield}}`.
      // What's the Ember way to ensure options are passed?
      this.activeOption = this.#getActiveOption('[first]');

      if (
        this.args.initialSelectedValues !== undefined &&
        this.args.initialSelectedValues.length > 0
      ) {
        this.selectedOptions = this.#getSelectedOptions(
          this.args.initialSelectedValues
        );
      }
    });
  }

  /**
   * An active option is one that the user has soft-interacted with either by arrowing to it or hovering over it.
   * `null` before render and after `null` render if the consumer doesn't pass options in the template.
   **/
  @tracked activeOption: {
    index: number;
    label: string;
    value: string;
  } | null = null;

  @tracked isPopoverOpen = false;

  /**
   * Selected options are options that the user has hard-interacted with by either pressing Enter on them or by clicking them.
   * There's an assertion in the constructor to ensure that at most on selected option is allowed when `this.args.isMultiple`
   * is falsy.
   **/
  @tracked selectedOptions: SelectedOption[] = [];

  Chevron = Chevron;
  Option = Option;
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

  get isDisabledOrReadOnly() {
    return this.args.isDisabled || this.args.isReadOnly;
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

  /**
   * @value A preset position that is a string literal or an option value that is a string.
   * The former exists for the keyboard case (ArrowDown, etc.), where the previous or next
   * active value isn't known by the input handler.
   */
  #getActiveOption(
    value: '[first]' | '[previous]' | '[next]' | '[last]' | string
  ) {
    assert(
      "`value` cannot be `'[previous]'` if `this.activeOption` is `null`",
      !(this.activeOption === null && value === '[previous]')
    );

    assert(
      "`value` cannot be `'[next]'` if `this.activeOption` is `null`",
      !(this.activeOption === null && value === '[next]')
    );

    const optionElements = document.querySelectorAll(
      `#${this.popoverId} ${optionSelector}`
    );

    if (optionElements.length === 0) {
      return null;
    }

    let newActiveIndex: number;

    if (value === '[first]') {
      newActiveIndex = 0;
    } else if (value === '[last]') {
      newActiveIndex = optionElements.length - 1;
    } else if (value === '[previous]' || value === '[next]') {
      const currentActiveIndex = Array.from(optionElements).findIndex(
        (option) => {
          assert(
            '`option` must be an instance of `HTMLElement`',
            option instanceof HTMLElement
          );

          return option.dataset['value'] === this.activeOption?.value;
        }
      );

      newActiveIndex =
        value === '[previous]' && currentActiveIndex === 0
          ? currentActiveIndex
          : value === '[previous]'
          ? currentActiveIndex - 1
          : value === '[next]' &&
            currentActiveIndex === optionElements.length - 1
          ? currentActiveIndex
          : currentActiveIndex + 1;
    } else {
      newActiveIndex = Array.from(optionElements).findIndex((option) => {
        assert(
          '`option` must be an instance of `HTMLElement`',
          option instanceof HTMLElement
        );

        return option.dataset['value'] === value;
      });
    }

    const newActiveElement = optionElements[newActiveIndex];

    assert(
      '`newActiveElement` must be an instance of `HTMLElement`',
      newActiveElement instanceof HTMLElement
    );

    const newActiveValue = newActiveElement.dataset['value'];

    assert(
      '`newActiveValue` must be a `string`',
      typeof newActiveValue === 'string'
    );

    return {
      index: newActiveIndex,
      label: newActiveValue,
      value: newActiveValue,
    };
  }

  /**
   * @values Option values to add or remove depending on whether they're present in `this.selectedOptions`.
   * Having `values` work this way adds complexity here but simplifies things for the internal consumer.
   * Internal consumers, such as `this.onOptionClick`, don't need to figure out if they `value` they're dealing
   * with should be selected or deselected.
   *
   * @todo The current behavior is deselect an already selected option when it's selected. I suggested this
   * behavior to the team but we've yet to make a decision (go figure). You might want to get a final decision
   * from Mary before opening a PR.
   **/
  #getSelectedOptions(values: string[]): SelectedOption[] {
    const allOptionsElements = document.querySelectorAll(
      `#${this.popoverId} ${optionSelector}`
    );

    // When `this.args.isMultiple` is `true`, we want to keep every option in `this.selectedOptions` except
    // those whose `value` is found in `values`. Those we want to remove because they represent deselections.
    // When `this.args.isMultiple` is falsy, we want to discard every selected option be selected at a time.
    const selectedOptions = this.args.isMultiple
      ? this.selectedOptions.filter((option) =>
          values.every((value) => value !== option.value)
        )
      : [];

    const filteredValues = values.filter((value) => {
      return this.selectedOptions.every((option) => option.value !== value);
    });

    for (const value of filteredValues) {
      const element = Array.from(allOptionsElements).find((element) => {
        assert(
          '`element` must be an instance of `HTMLElement`',
          element instanceof HTMLElement
        );

        return element.dataset['value'] === value;
      });

      assert(
        '`element` must be an instance of `HTMLElement`',
        element instanceof HTMLElement
      );

      const label = element.dataset['label'];

      assert('`label` must be a `string`', typeof label === 'string');

      selectedOptions.push({
        label,
        value,
      });
    }

    return selectedOptions;
  }

  #scrollActiveOptionIntoView(alignToTop?: boolean) {
    assert('`activeOption` cannot be `null`', this.activeOption !== null);

    const optionsElements = document.querySelectorAll(
      `#${this.popoverId} ${optionSelector}`
    );
    const optionElement = optionsElements[this.activeOption.index];

    assert(
      '`optionElement` an instance of `HTMLElement`',
      optionElement instanceof HTMLElement
    );

    optionElement.scrollIntoView(alignToTop);
  }

  @action
  closePopover() {
    this.isPopoverOpen = false;
  }

  @action
  onInput(event: Event) {
    assert(
      '`event.target` an instance of `HTMLInputElement`',
      event.target instanceof HTMLInputElement
    );

    const options = document.querySelectorAll(
      `#${this.popoverId} ${optionSelector}`
    );

    let firstFilteredValue: string | null = null;
    let isCurrentActiveOptionFilteredOut = true;

    // We go through all the options that we've queried the DOM for. Then we show those
    // that meet our simple filtering criterion and hide those that don't.
    for (const option of options) {
      assert(
        '`option` must be an instance of `HTMLElement`',
        option instanceof HTMLElement
      );

      assert(
        "`option.dataset['value']` must be a `string`",
        typeof option.dataset['value'] === 'string'
      );

      const isShow =
        event.target.value === '' ||
        option.dataset['value']
          .toLowerCase()
          .startsWith(event.target.value.toLowerCase().trim());

      // It doesn't feel great doing stuff this imperative, especially on subcomponents, whose
      // styling and implementation details should unknowable and untouched by the parent component.
      // But I can't think of a better way.
      option.style.display = isShow ? '' : 'none';

      if (isShow) {
        firstFilteredValue = option.dataset['value'];
      }

      if (isShow && option.dataset['value'] === this.activeOption?.value) {
        isCurrentActiveOptionFilteredOut = false;
      }
    }

    if (isCurrentActiveOptionFilteredOut && firstFilteredValue !== null) {
      this.activeOption = this.#getActiveOption(firstFilteredValue);
    }
  }

  @action
  noop() {
    // eslint-disable @typescript-eslint/no-empty-function
    // PR: This rather than mess around with Glint and `ember-composable-functions`. Is there a better way?
  }

  @action
  onChange(value: string) {
    this.selectedOptions = this.#getSelectedOptions([value]);
    this.closePopover();

    const selectedValues = this.selectedOptions.map(({ value }) => value);

    this.args.onChange?.(selectedValues);
  }

  @action
  onKeydown(event: KeyboardEvent) {
    if (event.key === 'Escape') {
      this.closePopover();

      return;
    }

    if (!this.isPopoverOpen) {
      this.openPopover();

      return;
    }

    if (event.key === 'Enter' && this.activeOption !== null) {
      this.onChange(this.activeOption.value);

      return;
    }

    if (
      (event.key === 'ArrowDown' && event.metaKey) ||
      event.key === 'PageDown' ||
      event.key === 'End'
    ) {
      // By default, arrowing up and down moves the insertion point to the beginning or end
      // of an input field. We don't want this. We want to reserve arrowing for moving
      // vertically through the list.
      event.preventDefault();
      this.activeOption = this.#getActiveOption('[last]');
      this.#scrollActiveOptionIntoView(false);

      return;
    }

    if (event.key === 'ArrowDown') {
      event.preventDefault();
      this.activeOption = this.#getActiveOption('[next]');
      this.#scrollActiveOptionIntoView(false);

      return;
    }

    if (
      (event.key === 'ArrowUp' && event.metaKey) ||
      event.key === 'PageUp' ||
      event.key === 'Home'
    ) {
      event.preventDefault();
      this.activeOption = this.#getActiveOption('[first]');
      this.#scrollActiveOptionIntoView();

      return;
    }

    if (event.key === 'ArrowUp') {
      event.preventDefault();
      this.activeOption = this.#getActiveOption('[previous]');
      this.#scrollActiveOptionIntoView();

      return;
    }
  }

  @action
  onOptionMouseover(value: string) {
    this.activeOption = this.#getActiveOption(value);
  }

  @action
  openPopover() {
    this.isPopoverOpen = true;
  }
}
