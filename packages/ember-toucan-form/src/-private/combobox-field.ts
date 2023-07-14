import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { HeadlessFormBlock, UserData } from './types';
import type {
  Option,
  ToucanFormComboboxFieldComponentSignature as BaseComboboxFieldSignature,
} from '@crowdstrike/ember-toucan-core/components/form/fields/combobox';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormComboboxFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> {
  Element: HTMLInputElement;
  Args: Omit<
    BaseComboboxFieldSignature<Option>['Args'],
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
  // TODO: How do we get this to play nicely with our
  // generic in toucan-core?
  // `BaseComboboxFieldSignature<Option>['Blocks'];`
  // gives a glint error!
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  Blocks: BaseComboboxFieldSignature<any>['Blocks'];
}

export default class ToucanFormComboboxFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> extends Component<ToucanFormComboboxFieldComponentSignature<DATA, KEY>> {
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
  assertSelected(value: unknown): Option {
    assert(
      `Only string or object values are expected for ${String(
        this.args.name
      )}, but you passed ${typeof value}`,
      typeof value === 'undefined' ||
        typeof value === 'string' ||
        typeof value === 'object'
    );

    return value as string | Record<string, unknown>;
  }
}
