import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

interface ToucanFormInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    error?: string;
    label: string;
    hint?: string;
    isDisabled?: boolean;
    onChange?: (value: string, e: Event | InputEvent) => void;
    readonly?: boolean;
    value?: string;
  };
  Blocks: {
    default: [];
  };
}

export default class ToucanFormInputFieldComponent extends Component<ToucanFormInputFieldComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormInputFieldComponentSignature['Args']
  ) {
    assert('input field requires a label', args.label !== undefined);
    super(owner, args);
  }

  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    if (this.args.onChange) {
      this.args.onChange(e.target.value, e);
    }
  }
}
