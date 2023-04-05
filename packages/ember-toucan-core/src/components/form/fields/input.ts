import Component from '@glimmer/component';

import assertBlockExists from '../../../-private/helpers/assert-block-exists';
import hasEitherBlockOrArg from '../../../-private/helpers/has-either-block-or-arg';

import type { AssertBlockOrArg } from '../../../-private/helpers/assert-block-exists';
import type { ErrorMessage, OnChangeCallback } from '../../../-private/types';

interface ToucanFormInputFieldComponentSignature {
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
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * The function called when the element is typed into.
     */
    onChange?: OnChangeCallback<string>;

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * Sets the value attribute of the input.
     */
    value?: string;
  };
  Blocks: {
    default: [];
    label: [];
    hint: [];
  };
}

export default class ToucanFormInputFieldComponent extends Component<ToucanFormInputFieldComponentSignature> {
  assert = ({ blockExists, argName, arg, required }: AssertBlockOrArg) =>
    assertBlockExists({ blockExists, argName, arg, required });

  has = (hasBlock: boolean, arg?: string) => hasEitherBlockOrArg(hasBlock, arg);

  get hasError() {
    return Boolean(this.args?.error);
  }
}
