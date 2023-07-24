import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { HeadlessFormBlock, UserData } from './types';
import type {
  Option,
  ToucanFormMultiselectFieldComponentSignature as BaseMultiselectFieldSignature,
} from '@crowdstrike/ember-toucan-core/components/form/fields/multiselect';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormMultiselectFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> {
  Element: HTMLInputElement;
  Args: Omit<
    BaseMultiselectFieldSignature<Option>['Args'],
    'error' | 'onChange'
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
  // This will be updated to be typed properly with Clinton's work
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  Blocks: BaseMultiselectFieldSignature<any>['Blocks'];
}

export default class ToucanFormMultiselectFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> extends Component<ToucanFormMultiselectFieldComponentSignature<DATA, KEY>> {
  hasOnlyLabelBlock = (hasLabel: boolean, hasHint: boolean) =>
    hasLabel && !hasHint;
  hasHintAndLabelBlocks = (hasLabel: boolean, hasHint: boolean) =>
    hasLabel && hasHint;
  hasLabelArgAndHintBlock = (hasLabel: string | undefined, hasHint: boolean) =>
    hasLabel && hasHint;

  mapErrors = (errors?: ValidationError[]) => {
    if (!errors) {
      return;
    }

    // @todo we need to figure out what to do when message is undefined
    return errors.map((error) => error.message ?? error.type);
  };

  @action
  assertSelected(value: unknown): Option[] | undefined {
    assert(
      `Only array values are expected for ${String(
        this.args.name
      )}, but you passed ${typeof value}`,
      typeof value === 'undefined' || Array.isArray(value)
    );

    return value;
  }
}
