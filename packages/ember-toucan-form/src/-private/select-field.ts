import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormSelectFieldComponentSignature as BaseSelectFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/select';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormSelectFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> {
  Element: HTMLInputElement;
  Args: Omit<
    BaseSelectFieldSignature['Args'],
    'error' | 'onChange' | 'selected'
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
  Blocks: BaseSelectFieldSignature['Blocks'];
}

export default class ToucanFormSelectFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> extends Component<ToucanFormSelectFieldComponentSignature<DATA, KEY>> {
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
  assertSelected(value: unknown): string | Record<string, unknown> | undefined {
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
