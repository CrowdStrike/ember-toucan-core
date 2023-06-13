import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormFileInputFieldComponentSignature as BaseFileInputFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/file-input';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormFieldInputFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> {
  Element: HTMLInputElement;
  Args: Omit<
    BaseFileInputFieldSignature['Args'],
    'error' | 'files' | 'onChange' | 'name'
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
  Blocks: BaseFileInputFieldSignature['Blocks'];
}

export default class ToucanFormFileInputFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>
> extends Component<ToucanFormFieldInputFieldComponentSignature<DATA, KEY>> {
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
  assertArrayOfFiles(value: unknown): File[] | undefined {
    assert(
      `Only File[] values are expected for ${String(
        this.args.name
      )}, but you passed ${typeof value}`,
      typeof value === 'undefined' ||
        Array.isArray(value) ||
        (value as File[]).forEach((file) => file instanceof File)
    );

    return value as File[] | undefined;
  }
}
