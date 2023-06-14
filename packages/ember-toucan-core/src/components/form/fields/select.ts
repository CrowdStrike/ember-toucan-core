import Component from '@glimmer/component';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type { ToucanFormSelectControlComponentSignature } from '../controls/select';

export interface ToucanFormSelectFieldComponentSignature {
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
     * Sets the values to be selected on render.
     */
    initialSelectedValues?: string[];

    /**
     * Sets the disabled attribute on the input.
     */
    isDisabled?: boolean;

    /**
     * Set to allow multiple option to be selected at once.
     */
    isMultiple?: boolean;

    /**
     * Sets the readonly attribute of the input.
     */
    isReadOnly?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * The function called when a new selection is made.
     */
    onChange?: (values: string[]) => void;

    /**
     * A CSS class to add to the popover.
     * Commonly used to specify a `z-index`.
     */
    popoverClass?: string;

    /**
     * A test selector for targeting the root element of the field.
     * In this case, the wrapping div element.
     */
    rootTestSelector?: string;
  };
  Blocks: {
    default: ToucanFormSelectControlComponentSignature['Blocks']['default'];
    label: [];
    hint: [];
  };
}

export default class ToucanFormInputFieldComponent extends Component<ToucanFormSelectFieldComponentSignature> {
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
}
