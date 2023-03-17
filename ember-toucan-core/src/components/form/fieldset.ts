import Component from '@glimmer/component';
import { assert } from '@ember/debug';

interface ToucanFormFieldsetComponentSignature {
  Element: HTMLFieldSetElement;
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
     * Sets the disabled attribute on the fieldset.
     */
    isDisabled?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label: string;
  };
  Blocks: {
    default: [];
  };
}

export default class ToucanFormFieldComponent extends Component<ToucanFormFieldsetComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormFieldsetComponentSignature['Args']
  ) {
    assert('A "@label" argument is required', args.label);
    super(owner, args);
  }
}
