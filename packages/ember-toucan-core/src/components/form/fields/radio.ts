import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ToucanFormRadioControlComponentSignature } from '../controls/radio';

export interface ToucanFormRadioFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Provide a string to this argument to render a hint message to help describe the control.
     */
    hint?: string;

    /**
     * Sets the disabled attribute on the control.
     */
    isDisabled?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label: string;

    /**
     * Sets the name attribute of the radio. A string specifying a name for the input control. This name is submitted along with the control's value when the form data is submitted.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#name
     */
    name: string;

    /**
     * The function called when the element is clicked.
     */
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

    /**
     * Sets the value attribute of the radio.
     */
    value: ToucanFormRadioControlComponentSignature['Args']['value'];
  };
  Blocks: {
    label: unknown;
    hint: unknown;
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
