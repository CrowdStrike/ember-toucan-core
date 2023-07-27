import Component from '@glimmer/component';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/icons/lock';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type { ToucanFormAutocompleteControlComponentSignature } from '../controls/autocomplete';

export interface ToucanFormAutocompleteFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * A CSS class to add to this component's content container.
     * Commonly used to specify a `z-index`.
     */
    contentClass?: string;

    /**
     * Provide a string or array of strings to this argument to render an error message and apply error styling to the Field.
     */
    error?: ErrorMessage;

    /**
     * Provide a string to this argument to render a hint message to help describe the control.
     */
    hint?: string;

    /**
     * Sets the disabled attribute on the input.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the input.
     */
    isReadOnly?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * A string to display when there are no results after filtering.
     */
  noResultsText: string;

    /**
     * The function called when a new selection is made.
     */
    onChange?: ToucanFormAutocompleteControlComponentSignature['Args']['onChange'];

    /**
     * The function called when a user types into the textbox.
     *
     * Typically used for making a request to the server and populating
     * `@options` with the results.
     */
    onFilter?: ToucanFormAutocompleteControlComponentSignature['Args']['onFilter'];

    /**
     * `@options` forms the content of this component.
     * `@options` is iterated over then passed back to you as a block parameter (`select.option`).
     */
    options?: ToucanFormAutocompleteControlComponentSignature['Args']['options'];

    /**
     * A test selector for targeting the root element of the field.
     * In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * The currently selected option.
     */
    selected?: ToucanFormAutocompleteControlComponentSignature['Args']['selected'];
  };
  Blocks: {
    default: ToucanFormAutocompleteControlComponentSignature['Blocks']['default'];
    label: [];
    hint: [];
  };
}

export default class ToucanFormAutocompleteFieldComponent extends Component<ToucanFormAutocompleteFieldComponentSignature> {
  LockIcon = LockIcon;

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

  get isReadOnlyOrDisabled() {
    return this.args?.isDisabled || this.args?.isReadOnly;
  }
}
