import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

interface ToucanFormControlsInputComponentSignature {
  Element: HTMLInputElement;
  Args: {
    hasError?: boolean;
    isDisabled?: boolean;
    onChange?: OnChangeCallback<string>;
    value?: string;
  };
}

export default class ToucanFormControlsInputComponent extends Component<ToucanFormControlsInputComponentSignature> {
  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    this.args.onChange?.(e.target.value, e);
  }
}
