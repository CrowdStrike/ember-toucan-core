import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormCheckboxFieldComponentSignature as BaseCheckboxFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/checkbox';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormCheckboxFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> {
  Element: HTMLInputElement;
  Args: Omit<
    BaseCheckboxFieldSignature['Args'],
    'error' | 'isChecked' | 'onChange' | 'name'
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
    default: [];
  };
}

export default class ToucanFormTextareaFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> extends Component<ToucanFormCheckboxFieldComponentSignature<DATA, KEY>> {
  mapErrors = (errors?: ValidationError[]) => {
    if (!errors) {
      return;
    }

    // @todo we need to figure out what to do when message is undefined
    return errors.map((error) => error.message ?? error.type);
  };

  @action
  assertBoolean(value: unknown): boolean | undefined {
    assert(
      `Only boolean values are expected for ${String(
        this.args.name
      )}, but you passed ${typeof value}`,
      typeof value === 'undefined' || typeof value === 'boolean'
    );

    return value;
  }
}
