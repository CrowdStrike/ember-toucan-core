import Component from '@glimmer/component';
import { assert } from '@ember/debug';

interface ToucanFormInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    label: string;
    hint?: string;
    error?: string;
    isDisabled?: boolean;
    readonly?: boolean;
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
}
