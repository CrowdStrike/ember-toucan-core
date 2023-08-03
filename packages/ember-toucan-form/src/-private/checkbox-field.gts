import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import CheckboxField from '@crowdstrike/ember-toucan-core/components/form/fields/checkbox';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormCheckboxFieldComponentSignature as BaseCheckboxFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/checkbox';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormCheckboxFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
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
  Blocks: BaseCheckboxFieldSignature['Blocks'];
}

export default class ToucanFormTextareaFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
> extends Component<ToucanFormCheckboxFieldComponentSignature<DATA, KEY>> {
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
  assertBoolean(value: unknown): boolean | undefined {
    assert(
      `Only boolean values are expected for ${String(
        this.args.name,
      )}, but you passed ${typeof value}`,
      typeof value === 'undefined' || typeof value === 'boolean',
    );

    return value;
  }

  <template>
    {{!
  Regarding Conditionals

  This looks really messy, but CheckboxField exposes named blocks; HOWEVER,
  we cannot conditionally render named blocks due to https://github.com/emberjs/rfcs/issues/735.

  We *can* conditionally render components though, based on the blocks and argument combinations
  users provide us.  This is very brittle, but until https://github.com/emberjs/rfcs/issues/735
  is resolved and a solution is found, this appears to be the only way to truly expose
  conditional named blocks.

  ---

  Regarding glint-expect-error

  "@onChange" of the checkbox only expects a boolean typed value, but field.setValue is generic,
  accepting anything that DATA[KEY] could be. Similar case with "@isChecked", but there casting to
  a boolean is easy.
}}
    <@form.Field @name={{@name}} as |field|>
      {{#if (this.hasOnlyLabelBlock (has-block "label") (has-block "hint"))}}
        <CheckboxField
          @hint={{@hint}}
          @error={{this.mapErrors field.rawErrors}}
          @isChecked={{this.assertBoolean field.value}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @rootTestSelector={{@rootTestSelector}}
          name={{@name}}
          ...attributes
        >
          <:label>{{yield to="label"}}</:label>
        </CheckboxField>
      {{else if
        (this.hasHintAndLabelBlocks (has-block "label") (has-block "hint"))
      }}
        <CheckboxField
          @error={{this.mapErrors field.rawErrors}}
          @isChecked={{this.assertBoolean field.value}}
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
        </CheckboxField>
      {{else if (this.hasLabelArgAndHintBlock @label (has-block "hint"))}}
        <CheckboxField
          @label={{@label}}
          @error={{this.mapErrors field.rawErrors}}
          @isChecked={{this.assertBoolean field.value}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @rootTestSelector={{@rootTestSelector}}
          name={{@name}}
          ...attributes
        >
          <:hint>{{yield to="hint"}}</:hint>
        </CheckboxField>
      {{else}}
        {{! Argument-only case }}
        <CheckboxField
          @label={{@label}}
          @hint={{@hint}}
          @error={{this.mapErrors field.rawErrors}}
          @isChecked={{this.assertBoolean field.value}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @rootTestSelector={{@rootTestSelector}}
          name={{@name}}
          ...attributes
        />
      {{/if}}
    </@form.Field>
  </template>
}
