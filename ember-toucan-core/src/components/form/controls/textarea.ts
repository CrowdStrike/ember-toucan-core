import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

export interface ToucanFormTextareaControlComponentSignature {
  Element: HTMLTextAreaElement;
  Args: {
    isDisabled?: boolean;
    onChange?: OnChangeCallback<string>;
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
