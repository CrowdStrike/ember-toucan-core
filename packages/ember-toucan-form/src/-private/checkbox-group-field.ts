import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormCheckboxGroupFieldComponentSignature as BaseCheckboxGroupFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/checkbox-group';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormCheckboxGroupFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> {
  Element: HTMLFieldSetElement;
  Args: Omit<
    BaseCheckboxGroupFieldSignature['Args'],
    'error' | 'value' | 'onChange'
  > & {
    /**
     * The name of your field, which must match a property of the `@data` passed to the form
     */
    name: KEY;

    /*
     * @internal
     */
    form: HeadlessFormBlock<DATA>;
  };
  Blocks: {
    default: [
      {
        CheckboxField: BaseCheckboxGroupFieldSignature['Blocks']['default'][0]['CheckboxField'];
      }
    ];
  };
}

export default class ToucanFormTextareaFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> extends Component<ToucanFormCheckboxGroupFieldComponentSignature<DATA, KEY>> {
  mapErrors = (errors?: ValidationError[]) => {
    if (!errors) {
      return;
    }

    // @todo we need to figure out what to do when message is undefined
    return errors.map((error) => error.message ?? error.type);
  };

  @action
  assertArrayOfStrings(value: unknown): Array<string> | undefined {
    assert(
      `Only array of string values are expected for ${String(
        this.args.name
      )}, but you passed ${typeof value}`,
      typeof value === 'undefined' || Array.isArray(value)
    );

    return value;
  }
}
