import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

export interface ToucanFormRadioControlComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Sets the checked attribute of the radio.
     */
    isChecked?: boolean;

    /**
     * Sets the disabled attribute of the radio.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the radio.
     */
    isReadOnly?: boolean;

    /**
     * The function called when the element is clicked.
     */
    onChange?: OnChangeCallback<string>;

    /**
     * Sets the value attribute of the radio.
     */
    value: string;
  };
}

export default class ToucanFormRadioControlComponent extends Component<ToucanFormRadioControlComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormRadioControlComponentSignature['Args']
  ) {
    assert('A "@value" argument is required', args.value);
    super(owner, args);
  }

  get styles() {
    let { isDisabled, isChecked, isReadOnly } = this.args;

    // TODO: Make this logic better (this is only for testing purposes atm!)
    // Don't ship it like this 😂
    return isChecked && !isDisabled && !isReadOnly
      ? ['bg-primary-idle border-none']
      : isChecked && isDisabled && !isReadOnly
      ? ['bg-disabled border-none']
      : !isChecked && isDisabled && !isReadOnly
      ? ['bg-transparent border-disabled']
      : isReadOnly && !isChecked
      ? ['bg-surface-xl']
      : isReadOnly && isChecked
      ? ['bg-titles-and-attributes border-none']
      : ['bg-normal-idle'];
  }

  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    this.args.onChange?.(e.target.value, e);
  }
}
