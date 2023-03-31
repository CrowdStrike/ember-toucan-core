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
  @action
  handleInput(e: Event | InputEvent): void {
    assert(
      'Expected HTMLTextAreaElement',
      e.target instanceof HTMLTextAreaElement
    );

    this.args.onChange?.(e.target?.value, e);
  }
}
