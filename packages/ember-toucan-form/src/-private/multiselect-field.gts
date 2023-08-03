import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { hash } from '@ember/helper';
import { action } from '@ember/object';

import MultiselectField from '@crowdstrike/ember-toucan-core/components/form/fields/multiselect';

import type { HeadlessFormBlock, UserData } from './types';
import type { ToucanFormMultiselectFieldComponentSignature as BaseMultiselectFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/multiselect';
import type { FormData, FormKey, ValidationError } from 'ember-headless-form';

export interface ToucanFormMultiselectFieldComponentSignature<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
> {
  Element: HTMLInputElement;
  Args: Omit<BaseMultiselectFieldSignature['Args'], 'error' | 'onChange'> & {
    /**
     * The name of your field, which must match a property of the `@data` passed to the form
     */
    name: KEY;

    /*
     * @internal
     */
    form: HeadlessFormBlock<DATA>;
  };
  Blocks: BaseMultiselectFieldSignature['Blocks'];
}

export default class ToucanFormMultiselectFieldComponent<
  DATA extends UserData,
  KEY extends FormKey<FormData<DATA>> = FormKey<FormData<DATA>>,
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
  assertSelected(value: unknown) {
    assert(
      `\`string[]\` or \`undefined\` is expected for ${String(
        this.args.name,
      )}, but you passed ${typeof value}`,
      Array.isArray(value) || value === undefined,
    );

    return value;
  }

  <template>
    {{!
  Regarding Conditionals

  This looks really messy, but MultiselectField exposes named blocks; HOWEVER,
  we cannot conditionally render named blocks due to https://github.com/emberjs/rfcs/issues/735.

  We *can* conditionally render components though, based on the blocks and argument combinations
  users provide us.  This is very brittle, but until https://github.com/emberjs/rfcs/issues/735
  is resolved and a solution is found, this appears to be the only way to truly expose
  conditional named blocks.

  ---

  Regarding glint-expect-error

  "@onChange" of the component expects a an array typed value, but field.setValue is generic,
  accepting anything that DATA[KEY] could be. Similar case with "@selected", but there casting is easy.
}}
    <@form.Field @name={{@name}} as |field|>
      {{#if (this.hasOnlyLabelBlock (has-block "label") (has-block "hint"))}}
        <MultiselectField
          @contentClass={{@contentClass}}
          @error={{this.mapErrors field.rawErrors}}
          @hint={{@hint}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @label={{@label}}
          @noResultsText={{@noResultsText}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @onFilter={{@onFilter}}
          @options={{@options}}
          @rootTestSelector={{@rootTestSelector}}
          @selectAllText={{@selectAllText}}
          @selected={{this.assertSelected field.value}}
          name={{@name}}
          ...attributes
        >
          <:label>{{yield to="label"}}</:label>

          <:chip as |chip|>
            {{yield
              (hash
                index=chip.index
                option=chip.option
                Chip=(component chip.Chip)
                Remove=(component chip.Remove)
              )
              to="chip"
            }}
          </:chip>

          <:default as |multiselect|>
            {{yield
              (hash
                Option=(component multiselect.Option) option=multiselect.option
              )
            }}
          </:default>
        </MultiselectField>
      {{else if
        (this.hasHintAndLabelBlocks (has-block "label") (has-block "hint"))
      }}
        <MultiselectField
          @contentClass={{@contentClass}}
          @error={{this.mapErrors field.rawErrors}}
          @hint={{@hint}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @label={{@label}}
          @noResultsText={{@noResultsText}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @onFilter={{@onFilter}}
          @options={{@options}}
          @rootTestSelector={{@rootTestSelector}}
          @selectAllText={{@selectAllText}}
          @selected={{this.assertSelected field.value}}
          name={{@name}}
          ...attributes
        >
          <:label>{{yield to="label"}}</:label>
          <:hint>{{yield to="hint"}}</:hint>

          <:chip as |chip|>
            {{yield
              (hash
                index=chip.index
                option=chip.option
                Chip=(component chip.Chip)
                Remove=(component chip.Remove)
              )
              to="chip"
            }}
          </:chip>

          <:default as |multiselect|>
            {{yield
              (hash
                Option=(component multiselect.Option) option=multiselect.option
              )
            }}
          </:default>
        </MultiselectField>
      {{else if (this.hasLabelArgAndHintBlock @label (has-block "hint"))}}
        <MultiselectField
          @contentClass={{@contentClass}}
          @error={{this.mapErrors field.rawErrors}}
          @hint={{@hint}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @label={{@label}}
          @noResultsText={{@noResultsText}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @onFilter={{@onFilter}}
          @options={{@options}}
          @rootTestSelector={{@rootTestSelector}}
          @selectAllText={{@selectAllText}}
          @selected={{this.assertSelected field.value}}
          name={{@name}}
          ...attributes
        >
          <:hint>{{yield to="hint"}}</:hint>

          <:chip as |chip|>
            {{yield
              (hash
                index=chip.index
                option=chip.option
                Chip=(component chip.Chip)
                Remove=(component chip.Remove)
              )
              to="chip"
            }}
          </:chip>

          <:default as |multiselect|>
            {{yield
              (hash
                Option=(component multiselect.Option) option=multiselect.option
              )
            }}
          </:default>
        </MultiselectField>
      {{else}}
        {{! Argument-only case }}
        <MultiselectField
          @contentClass={{@contentClass}}
          @error={{this.mapErrors field.rawErrors}}
          @hint={{@hint}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @label={{@label}}
          @noResultsText={{@noResultsText}}
          {{! @glint-expect-error }}
          @onChange={{field.setValue}}
          @onFilter={{@onFilter}}
          @options={{@options}}
          @rootTestSelector={{@rootTestSelector}}
          @selectAllText={{@selectAllText}}
          @selected={{this.assertSelected field.value}}
          name={{@name}}
          ...attributes
        >
          <:chip as |chip|>
            {{yield
              (hash
                index=chip.index
                option=chip.option
                Chip=(component chip.Chip)
                Remove=(component chip.Remove)
              )
              to="chip"
            }}
          </:chip>

          <:default as |multiselect|>
            {{yield
              (hash
                Option=(component multiselect.Option) option=multiselect.option
              )
            }}
          </:default>
        </MultiselectField>
      {{/if}}
    </@form.Field>
  </template>
}
