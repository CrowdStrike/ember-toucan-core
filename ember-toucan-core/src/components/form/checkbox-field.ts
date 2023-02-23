import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ToucanFormCheckboxControlComponentSignature } from './controls/checkbox';

export interface ToucanFormCheckboxFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    error?: string;
    hint?: string;
    isDisabled?: boolean;
    isIndeterminate?: ToucanFormCheckboxControlComponentSignature['Args']['isIndeterminate'];
    label: string;
    onChange?: ToucanFormCheckboxControlComponentSignature['Args']['onChange'];
    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;
    value?: ToucanFormCheckboxControlComponentSignature['Args']['value'];
  };
}

export default class ToucanFormCheckboxFieldComponent extends Component<ToucanFormCheckboxFieldComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormCheckboxFieldComponentSignature['Args']
  ) {
    assert('A "@label" argument is required', args.label);
    super(owner, args);
  }
}
