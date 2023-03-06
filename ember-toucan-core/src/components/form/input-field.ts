import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { OnChangeCallback } from '../../-private/types';

interface ToucanFormInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    error?: string;
    label: string;
    hint?: string;
    isDisabled?: boolean;
    onChange?: OnChangeCallback<string>;
    rootTestSelector?: string;
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
}
