import Component from '@glimmer/component';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/icons/lock';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type {
  Option as ControlOption,
  ToucanFormComboboxControlComponentSignature,
} from '../controls/combobox';

export type Option = ControlOption;

export interface ToucanFormComboboxFieldComponentSignature<
  OPTION extends ControlOption
> {
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
     * A string to display when there are no results after the user's filter.
     */
    noResultsText?: string;

    /**
     * The function called when a new selection is made.
     */
    onChange?: ToucanFormComboboxControlComponentSignature<OPTION>['Args']['onChange'];

    /**
     * The function called when a user types into the combobox textbox.
     *
     * Typically used for making a request to the server and populating
     * `@options` with the results.
     */
    onFilter?: ToucanFormComboboxControlComponentSignature<OPTION>['Args']['onFilter'];

    /**
     * When `@options` is an array of objects, `@selected` is also an object.
     * The `@optionKey` is used to determine which key of the object should
     * be used for both filtering and displayed the selected value in the
     * textbox.
     */
    optionKey?: ToucanFormComboboxControlComponentSignature<OPTION>['Args']['optionKey'];

    /**
     * `@options` forms the content of this component.
     *
     * To support a variety of data shapes, `@options` is typed as `unknown[]` and treated as though it were opaque.
     * `@options` is simply iterated over then passed back to you as a block parameter (`select.option`).
     */
    options?: ToucanFormComboboxControlComponentSignature<OPTION>['Args']['options'];

    /**
     * A test selector for targeting the root element of the field.
     * In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * The currently selected option.  If `@options` is an array of strings, provide a string.  If `@options` is an array of objects, pass the entire object and use `@optionKey`.
     */
    selected?: ToucanFormComboboxControlComponentSignature<OPTION>['Args']['selected'];
  };
  Blocks: {
    default: ToucanFormComboboxControlComponentSignature<OPTION>['Blocks']['default'];
    label: [];
    hint: [];
  };
}

export default class ToucanFormComboboxFieldComponent<
  OPTION extends ControlOption
> extends Component<ToucanFormComboboxFieldComponentSignature<OPTION>> {
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
