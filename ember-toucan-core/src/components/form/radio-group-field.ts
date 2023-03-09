import Component from '@glimmer/component';
import { action } from '@ember/object';

import RadioFieldComponent from './radio-field';

import type { ToucanFormRadioFieldComponentSignature } from './radio-field';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormRadioGroupFieldComponentSignature {
  Element: HTMLFieldSetElement;
  Args: {
    error?: string;
    hint?: string;
    isDisabled?: boolean;
    label: string;
    name: string;
    onChange?: ToucanFormRadioFieldComponentSignature['Args']['onChange'];
    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;
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
