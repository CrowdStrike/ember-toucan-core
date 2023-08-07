import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

const VALID_VARIANTS = [
  'bare',
  'destructive',
  'link',
  'primary',
  'quiet',
  'secondary',
] as const;

export type ButtonVariant = (typeof VALID_VARIANTS)[number];

const STYLES = {
  base: [
    'focusable',
    'inline-flex',
    'items-center',
    'justify-center',
    'transition',
    'truncate',
    'type-md-medium',
  ],
  variants: {
    bare: ['focusable'],
    destructive: ['focusable-destructive', 'interactive-destructive'],
    link: ['font-normal', 'interactive-link', 'underline'],
    primary: ['interactive-primary'],
    quiet: ['font-normal', 'interactive-quiet'],
    secondary: ['interactive-normal'],
  },
  buttonGroup: {
    true: ['rounded-none', 'flex-1', 'first:rounded-l-sm', 'last:rounded-r-sm'],
    false: ['rounded-sm'],
  },
};

export interface ButtonSignature {
  Args: {
    /**
     * Sets `aria-disabled` on the button.  `aria-disabled` is used over the `disabled` attribute so that screenreaders can still focus the element.
     */
    isDisabled?: boolean;

    /**
     * Puts the button in a loading state.
     */
    isLoading?: boolean;

    /**
     * The function called when the element is clicked.
     */
    onClick?: (event: MouseEvent) => void;

    /**
     * Setting the variant of the button changes the styling.
     */
    variant?: ButtonVariant;

    /**
     * Special styling is applied if a button is inside a button group.
     *
     * @internal This is meant to only be used by `<ButtonGroup>`
     */
    isButtonGroup?: boolean;
  };
  Blocks: { default: []; disabled: []; loading: [] };
  Element: HTMLButtonElement;
}

export default class Button extends Component<ButtonSignature> {
  get variant() {
    const { variant } = this.args;

    assert(
      `Invalid variant for Button: '${variant}' (allowed values: [${VALID_VARIANTS.join(
        ', ',
      )}])`,
      VALID_VARIANTS.includes(variant ?? 'primary'),
    );

    return variant || 'primary';
  }

  get styles() {
    if (this.variant === 'bare') {
      return STYLES.variants.bare.join(' ');
    }

    const buttonStyles = [
      ...STYLES.base,
      ...STYLES.buttonGroup[this.args.isButtonGroup ? 'true' : 'false'],
      ...STYLES.variants[this.variant],
    ];
    const disabledStyles = ['interactive-disabled', 'focus:outline-none'];

    if (this.variant !== 'link') {
      buttonStyles.push('px-4', 'py-1');
    }

    return this.args.isDisabled
      ? [...buttonStyles, ...disabledStyles].join(' ')
      : buttonStyles.join(' ');
  }

  @action
  onClick(event: MouseEvent) {
    if (this.args.isDisabled) {
      event.stopImmediatePropagation();

      return;
    }

    this.args.onClick?.(event);
  }

  <template>
    <button
      aria-disabled={{if @isDisabled "true"}}
      class={{this.styles}}
      type="button"
      {{on "click" this.onClick}}
      ...attributes
    >
      {{#if @isLoading}}
        {{yield to="loading"}}
        <span class="sr-only" data-loading>{{yield}}</span>
      {{else if @isDisabled}}
        <span class="flex flex-grow items-center justify-center gap-x-2">
          {{yield}}
          {{yield to="disabled"}}
        </span>
      {{else}}
        {{yield}}
      {{/if}}
    </button>
  </template>
}
