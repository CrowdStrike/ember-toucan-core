import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ErrorMessage } from '../../-private/types';
import type { ToucanFormCheckboxControlComponentSignature } from './controls/checkbox';

export interface ToucanFormCheckboxFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Provide a string or array of strings to this argument to render an error message and apply error styling to the Field.
     */
    error?: ErrorMessage;

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
     * The function called when the element is clicked.
     */
    onChange?: ToucanFormCheckboxControlComponentSignature['Args']['onChange'];

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

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
    super(owner, args);
  }
}
