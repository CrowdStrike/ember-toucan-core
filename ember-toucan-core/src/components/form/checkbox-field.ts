import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ToucanFormCheckboxControlComponentSignature } from './controls/checkbox';

export interface ToucanFormCheckboxFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Provide a string to this argument to render an error message and apply error styling to the Field.
     */
    error?: string;

    /**
     * Provide a string to this argument to render a hint message to help describe the control.
     */
    hint?: string;

    /**
     * Sets the disabled attribute on the control.
     */
    isDisabled?: boolean;

    /**
     * Sets the indeterminate state of the checkbox.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#indeterminate_state_checkboxes
     */
    isIndeterminate?: ToucanFormCheckboxControlComponentSignature['Args']['isIndeterminate'];

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label: string;

    /**
     * Sets the name attribute of the checkbox. A string specifying a name for the input control. This name is submitted along with the control's value when the form data is submitted.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#name
     */
    name?: string;

    /**
     * The function called when the element is clicked.
     */
    onChange?: ToucanFormCheckboxControlComponentSignature['Args']['onChange'];

    /**
     * The option argument gets mapped to the underlying value attribute of the checkbox. This should only be used
     * for checkbox groups via CheckboxGroupField.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#handling_multiple_checkboxes
     */
    option?: string;

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * This component argument is used to determine if the underlying checkbox is checked.
     * When the `selectedValues` array contains the `option`, the checkbox will be checked.
     * This should only be used for checkbox groups via CheckboxGroupField.
     *
     * @internal
     */
    selectedValues?: Array<string>;

    /**
     * Sets the checked state of the checkbox.
     */
    value?: ToucanFormCheckboxControlComponentSignature['Args']['value'];
  };
}

export default class ToucanFormCheckboxFieldComponent extends Component<ToucanFormCheckboxFieldComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormCheckboxFieldComponentSignature['Args']
  ) {
    assert('A "@label" argument is required', args.label);

    assert(
      'Both "@option" and "@value" arguments were supplied. "@option" is reserved for being used in a CheckboxGroupField to specify the value attribute, while "@value" sets the checked state of the checkbox. Please use either "@option" or "@value", but not both.',
      !(args.value && args.option)
    );

    super(owner, args);
  }

  get isChecked() {
    if (!this.args?.option) {
      return this.args.value;
    }

    if (!this.args.selectedValues || this.args.selectedValues.length === 0) {
      return false;
    }

    return this.args.selectedValues?.includes(this.args.option);
  }
}
