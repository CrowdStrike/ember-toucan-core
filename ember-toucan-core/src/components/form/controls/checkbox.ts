import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

export interface ToucanFormCheckboxControlComponentSignature {
  Element: HTMLInputElement;
  Args: {
    isDisabled?: boolean;
    onChange?: OnChangeCallback<boolean>;
    isIndeterminate?: boolean;
    value?: boolean;
  };
}

export default class ToucanFormCheckboxControlComponent extends Component<ToucanFormCheckboxControlComponentSignature> {
  get isChecked() {
    return this.args.value ?? false;
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
