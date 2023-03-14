import Component from '@glimmer/component';
import { assert } from '@ember/debug';
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
    value: ToucanFormRadioFieldComponentSignature['Args']['value'];
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

  constructor(
    owner: unknown,
    args: ToucanFormRadioGroupFieldComponentSignature['Args']
  ) {
    assert('A "@value" argument is required', args.value);
    super(owner, args);
  }

  @action
  handleInput(value: string, e: Event | InputEvent): void {
    this.args.onChange?.(value, e);
  }
}
