import Component from '@glimmer/component';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/icons/lock';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type {
  Option as ControlOption,
  ToucanFormMultiselectControlComponentSignature,
} from '../controls/multiselect';

export type Option = ControlOption;

export interface ToucanFormMultiselectFieldComponentSignature<
  OPTION extends Option
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
     * Called when the user makes a selection.
     * It is called with the selected options (derived from `@options`) as its only argument.
     */
    onChange?: ToucanFormMultiselectControlComponentSignature<OPTION>['Args']['onChange'];

    /**
     * The function called when a user types into the textbox, typically used to write custom filtering logic.
     */
    onFilter?: ToucanFormMultiselectControlComponentSignature<OPTION>['Args']['onFilter'];

    /**
     * When `@options` is an array of objects, `@selected` is also an object.
     * The `@optionKey` is used to determine which key of the object should
     * be used for both filtering and displaying the selected values in the
     * selected chips.
     */
    optionKey?: ToucanFormMultiselectControlComponentSignature<OPTION>['Args']['optionKey'];

    /**
     * `@options` forms the content of this component.
     *
     * `@options` is simply iterated over then passed back to you as a block parameter (`multiselect.option`).
     */
    options?: ToucanFormMultiselectControlComponentSignature<OPTION>['Args']['options'];

    /**
     * A test selector for targeting the root element of the field.
     * In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * The currently selected options.  If `@options` is an array of strings, provide an array of strings.  If `@options` is an array of objects, pass an array of objects matching the format of `@options`.
     */
    selected?: ToucanFormMultiselectControlComponentSignature<OPTION>['Args']['selected'];
  };
  Blocks: {
    default: ToucanFormMultiselectControlComponentSignature<OPTION>['Blocks']['default'];
    hint: [];
    label: [];
    noResults: ToucanFormMultiselectControlComponentSignature<OPTION>['Blocks']['noResults'];
    remove: ToucanFormMultiselectControlComponentSignature<OPTION>['Blocks']['remove'];
  };
}

export default class ToucanFormMultiselectFieldComponent<
  OPTION extends Option
> extends Component<ToucanFormMultiselectFieldComponentSignature<OPTION>> {
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
