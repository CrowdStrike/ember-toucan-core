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
    let { isDisabled } = this.args;
    let isCheckedOrIndeterminate = this.isCheckedOrIndeterminate;

    return isCheckedOrIndeterminate && !isDisabled
      ? ['bg-primary-idle border-none']
      : isCheckedOrIndeterminate && isDisabled
      ? ['bg-disabled border-none']
      : !isCheckedOrIndeterminate && isDisabled
      ? ['bg-transparent border-disabled']
      : ['bg-normal-idle'];
  }

  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    this.args.onChange?.(e.target.checked, e);
  }
}
