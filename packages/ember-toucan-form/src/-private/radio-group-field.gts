import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { hash } from '@ember/helper';
import { action } from '@ember/object';

import RadioGroupField from '@crowdstrike/ember-toucan-core/components/form/fields/radio-group';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormRadioGroupFieldComponentSignature as BaseRadioGroupFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/radio-group';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormRadioGroupFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
> {
  Element: HTMLFieldSetElement;
  Args: Omit<
    BaseRadioGroupFieldSignature['Args'],
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
  Blocks: BaseRadioGroupFieldSignature['Blocks'];
}

export default class ToucanFormTextareaFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
> extends Component<ToucanFormRadioGroupFieldComponentSignature<DATA, KEY>> {
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
  assertString(value: unknown): string | undefined {
    assert(
      `Only string values are expected for ${String(
        this.args.name,
      )}, but you passed ${typeof value}`,
      typeof value === 'undefined' || typeof value === 'string',
    );

    return value;
  }

  <template>
    {{!
  Regarding Conditionals

  This looks really messy, but RadioGroupField exposes named blocks; HOWEVER,
  we cannot conditionally render named blocks due to https://github.com/emberjs/rfcs/issues/735.

  We *can* conditionally render components though, based on the blocks and argument combinations
  users provide us.  This is very brittle, but until https://github.com/emberjs/rfcs/issues/735
  is resolved and a solution is found, this appears to be the only way to truly expose
  conditional named blocks.

  ---

  Regarding glint-expect-error

  "@onChange" of the radio-group only expects a string typed value, but field.setValue is generic,
  accepting anything that DATA[KEY] could be. Similar case with "@isChecked", but there casting to
  a string is easy.
}}
    <@form.Field @name={{@name}} as |field|>
      {{#if (this.hasOnlyLabelBlock (has-block "label") (has-block "hint"))}}
        <RadioGroupField
          @hint={{@hint}}
          @error={{this.mapErrors field.rawErrors}}
          @value={{this.assertString field.value}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @rootTestSelector={{@rootTestSelector}}
          @name={{@name}}
          ...attributes
        >
          <:label>{{yield to="label"}}</:label>
          <:default as |group|>
            {{yield (hash RadioField=group.RadioField)}}
          </:default>
        </RadioGroupField>
      {{else if
        (this.hasHintAndLabelBlocks (has-block "label") (has-block "hint"))
      }}
        <RadioGroupField
          @error={{this.mapErrors field.rawErrors}}
          @value={{this.assertString field.value}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @rootTestSelector={{@rootTestSelector}}
          @name={{@name}}
          ...attributes
        >
          <:label>{{yield to="label"}}</:label>
          <:hint>{{yield to="hint"}}</:hint>
          <:default as |group|>
            {{yield (hash RadioField=group.RadioField)}}
          </:default>
        </RadioGroupField>
      {{else if (this.hasLabelArgAndHintBlock @label (has-block "hint"))}}
        <RadioGroupField
          @label={{@label}}
          @error={{this.mapErrors field.rawErrors}}
          @value={{this.assertString field.value}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @rootTestSelector={{@rootTestSelector}}
          @name={{@name}}
          ...attributes
        >
          <:hint>{{yield to="hint"}}</:hint>
          <:default as |group|>
            {{yield (hash RadioField=group.RadioField)}}
          </:default>
        </RadioGroupField>
      {{else}}
        {{! Argument-only case }}
        <RadioGroupField
          @label={{@label}}
          @hint={{@hint}}
          @error={{this.mapErrors field.rawErrors}}
          @value={{this.assertString field.value}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @rootTestSelector={{@rootTestSelector}}
          @name={{@name}}
          ...attributes
          as |group|
        >
          {{yield (hash RadioField=group.RadioField)}}
        </RadioGroupField>
      {{/if}}
    </@form.Field>
  </template>
}
