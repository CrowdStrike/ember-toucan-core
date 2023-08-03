import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { hash } from '@ember/helper';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import Radio from '../controls/radio';
import Field from '../field';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ToucanFormRadioControlComponentSignature } from '../controls/radio';

export interface ToucanFormRadioFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Provide a string to this argument to render a hint message to help describe the control.
     */
    hint?: string;

    /**
     * Sets the disabled attribute on the control.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the radio.
     */
    isReadOnly?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * Sets the name attribute of the radio. A string specifying a name for the input control. This name is submitted along with the control's value when the form data is submitted.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#name
     */
    name: string;

    /**
     * The function called when the element is clicked.
     */
    onChange?: ToucanFormRadioControlComponentSignature['Args']['onChange'];

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * This component argument is used to determine if the underlying radio is checked.
     * When `selectedValue` and `value` are equal, the radio will have the checked attribute applied.
     */
    selectedValue?: string;

    /**
     * Sets the value attribute of the radio.
     */
    value: ToucanFormRadioControlComponentSignature['Args']['value'];
  };
  Blocks: {
    label: [];
    hint: [];
  };
}

export default class ToucanFormRadioFieldComponent extends Component<ToucanFormRadioFieldComponentSignature> {
  assertBlockOrArgumentExists = ({
    blockExists,
    argName,
    arg,
    isRequired,
  }: AssertBlockOrArg) =>
    assertBlockOrArgumentExists({ blockExists, argName, arg, isRequired });

  constructor(
    owner: unknown,
    args: ToucanFormRadioFieldComponentSignature['Args'],
  ) {
    assert('A "@name" argument is required', args.name);
    super(owner, args);
  }

  get isChecked() {
    return this.args?.selectedValue === this.args.value;
  }

  <template>
    <div
      class="flex flex-col"
      data-root-field={{if @rootTestSelector @rootTestSelector}}
    >
      <Field as |field|>
        <field.Control class="rounded-sm" data-control>

          <label class="flex flex-row space-x-3" for={{field.id}}>
            <Radio
              id={{field.id}}
              name={{@name}}
              @isDisabled={{@isDisabled}}
              @isChecked={{this.isChecked}}
              @isReadOnly={{@isReadOnly}}
              @value={{@value}}
              @onChange={{@onChange}}
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
                  class="type-md-tight block leading-4
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
      </Field>
    </div>
  </template>
}
