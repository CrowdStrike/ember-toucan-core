import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { hash } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/icons/lock';
import CharacterCount from '../../../components/form/controls/character-count';
import CoreTextarea from '../controls/textarea';
import Field from '../field';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type { ToucanFormTextareaControlComponentSignature } from '../controls/textarea';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormTextareaFieldComponentSignature {
  Element: HTMLTextAreaElement;
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
     * Sets the readonly attribute of the textarea.
     */
    isReadOnly?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * The function called when the element is typed into.
     */
    onChange?: ToucanFormTextareaControlComponentSignature['Args']['onChange'];

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * Sets the value attribute of the textarea.
     */
    value?: ToucanFormTextareaControlComponentSignature['Args']['value'];
  };
  Blocks: {
    label: [];
    hint: [];
    secondary: [
      {
        CharacterCount: WithBoundArgs<typeof CharacterCount, 'current'>;
      },
    ];
  };
}

export default class ToucanFormTextareaFieldComponent extends Component<ToucanFormTextareaFieldComponentSignature> {
  @tracked count = this.args.value?.length ?? 0;

  CharacterCount = CharacterCount;
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
    args: ToucanFormTextareaFieldComponentSignature['Args'],
  ) {
    super(owner, args);
  }

  get hasError() {
    return Boolean(this.args?.error);
  }

  get isReadOnlyOrDisabled() {
    return this.args?.isDisabled || this.args?.isReadOnly;
  }

  @action
  handleCount(event: Event | InputEvent): void {
    assert(
      'Expected HTMLTextAreaElement',
      event.target instanceof HTMLTextAreaElement,
    );
    this.count = event.target?.value.length ?? 0;
  }

  <template>
    <div
      class="flex flex-col"
      data-root-field={{if @rootTestSelector @rootTestSelector}}
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

        <field.Control class="mt-1.5">
          <CoreTextarea
            aria-invalid={{if @error "true"}}
            aria-describedby="{{if @error field.errorId}} {{if
              @hint
              field.hintId
            }}"
            class="w-full"
            id={{field.id}}
            @isDisabled={{@isDisabled}}
            @isReadOnly={{@isReadOnly}}
            @value={{@value}}
            @onChange={{@onChange}}
            @hasError={{this.hasError}}
            {{on "input" this.handleCount}}
            ...attributes
          />
        </field.Control>

        {{#if (has-block "secondary")}}
          <div class="flex justify-between">
            {{#if @error}}
              <field.Error
                class="flex-3"
                id={{field.errorId}}
                @error={{@error}}
                data-error
              />
            {{/if}}

            <div
              class="type-xs-tight text-body-and-labels mt-1.5 flex-1 text-right"
            >
              {{yield
                (hash
                  CharacterCount=(component
                    this.CharacterCount current=this.count
                  )
                )
                to="secondary"
              }}
            </div>
          </div>
        {{else if @error}}
          <field.Error id={{field.errorId}} @error={{@error}} data-error />
        {{/if}}
      </Field>
    </div>
  </template>
}
