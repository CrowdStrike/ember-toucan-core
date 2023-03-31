import Component from '@glimmer/component';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage, OnChangeCallback } from '../../../-private/types';

export interface ToucanFormInputFieldComponentSignature {
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
    character: [
      {
        id: string;
      }
    ];
  };
}

export default class ToucanFormInputFieldComponent extends Component<ToucanFormInputFieldComponentSignature> {
  assertBlockOrArgumentExists = ({
    blockExists,
    argName,
    arg,
    isRequired,
  }: AssertBlockOrArg) =>
    assertBlockOrArgumentExists({ blockExists, argName, arg, isRequired });

  get hasError() {
    return Boolean(this.args?.error);
  }

  /**
   * Used to help us determine if we should render a single error
   * or render a ul list of errors.
   */
  get hasMoreThanOneError() {
    return Array.isArray(this.args.error) && this.args.error?.length > 1;
  }
}
