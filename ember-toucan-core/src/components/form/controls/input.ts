import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

interface ToucanFormControlInputComponentSignature {
  Element: HTMLInputElement;
  Args: {
    isDisabled?: boolean;
    onChange?: (value: string, e: Event | InputEvent) => void;
    readonly?: boolean;
    value?: string;
  };
}

export default class ToucanFormControlInputComponent extends Component<ToucanFormControlInputComponentSignature> {
  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    if (this.args.onChange) {
      this.args.onChange(e.target.value, e);
    }
  }
}
