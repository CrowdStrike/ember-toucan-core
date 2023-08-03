import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { hash } from '@ember/helper';
import { action } from '@ember/object';

import InputField from '@crowdstrike/ember-toucan-core/components/form/fields/input';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormInputFieldComponentSignature as BaseInputFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/input';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormInputFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
> {
  Element: HTMLInputElement;
  Args: Omit<
    BaseInputFieldSignature['Args'],
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
  Blocks: BaseInputFieldSignature['Blocks'];
}

export default class ToucanFormInputFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
> extends Component<ToucanFormInputFieldComponentSignature<DATA, KEY>> {
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

  This looks really messy, but InputField exposes named blocks; HOWEVER,
  we cannot conditionally render named blocks due to https://github.com/emberjs/rfcs/issues/735.

  We *can* conditionally render components though, based on the blocks and argument combinations
  users provide us.  This is very brittle, but until https://github.com/emberjs/rfcs/issues/735
  is resolved and a solution is found, this appears to be the only way to truly expose
  conditional named blocks.

  ---

  Regarding glint-expect-error

  "@onChange" of the input only expects a string typed value, but field.setValue is generic,
  accepting anything that DATA[KEY] could be. Similar case with "@value", but there casting to
  a string is easy.
}}
    <@form.Field @name={{@name}} as |field|>
      {{#if (has-block "secondary")}}
        {{#if (this.hasOnlyLabelBlock (has-block "label") (has-block "hint"))}}
          <InputField
            @hint={{@hint}}
            @error={{this.mapErrors field.rawErrors}}
            @value={{this.assertString field.value}}
            {{! @glint-expect-error }}
            @onChange={{field.setValue}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @rootTestSelector={{@rootTestSelector}}
            name={{@name}}
            ...attributes
          >
            <:label>{{yield to="label"}}</:label>
            <:secondary as |secondary|>
              {{yield
                (hash CharacterCount=(component secondary.CharacterCount))
                to="secondary"
              }}
            </:secondary>
          </InputField>
        {{else if
          (this.hasHintAndLabelBlocks (has-block "label") (has-block "hint"))
        }}
          <InputField
            @error={{this.mapErrors field.rawErrors}}
            @value={{this.assertString field.value}}
            {{! @glint-expect-error }}
            @onChange={{field.setValue}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @rootTestSelector={{@rootTestSelector}}
            name={{@name}}
            ...attributes
          >
            <:label>{{yield to="label"}}</:label>
            <:hint>{{yield to="hint"}}</:hint>
            <:secondary as |secondary|>
              {{yield
                (hash CharacterCount=(component secondary.CharacterCount))
                to="secondary"
              }}
            </:secondary>
          </InputField>
        {{else if (this.hasLabelArgAndHintBlock @label (has-block "hint"))}}
          <InputField
            @label={{@label}}
            @error={{this.mapErrors field.rawErrors}}
            @value={{this.assertString field.value}}
            {{! @glint-expect-error }}
            @onChange={{field.setValue}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @rootTestSelector={{@rootTestSelector}}
            name={{@name}}
            ...attributes
          >
            <:hint>{{yield to="hint"}}</:hint>
            <:secondary as |secondary|>
              {{yield
                (hash CharacterCount=(component secondary.CharacterCount))
                to="secondary"
              }}
            </:secondary>
          </InputField>
        {{else}}
          {{! Argument-only case }}
          <InputField
            @label={{@label}}
            @hint={{@hint}}
            @error={{this.mapErrors field.rawErrors}}
            @value={{this.assertString field.value}}
            {{! @glint-expect-error }}
            @onChange={{field.setValue}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @rootTestSelector={{@rootTestSelector}}
            name={{@name}}
            ...attributes
          >
            <:secondary as |secondary|>
              {{yield
                (hash CharacterCount=(component secondary.CharacterCount))
                to="secondary"
              }}
            </:secondary>
          </InputField>
        {{/if}}
      {{else}}
        {{#if (this.hasOnlyLabelBlock (has-block "label") (has-block "hint"))}}
          <InputField
            @hint={{@hint}}
            @error={{this.mapErrors field.rawErrors}}
            @value={{this.assertString field.value}}
            {{! @glint-expect-error }}
            @onChange={{field.setValue}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @rootTestSelector={{@rootTestSelector}}
            name={{@name}}
            ...attributes
          >
            <:label>{{yield to="label"}}</:label>
          </InputField>
        {{else if
          (this.hasHintAndLabelBlocks (has-block "label") (has-block "hint"))
        }}
          <InputField
            @error={{this.mapErrors field.rawErrors}}
            @value={{this.assertString field.value}}
            {{! @glint-expect-error }}
            @onChange={{field.setValue}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @rootTestSelector={{@rootTestSelector}}
            name={{@name}}
            ...attributes
          >
            <:label>{{yield to="label"}}</:label>
            <:hint>{{yield to="hint"}}</:hint>
          </InputField>
        {{else if (this.hasLabelArgAndHintBlock @label (has-block "hint"))}}
          <InputField
            @label={{@label}}
            @error={{this.mapErrors field.rawErrors}}
            @value={{this.assertString field.value}}
            {{! @glint-expect-error }}
            @onChange={{field.setValue}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @rootTestSelector={{@rootTestSelector}}
            name={{@name}}
            ...attributes
          >
            <:hint>{{yield to="hint"}}</:hint>
          </InputField>
        {{else}}
          {{! Argument-only case }}
          <InputField
            @label={{@label}}
            @hint={{@hint}}
            @error={{this.mapErrors field.rawErrors}}
            @value={{this.assertString field.value}}
            {{! @glint-expect-error }}
            @onChange={{field.setValue}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @rootTestSelector={{@rootTestSelector}}
            name={{@name}}
            ...attributes
          />
        {{/if}}
      {{/if}}
    </@form.Field>
  </template>
}
