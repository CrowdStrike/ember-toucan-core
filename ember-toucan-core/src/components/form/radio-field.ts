import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ToucanFormRadioControlComponentSignature } from './controls/radio';

export interface ToucanFormRadioFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    hint?: string;
    isDisabled?: boolean;
    label: string;
    name: string;
    onChange?: ToucanFormRadioControlComponentSignature['Args']['onChange'];
    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;
    /**
     * This component argument is used to determine if the underlying radio is checked.
     * When `selectedValue` and `value` are equal, the radio will have the checked attribute applied.
     */
    selectedValue?: string;
    value: ToucanFormRadioControlComponentSignature['Args']['value'];
  };
}

export default class ToucanFormRadioFieldComponent extends Component<ToucanFormRadioFieldComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormRadioFieldComponentSignature['Args']
  ) {
    assert('A "@label" argument is required', args.label);
    assert('A "@name" argument is required', args.name);
    super(owner, args);
  }

  get isChecked() {
    return this.args?.selectedValue === this.args.value;
  }
}
