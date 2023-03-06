import Component from '@glimmer/component';
import { assert } from '@ember/debug';

interface ToucanFormFieldsetComponentSignature {
  Element: HTMLFieldSetElement;
  Args: {
    error?: string;
    hasError?: boolean;
    hint?: string;
    isDisabled?: boolean;
    label: string;
  };
  Blocks: {
    default: [];
  };
}

export default class ToucanFormFieldComponent extends Component<ToucanFormFieldsetComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormFieldsetComponentSignature['Args']
  ) {
    assert('A "@label" argument is required', args.label);
    super(owner, args);
  }
}
