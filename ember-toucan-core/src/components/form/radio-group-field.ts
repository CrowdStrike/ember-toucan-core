import Component from '@glimmer/component';
import { action } from '@ember/object';

import RadioFieldComponent from './radio-field';

import type { ToucanFormRadioFieldComponentSignature } from './radio-field';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormRadioGroupFieldComponentSignature {
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
     * Sets the disabled attribute on the control.
     */
    isDisabled?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label: string;

    /**
     * Sets the name attribute of the radio. A string specifying a name for the input control. This name is submitted along with the control's value when the form data is submitted.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#name
     */
    name: string;

    /**
     * The function called when a radio element is clicked.
     */
    onChange?: ToucanFormRadioFieldComponentSignature['Args']['onChange'];

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * The currently selected radio element.  This must match the value argument of the individual radio component.
     */
    value?: ToucanFormRadioFieldComponentSignature['Args']['value'];
  };
  Blocks: {
    default: [
      {
        RadioField: WithBoundArgs<
          typeof RadioFieldComponent,
          'isDisabled' | 'name' | 'onChange' | 'selectedValue'
        >;
      }
    ];
  };
}

export default class ToucanFormRadioGroupFieldComponent extends Component<ToucanFormRadioGroupFieldComponentSignature> {
  RadioFieldComponent = RadioFieldComponent;

  @action
  handleInput(value: string, e: Event | InputEvent): void {
    this.args.onChange?.(value, e);
  }
}
