import Component from '@glimmer/component';
import { assert } from '@ember/debug';
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
    'rounded-sm',
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
};

export interface ButtonSignature {
  Args: {
    isDisabled?: boolean;
    isLoading?: boolean;
    onClick?: (event: MouseEvent) => void;
    type?: HTMLButtonElement['type'];
    variant?: ButtonVariant;
  };
  Blocks: { default: []; disabled: []; loading: [] };
  Element: HTMLButtonElement;
}

export default class Button extends Component<ButtonSignature> {
  get type() {
    return this.args?.type || 'button';
  }

  get variant() {
    const { variant } = this.args;

    assert(
      `Invalid variant for Button: '${variant}' (allowed values: [${VALID_VARIANTS.join(
        ', '
      )}])`,
      VALID_VARIANTS.includes(variant ?? 'primary')
    );

    return variant || 'primary';
  }

  get styles() {
    if (this.variant === 'bare') {
      return STYLES.variants.bare.join(' ');
    }

    const buttonStyles = [...STYLES.base, ...STYLES.variants[this.variant]];
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
}
