import Component from '@glimmer/component';
import { action } from '@ember/object';

import CheckboxFieldComponent from './checkbox-field';

import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormCheckboxGroupFieldComponentSignature {
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

    /**
     * Sets the name attribute of the checkboxes. A string specifying a name for the input control. This name is submitted along with the control's value when the form data is submitted.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#name
     */
    name: string;

    /**
     * The function called when a checkbox element is clicked.
     */
    onChange?: (selectedValues: Array<string>, e: Event | InputEvent) => void;

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * The currently selected checkbox elements. The elements with the matching `@option` / underlying value attribute will be checked.
     */
    value?: Array<string>;
  };
  Blocks: {
    default: [
      {
        CheckboxField: WithBoundArgs<
          typeof CheckboxFieldComponent,
          'isDisabled' | 'name' | 'value'
        >;
      }
    ];
  };
}

export default class ToucanFormCheckboxGroupFieldComponent extends Component<ToucanFormCheckboxGroupFieldComponentSignature> {
  CheckboxFieldComponent = CheckboxFieldComponent;

  @action
  handleInput(_: boolean, e: Event | InputEvent): void {
    let value = this.args.value ? [...this.args.value] : [];

    let target = e.target as HTMLInputElement;

    if (value?.includes(target.value)) {
      value = value.filter((val) => val !== target.value);
    } else {
      value.push(target.value);
    }

    this.args.onChange?.(value, e);
  }
}
