import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

export interface ToucanFormTextareaControlComponentSignature {
  Element: HTMLTextAreaElement;
  Args: {
    isDisabled?: boolean;
    onChange?: (value: string, e: Event | InputEvent) => void;
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
