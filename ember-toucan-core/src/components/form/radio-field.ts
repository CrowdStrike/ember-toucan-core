import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ToucanFormRadioControlComponentSignature } from './controls/radio';

export interface ToucanFormRadioFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    error?: string;
    hint?: string;
    isChecked?: ToucanFormRadioControlComponentSignature['Args']['isChecked'];
    isDisabled?: boolean;
    label: string;
    onChange?: ToucanFormRadioControlComponentSignature['Args']['onChange'];
    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;
    value: ToucanFormRadioControlComponentSignature['Args']['value'];
  };
}

export default class ToucanFormRadioFieldComponent extends Component<ToucanFormRadioFieldComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormRadioFieldComponentSignature['Args']
  ) {
    assert('A "@label" argument is required', args.label);
    super(owner, args);
  }
}
