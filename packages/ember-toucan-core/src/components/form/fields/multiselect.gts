import Component from '@glimmer/component';
import { hash } from '@ember/helper';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/icons/lock';
import Multiselect from '../controls/multiselect';
import Field from '../field';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type { ToucanFormMultiselectControlComponentSignature } from '../controls/multiselect';

export interface ToucanFormMultiselectFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * A CSS class to add to this component's content container.
     * Commonly used to specify a `z-index`.
     */
    contentClass?: string;

    /**
     * Provide a string or array of strings to this argument to render an error message and apply error styling to the Field.
     */
    error?: ErrorMessage;

    /**
     * Provide a string to this argument to render a hint message to help describe the control.
     */
    hint?: string;

    /**
     * Sets the disabled attribute on the input.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the input.
     */
    isReadOnly?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * A string to display when there are no results after filtering.
     */
    noResultsText: string;

    /**
     * Called when the user makes a selection.
     * It is called with the selected options (derived from `@options`) as its only argument.
     */
    onChange?: ToucanFormMultiselectControlComponentSignature['Args']['onChange'];

    /**
     * The function called when a user types into the textbox, typically used to write custom filtering logic.
     */
    onFilter?: ToucanFormMultiselectControlComponentSignature['Args']['onFilter'];

    /**
     * `@options` forms the content of this component.
     *
     * `@options` is simply iterated over then passed back to you as a block parameter (`multiselect.option`).
     */
    options?: ToucanFormMultiselectControlComponentSignature['Args']['options'];

    /**
     * A test selector for targeting the root element of the field.
     * In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * A string to render as the "Select all" option label.  By providing this argument,
     * you are opting into the "Select all" functionality and the checkbox will be rendered
     * at the top of the popover.
     *
     * - The checkbox only appears when filtering is not active.
     * - The checkbox will be checked when all options are selected.
     * - If no options are selected, the checkbox will be unchecked.
     * - If more than one option is selected, but not all of them, then the checkbox will be in the indeterminate state.
     * - When the checkbox is in the indeterminate state, clicking the checkbox re-selects all options.
     */
    selectAllText?: string;

    /**
     * The currently selected option.
     */
    selected?: ToucanFormMultiselectControlComponentSignature['Args']['selected'];
  };
  Blocks: {
    chip: ToucanFormMultiselectControlComponentSignature['Blocks']['chip'];
    default: ToucanFormMultiselectControlComponentSignature['Blocks']['default'];
    hint: [];
    label: [];
  };
}

export default class ToucanFormMultiselectFieldComponent extends Component<ToucanFormMultiselectFieldComponentSignature> {
  LockIcon = LockIcon;

  assertBlockOrArgumentExists = ({
    blockExists,
    argName,
    arg,
    isRequired,
  }: AssertBlockOrArg) =>
    assertBlockOrArgumentExists({ blockExists, argName, arg, isRequired });

  get hasError() {
    return Boolean(this.args?.error);
  }

  get isReadOnlyOrDisabled() {
    return this.args?.isDisabled || this.args?.isReadOnly;
  }

  <template>
    <div
      class="flex flex-col {{if @isDisabled 'text-disabled'}}"
      data-root-field={{if @rootTestSelector @rootTestSelector null}}
    >
      <Field as |field|>
        {{#if
          (this.assertBlockOrArgumentExists
            (hash
              blockExists=(has-block "label")
              argName="label"
              arg=@label
              isRequired=true
            )
          )
        }}
          <field.Label
            class="flex items-center gap-1.5"
            for={{field.id}}
            data-label
            @isDisabled={{@isDisabled}}
          >
            {{#if (has-block "label")}}
              {{yield to="label"}}
            {{else}}
              {{@label}}
            {{/if}}

            {{#if this.isReadOnlyOrDisabled}}
              <this.LockIcon />
            {{/if}}
          </field.Label>
        {{/if}}

        {{#if
          (this.assertBlockOrArgumentExists
            (hash blockExists=(has-block "hint") argName="hint" arg=@hint)
          )
        }}
          <field.Hint id={{field.hintId}} data-hint @isDisabled={{@isDisabled}}>
            {{#if (has-block "hint")}}
              {{yield to="hint"}}
            {{else}}
              {{@hint}}
            {{/if}}
          </field.Hint>
        {{/if}}

        <field.Control class="mt-1.5 flex">
          <Multiselect
            id={{field.id}}
            aria-describedby="{{if @error field.errorId}} {{if
              @hint
              field.hintId
            }}"
            aria-invalid={{if @error "true"}}
            @contentClass={{@contentClass}}
            @hasError={{this.hasError}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @noResultsText={{@noResultsText}}
            @onChange={{@onChange}}
            @onFilter={{@onFilter}}
            @options={{@options}}
            @selectAllText={{@selectAllText}}
            @selected={{@selected}}
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
                  Option=(component multiselect.Option)
                  option=multiselect.option
                )
              }}
            </:default>
          </Multiselect>
        </field.Control>

        {{#if @error}}
          <field.Error id={{field.errorId}} @error={{@error}} data-error />
        {{/if}}
      </Field>
    </div>
  </template>
}
