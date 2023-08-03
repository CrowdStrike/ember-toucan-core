import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { hash } from '@ember/helper';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/icons/lock';
import Checkbox from '../controls/checkbox';
import Field from '../field';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type { ToucanFormCheckboxControlComponentSignature } from '../controls/checkbox';

export interface ToucanFormCheckboxFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Provide a string or array of strings to this argument to render an error message and apply error styling to the Field.
     */
    error?: ErrorMessage;

    /**
     * Provide a string to this argument to render a hint message to help describe the control.
     */
    hint?: string;

    /**
     * Sets the disabled attribute on the control.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the checkbox.
     */
    isReadOnly?: boolean;

    /**
     * Sets the checked state of the checkbox.
     */
    isChecked?: ToucanFormCheckboxControlComponentSignature['Args']['isChecked'];

    /**
     * Sets the indeterminate state of the checkbox.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#indeterminate_state_checkboxes
     */
    isIndeterminate?: ToucanFormCheckboxControlComponentSignature['Args']['isIndeterminate'];

    /**
     * Helps us determine if we are in a checkbox-group or not. This should only be applied internally
     * when using CheckboxGroup.
     *
     * @internal
     */
    isGrouped?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * Sets the name attribute of the checkbox. A string specifying a name for the input control. This name is submitted along with the control's value when the form data is submitted.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#name
     */
    name?: string;

    /**
     * The function called when the element is clicked.
     */
    onChange?: ToucanFormCheckboxControlComponentSignature['Args']['onChange'];

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * This component argument is used to determine if the underlying checkbox is checked.
     * When the `selectedValues` array contains the `value`, the checkbox will be checked.
     * This should only be used for checkbox groups via CheckboxGroupField.
     *
     * @internal
     */
    selectedValues?: Array<string>;

    /**
     * The value argument gets mapped to the underlying value attribute of the checkbox. This should only be used
     * for checkbox groups via CheckboxGroupField.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#handling_multiple_checkboxes
     */
    value?: ToucanFormCheckboxControlComponentSignature['Args']['value'];
  };
  Blocks: {
    label: [];
    hint: [];
  };
}

export default class ToucanFormCheckboxFieldComponent extends Component<ToucanFormCheckboxFieldComponentSignature> {
  LockIcon = LockIcon;

  assertBlockOrArgumentExists = ({
    blockExists,
    argName,
    arg,
    isRequired,
  }: AssertBlockOrArg) =>
    assertBlockOrArgumentExists({ blockExists, argName, arg, isRequired });

  constructor(
    owner: unknown,
    args: ToucanFormCheckboxFieldComponentSignature['Args'],
  ) {
    assert(
      'Both "@value" and "@isChecked" arguments were supplied. "@value" is reserved for being used in a CheckboxGroupField to specify the value attribute, while "@value" sets the checked state of the checkbox. Please use either "@value" or "@isChecked", but not both.',
      !(args.isChecked && args.value),
    );

    super(owner, args);
  }

  get isChecked() {
    if (!this.args?.value) {
      return this.args.isChecked;
    }

    if (!this.args.selectedValues || this.args.selectedValues.length === 0) {
      return false;
    }

    return this.args.selectedValues?.includes(this.args.value);
  }

  /**
   * We want to add a lock icon when a checkbox-field is used by itself and is disabled
   * or readonly, but we do *not* want that icon rendered when we are inside of a
   * checkbox group.
   */
  get isDisabledOrDisabledAndNotInAGroup() {
    let { isDisabled, isGrouped, isReadOnly } = this.args;

    if (isGrouped) {
      return false;
    }

    return isDisabled || isReadOnly;
  }

  <template>
    <div
      class="flex flex-col"
      data-root-field={{if @rootTestSelector @rootTestSelector}}
    >
      <Field as |field|>
        <field.Control
          class="rounded-sm
            {{if @error 'shadow-error-outline'}}
            {{if @value 'p-0' 'p-1'}}"
          data-control
        >

          <label class="flex flex-row space-x-3" for={{field.id}}>
            <Checkbox
              aria-invalid={{if @error "true"}}
              aria-describedby="{{if @error field.errorId}}"
              id={{field.id}}
              name={{@name}}
              @isDisabled={{@isDisabled}}
              @isChecked={{this.isChecked}}
              @isIndeterminate={{@isIndeterminate}}
              @isReadOnly={{@isReadOnly}}
              @onChange={{@onChange}}
              @value={{@value}}
              ...attributes
            />

            <div class="flex flex-col">
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
                <span
                  class="type-md-tight flex items-center gap-1.5 leading-4
                    {{if
                      @isDisabled
                      'text-disabled'
                      'text-titles-and-attributes'
                    }}"
                  data-label
                >
                  {{#if (has-block "label")}}
                    {{yield to="label"}}
                  {{else}}
                    {{@label}}
                  {{/if}}

                  {{#if this.isDisabledOrDisabledAndNotInAGroup}}
                    <this.LockIcon />
                  {{/if}}
                </span>
              {{/if}}

              {{#if
                (this.assertBlockOrArgumentExists
                  (hash blockExists=(has-block "hint") argName="hint" arg=@hint)
                )
              }}
                <field.Hint data-hint @isDisabled={{@isDisabled}}>
                  {{#if (has-block "hint")}}
                    {{yield to="hint"}}
                  {{else}}
                    {{@hint}}
                  {{/if}}
                </field.Hint>
              {{/if}}
            </div>
          </label>
        </field.Control>

        {{#if @error}}
          <field.Error id={{field.errorId}} @error={{@error}} data-error />
        {{/if}}
      </Field>
    </div>
  </template>
}
