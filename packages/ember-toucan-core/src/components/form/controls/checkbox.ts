import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

export interface ToucanFormCheckboxControlComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Sets the disabled attribute of the checkbox.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the checkbox.
     */
    isReadOnly?: boolean;

    /**
     * The function called when the element is clicked.
     */
    onChange?: OnChangeCallback<boolean>;

    /**
     * Sets the checked state of the checkbox.
     */
    isChecked?: boolean;

    /**
     * Sets the indeterminate state of the checkbox.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#indeterminate_state_checkboxes
     */
    isIndeterminate?: boolean;
  };
}

export default class ToucanFormCheckboxControlComponent extends Component<ToucanFormCheckboxControlComponentSignature> {
  get isChecked() {
    return this.args.isChecked ?? false;
  }

  get isIndeterminate() {
    return this.args.isIndeterminate ?? false;
  }

  /**
   * Used in our template so we don't need to pull in ember-truth-helpers (yet).
   */
  get isCheckedOrIndeterminate() {
    return this.isChecked || this.isIndeterminate;
  }

  get styles() {
    let { isDisabled, isReadOnly } = this.args;
    let isCheckedOrIndeterminate = this.isCheckedOrIndeterminate;

    // TODO: Make this logic better (this is only for testing purposes atm!)
    // Don't ship it like this 😂
    return isCheckedOrIndeterminate && !isDisabled && !isReadOnly
      ? ['bg-primary-idle border-none']
      : isCheckedOrIndeterminate && isDisabled && !isReadOnly
      ? ['bg-disabled border-none']
      : !isCheckedOrIndeterminate && isDisabled && !isReadOnly
      ? ['bg-transparent border-disabled']
      : isReadOnly && !isCheckedOrIndeterminate
      ? ['bg-surface-xl']
      : isReadOnly && isCheckedOrIndeterminate
      ? ['bg-titles-and-attributes border-none']
      : ['bg-normal-idle'];
  }

  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    this.args.onChange?.(e.target.checked, e);
  }
}
