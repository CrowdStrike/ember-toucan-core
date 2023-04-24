import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

interface ToucanFormControlsInputComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Sets the input to an errored-state via styling.
     */
    hasError?: boolean;

    /**
     * Sets the disabled attribute of the input.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the input.
     */
    isReadOnly?: boolean;

    /**
     * The function called when the element is typed into.
     */
    onChange?: OnChangeCallback<string>;

    /**
     * Sets the value attribute of the input.
     */
    value?: string;
  };
}

export default class ToucanFormControlsInputComponent extends Component<ToucanFormControlsInputComponentSignature> {
  get styles() {
    let { isDisabled, isReadOnly, hasError } = this.args;

    if (isDisabled) {
      return 'shadow-focusable-outline bg-overlay-1 text-disabled';
    }

    if (isReadOnly) {
      return 'focus:shadow-focus-outline bg-surface-xl shadow-read-only-outline text-titles-and-attributes';
    }

    if (hasError) {
      return 'shadow-error-outline focus:shadow-error-focus-outline bg-overlay-1 text-titles-and-attributes';
    }

    return 'shadow-focusable-outline focus:shadow-focus-outline bg-overlay-1 text-titles-and-attributes';
  }

  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    this.args.onChange?.(e.target.value, e);
  }
}
