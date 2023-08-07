import Component from '@glimmer/component';
import { hash } from '@ember/helper';
import { action } from '@ember/object';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/icons/lock';
import Field from '../field';
import CheckboxFieldComponent from './checkbox';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormCheckboxGroupFieldComponentSignature {
  Element: HTMLFieldSetElement;
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
     * Sets the disabled attribute on the fieldset.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the fieldset.
     */
    isReadOnly?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * Sets the name attribute of the checkboxes. A string specifying a name for the input control. This name is submitted along with the control's value when the form data is submitted.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#name
     */
    name: string;

    /**
     * The function called when a checkbox element is clicked.
     */
    onChange?: (selectedValues: Array<string>, e: Event | InputEvent) => void;

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * The currently selected checkbox elements. The elements with the matching `@value` / underlying value attribute will be checked.
     */
    value?: Array<string>;
  };
  Blocks: {
    default: [
      {
        CheckboxField: WithBoundArgs<
          typeof CheckboxFieldComponent,
          'isDisabled' | 'isReadOnly' | 'name' | 'onChange' | 'selectedValues'
        >;
      },
    ];
    label: [];
    hint: [];
  };
}

export default class ToucanFormCheckboxGroupFieldComponent extends Component<ToucanFormCheckboxGroupFieldComponentSignature> {
  CheckboxFieldComponent = CheckboxFieldComponent;
  LockIcon = LockIcon;

  assertBlockOrArgumentExists = ({
    blockExists,
    argName,
    arg,
    isRequired,
  }: AssertBlockOrArg) =>
    assertBlockOrArgumentExists({ blockExists, argName, arg, isRequired });

  get isReadOnlyOrDisabled() {
    return this.args?.isDisabled || this.args?.isReadOnly;
  }

  @action
  handleInput(_: boolean, e: Event | InputEvent): void {
    let value = this.args.value ? [...this.args.value] : [];

    let target = e.target as HTMLInputElement;

    if (value?.includes(target.value)) {
      value = value.filter((val) => val !== target.value);
    } else {
      value.push(target.value);
    }

    this.args.onChange?.(value, e);
  }

  <template>
    <Field as |field|>
      <fieldset
        aria-describedby="{{if @error field.errorId}} {{if @hint field.hintId}}"
        disabled={{@isDisabled}}
        data-root-field={{if @rootTestSelector @rootTestSelector}}
        ...attributes
      >
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
          <legend
            class="type-md-tight flex items-center gap-1.5
              {{if @isDisabled 'text-disabled' 'text-body-and-labels'}}"
            data-label
          >
            {{#if (has-block "label")}}
              {{yield to="label"}}
            {{else}}
              {{@label}}
            {{/if}}

            {{#if this.isReadOnlyOrDisabled}}
              <this.LockIcon />
            {{/if}}
          </legend>
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

        <field.Control
          class="mt-1.5 flex flex-col space-y-2 rounded-sm p-1
            {{if @error 'shadow-error-outline'}}"
          data-control
        >
          {{yield
            (hash
              CheckboxField=(component
                this.CheckboxFieldComponent
                name=@name
                onChange=this.handleInput
                isDisabled=@isDisabled
                isReadOnly=@isReadOnly
                selectedValues=@value
                isGrouped=true
              )
            )
          }}
        </field.Control>

        {{#if @error}}
          <field.Error id={{field.errorId}} @error={{@error}} data-error />
        {{/if}}
      </fieldset>
    </Field>
  </template>
}
