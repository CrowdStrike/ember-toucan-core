import Component from '@glimmer/component';
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
    this.args.onChange?.((e.target as HTMLTextAreaElement)?.value, e);
  }
}
