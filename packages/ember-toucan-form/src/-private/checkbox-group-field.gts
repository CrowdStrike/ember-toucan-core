import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { hash } from '@ember/helper';
import { action } from '@ember/object';

import CheckboxGroupField from '@crowdstrike/ember-toucan-core/components/form/fields/checkbox-group';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormCheckboxGroupFieldComponentSignature as BaseCheckboxGroupFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/checkbox-group';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormCheckboxGroupFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
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
  Blocks: BaseCheckboxGroupFieldSignature['Blocks'];
}

export default class ToucanFormTextareaFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
> extends Component<ToucanFormCheckboxGroupFieldComponentSignature<DATA, KEY>> {
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
  assertArrayOfStrings(value: unknown): Array<string> | undefined {
    assert(
      `Only array of string values are expected for ${String(
        this.args.name,
      )}, but you passed ${typeof value}`,
      typeof value === 'undefined' || Array.isArray(value),
    );

    return value;
  }

  <template>
    {{!
  Regarding Conditionals

  This looks really messy, but CheckboxGroupField exposes named blocks; HOWEVER,
  we cannot conditionally render named blocks due to https://github.com/emberjs/rfcs/issues/735.

  We *can* conditionally render components though, based on the blocks and argument combinations
  users provide us.  This is very brittle, but until https://github.com/emberjs/rfcs/issues/735
  is resolved and a solution is found, this appears to be the only way to truly expose
  conditional named blocks.

  ---

  Regarding glint-expect-error

  "@onChange" of the checkbox-group only expects an array of strings typed value, but field.setValue is generic,
  accepting anything that DATA[KEY] could be. Similar case with "@isChecked", but there casting to
  an array of strings is easy.
}}
    <@form.Field @name={{@name}} as |field|>
      {{#if (this.hasOnlyLabelBlock (has-block "label") (has-block "hint"))}}
        <CheckboxGroupField
          @hint={{@hint}}
          @error={{this.mapErrors field.rawErrors}}
          @value={{this.assertArrayOfStrings field.value}}
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
            {{yield (hash CheckboxField=group.CheckboxField) to="default"}}
          </:default>
        </CheckboxGroupField>
      {{else if
        (this.hasHintAndLabelBlocks (has-block "label") (has-block "hint"))
      }}
        <CheckboxGroupField
          @error={{this.mapErrors field.rawErrors}}
          @value={{this.assertArrayOfStrings field.value}}
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
            {{yield (hash CheckboxField=group.CheckboxField)}}
          </:default>
        </CheckboxGroupField>
      {{else if (this.hasLabelArgAndHintBlock @label (has-block "hint"))}}
        <CheckboxGroupField
          @label={{@label}}
          @error={{this.mapErrors field.rawErrors}}
          @value={{this.assertArrayOfStrings field.value}}
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
            {{yield (hash CheckboxField=group.CheckboxField)}}
          </:default>
        </CheckboxGroupField>
      {{else}}
        {{! Argument-only case }}
        <CheckboxGroupField
          @label={{@label}}
          @hint={{@hint}}
          @error={{this.mapErrors field.rawErrors}}
          @value={{this.assertArrayOfStrings field.value}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @rootTestSelector={{@rootTestSelector}}
          @name={{@name}}
          ...attributes
          as |group|
        >
          {{yield (hash CheckboxField=group.CheckboxField)}}
        </CheckboxGroupField>
      {{/if}}
    </@form.Field>
  </template>
}
