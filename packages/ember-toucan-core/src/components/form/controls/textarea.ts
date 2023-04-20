import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

export interface ToucanFormTextareaControlComponentSignature {
  Element: HTMLTextAreaElement;
  Args: {
    /**
     * Sets the textarea to an errored-state via styling.
     */
    hasError?: boolean;

    /**
     * Sets the disabled attribute of the textarea.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the textarea.
     */
    isReadOnly?: boolean;

    /**
     * The function called when the element is typed into.
     */
    onChange?: OnChangeCallback<string>;

    /**
     * Sets the value attribute of the textarea.
     */
    value?: string;
  };
}

export default class ToucanFormTextareaControlComponent extends Component<ToucanFormTextareaControlComponentSignature> {
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
    assert(
      'Expected HTMLTextAreaElement',
      e.target instanceof HTMLTextAreaElement
    );

    this.args.onChange?.(e.target?.value, e);
  }
}
