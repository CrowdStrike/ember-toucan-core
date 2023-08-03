import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import FileInputField from '@crowdstrike/ember-toucan-core/components/form/fields/file-input';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormFileInputFieldComponentSignature as BaseFileInputFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/file-input';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormFieldInputFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
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
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
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
        this.args.name,
      )}, but you passed ${typeof value}`,
      value === undefined ||
        (Array.isArray(value) && value.every((file) => file instanceof File)),
    );

    return value as File[] | undefined;
  }

  <template>
    {{!
  Regarding Conditionals

  This looks really messy, but FileInputField exposes named blocks; HOWEVER,
  we cannot conditionally render named blocks due to https://github.com/emberjs/rfcs/issues/735.

  We *can* conditionally render components though, based on the blocks and argument combinations
  users provide us.  This is very brittle, but until https://github.com/emberjs/rfcs/issues/735
  is resolved and a solution is found, this appears to be the only way to truly expose
  conditional named blocks.

  ---

  Regarding glint-expect-error

  "@onChange" of the FileInput only expects an array of files typed value, but field.setValue is generic,
  accepting anything that DATA[KEY] could be. Similar case with "@files", but there casting to is easy.
}}
    <@form.Field @name={{@name}} as |field|>
      {{#if (this.hasOnlyLabelBlock (has-block "label") (has-block "hint"))}}
        <FileInputField
          @accept={{@accept}}
          @deleteLabel={{@deleteLabel}}
          @error={{this.mapErrors field.rawErrors}}
          @files={{this.assertArrayOfFiles field.value}}
          @hint={{@hint}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @multiple={{@multiple}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @rootTestSelector={{@rootTestSelector}}
          @trigger={{@trigger}}
          name={{@name}}
          ...attributes
        >
          <:label>{{yield to="label"}}</:label>
        </FileInputField>
      {{else if
        (this.hasHintAndLabelBlocks (has-block "label") (has-block "hint"))
      }}
        <FileInputField
          @accept={{@accept}}
          @deleteLabel={{@deleteLabel}}
          @error={{this.mapErrors field.rawErrors}}
          @files={{this.assertArrayOfFiles field.value}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @multiple={{@multiple}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @rootTestSelector={{@rootTestSelector}}
          @trigger={{@trigger}}
          name={{@name}}
          ...attributes
        >
          <:label>{{yield to="label"}}</:label>
          <:hint>{{yield to="hint"}}</:hint>
        </FileInputField>
      {{else if (this.hasLabelArgAndHintBlock @label (has-block "hint"))}}
        <FileInputField
          @accept={{@accept}}
          @deleteLabel={{@deleteLabel}}
          @error={{this.mapErrors field.rawErrors}}
          @files={{this.assertArrayOfFiles field.value}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @label={{@label}}
          @multiple={{@multiple}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @rootTestSelector={{@rootTestSelector}}
          @trigger={{@trigger}}
          name={{@name}}
          ...attributes
        >
          <:hint>{{yield to="hint"}}</:hint>
        </FileInputField>
      {{else}}
        {{! Argument-only case }}
        <FileInputField
          @accept={{@accept}}
          @deleteLabel={{@deleteLabel}}
          @error={{this.mapErrors field.rawErrors}}
          @files={{this.assertArrayOfFiles field.value}}
          @hint={{@hint}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @label={{@label}}
          @multiple={{@multiple}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @rootTestSelector={{@rootTestSelector}}
          @trigger={{@trigger}}
          name={{@name}}
          ...attributes
        />
      {{/if}}
    </@form.Field>
  </template>
}
