import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

export interface ToucanFormRadioControlComponentSignature {
  Element: HTMLInputElement;
  Args: {
    isChecked?: boolean;
    isDisabled?: boolean;
    onChange?: OnChangeCallback<string>;
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
    let { isDisabled, isChecked } = this.args;

    return isChecked && !isDisabled
      ? ['bg-primary-idle border-none']
      : isChecked && isDisabled
      ? ['bg-disabled border-none']
      : !isChecked && isDisabled
      ? ['bg-transparent border-disabled']
      : ['bg-normal-idle'];
  }

  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    this.args.onChange?.(e.target.value, e);
  }
}
