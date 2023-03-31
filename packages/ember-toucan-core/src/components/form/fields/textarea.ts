import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ErrorMessage } from '../../../-private/types';
import type { ToucanFormTextareaControlComponentSignature } from '../controls/textarea';

export interface ToucanFormTextareaFieldComponentSignature {
  Element: HTMLTextAreaElement;
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
    label: string;

    /**
     * The function called when the element is typed into.
     */
    onChange?: ToucanFormTextareaControlComponentSignature['Args']['onChange'];

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * Sets the value attribute of the textarea.
     */
    value?: ToucanFormTextareaControlComponentSignature['Args']['value'];
  };
  Blocks: {
    label: [];
    hint: [];
  };
}

export default class ToucanFormTextareaFieldComponent extends Component<ToucanFormTextareaFieldComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormTextareaFieldComponentSignature['Args']
  ) {
    assert('A "@label" argument is required', args.label);
    super(owner, args);
  }

  get hasError() {
    return Boolean(this.args?.error);
  }
}
