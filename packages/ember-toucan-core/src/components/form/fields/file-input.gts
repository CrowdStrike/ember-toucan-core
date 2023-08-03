import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { fn, hash } from '@ember/helper';
import { action } from '@ember/object';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/icons/lock';
import Button from '../../button';
import FileInput from '../controls/file-input';
import Field from '../field';
import FileList from '../file-input/list';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type {
  FileEvent as FileInputFileEvent,
  ToucanFormControlsFileInputComponentSignature,
} from '../controls/file-input';

export type FileEvent = FileInputFileEvent;

export interface ToucanFormFileInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * A comma separated list of file types
     * @example: `@accept="video/*"`
     * @example: `@accept="image/png, image/jpeg"`
     */
    accept?: string;

    /**
     * The delete button a11y text.
     */
    deleteLabel: string;

    /**
     * The error message for the file input field. Linked to the input with aria-describedby.
     */
    error?: ErrorMessage;

    /**
     * This array is created automatically when a user uploads files.
     * Note that this is not a FileList object, but an array of File objects. This is for convenience as FileList does not have common array methods like filter.
     */
    files?: File[];

    /**
     * Render a hint message to help describe the control. Linked to the input with aria-describedby.
     */
    hint?: string;

    /**
     * Renders inside the link tag.
     */
    label?: string;

    /**
     * Used to replace the "Select Files" text, and used for internationalization purposes.
     */
    trigger: string;

    /**
     * Sets the disabled attribute on the fieldset.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the checkbox.
     */
    isReadOnly?: boolean;

    /**
     * Sets the multiple attribute on the file input.
     * If not set, defaults no multiple attribute. In this case (single file upload) a file upload will REPLACE any existing file that is in the files array.
     * If set as multiple file upload, new files are adding to the existing files array.
     */
    multiple?: boolean;

    /**
     * A callback to be notified when files change.
     */
    onChange?: ToucanFormControlsFileInputComponentSignature['Args']['onChange'];

    /**
     * Used for an alternate named test rootTestSelector.
     */
    rootTestSelector?: string;
  };
  Blocks: {
    label: [];
    hint: [];
  };
}

export default class ToucanFormFileInputFieldComponent extends Component<ToucanFormFileInputFieldComponentSignature> {
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
    args: ToucanFormFileInputFieldComponentSignature['Args'],
  ) {
    assert(
      'A "@deleteLabel" argument is required for Form::FileInput::Field. This provides an accessible label for the delete button.',
      args.deleteLabel !== undefined,
    );

    assert(
      'A "@trigger" argument is required for FileInputField, this prompts the user to select files',
      args.trigger !== undefined,
    );

    super(owner, args);
  }

  get hasError() {
    return Boolean(this.args?.error);
  }

  get isReadOnlyOrDisabled() {
    return this.args?.isDisabled || this.args?.isReadOnly;
  }

  @action
  handleChange(field: { id: string }) {
    if (this.args.isReadOnly) {
      return;
    }

    const input = document.getElementById(`${field.id}`);

    // https://developer.mozilla.org/en-US/docs/Web/API/File_API/Using_files_from_web_applications#using_hidden_file_input_elements_using_the_click_method
    input?.click();
  }

  @action
  handleDelete(file: File, event: Event | InputEvent) {
    if (!this.args.files) {
      // unlikely to happen since having a list of files is
      // associated with a visible delete button, but to satisfy typescript
      return;
    }

    const files = [...this.args.files].filter(
      (currentFile) => currentFile !== file,
    );

    if (this.args.onChange) {
      this.args.onChange(files, event);
    }
  }

  <template>
    <div
      class="inline-flex w-full flex-col {{if @isDisabled 'text-disabled'}}"
      data-root-field={{if @rootTestSelector @rootTestSelector}}
    >
      <Field as |field|>
        <field.Label for={{field.id}} @isDisabled={{@isDisabled}}>
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
            <span class="flex items-center gap-1.5" data-label>
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

          <field.Control class="mt-1.5">
            <FileInput
              aria-describedby={{if this.hasError field.errorId}}
              aria-invalid={{if this.hasError "true"}}
              class="sr-only"
              id={{field.id}}
              @accept={{@accept}}
              @files={{@files}}
              @hasError={{this.hasError}}
              @multiple={{@multiple}}
              @onChange={{@onChange}}
              @trigger={{@trigger}}
              @isDisabled={{@isDisabled}}
              @isReadOnly={{@isReadOnly}}
              ...attributes
            />

            <Button
              class="{{if
                  @isReadOnly
                  'shadow-read-only-outline bg-surface-xl'
                }}"
              @variant="secondary"
              @onClick={{(fn this.handleChange field)}}
              @isDisabled={{@isDisabled}}
            >
              <span data-trigger>{{@trigger}}</span>

              {{#if this.isReadOnlyOrDisabled}}
                <this.LockIcon class="{{if @isReadOnly 'ml-2'}}" />
              {{else}}
                <svg
                  aria-hidden="true"
                  class="ml-2"
                  width="16"
                  height="16"
                  viewBox="0 0 16 16"
                  fill="currentColor"
                  data-upload-icon
                >
                  <g>
                    <path
                      fill-rule="evenodd"
                      clip-rule="evenodd"
                      d="M2 10v2.5A1.5 1.5 0 0 0 3.5 14h9a1.5 1.5 0 0 0 1.5-1.5V10h1v2.5a2.5 2.5 0 0 1-2.5 2.5h-9A2.5 2.5 0 0 1 1 12.5V10h1Z"
                    />
                    <path
                      d="M8 10.707a.5.5 0 0 1-.5-.5V2.414L4.854 5.061a.5.5 0 1 1-.708-.707L8 .5l3.854 3.854a.5.5 0 0 1-.708.707L8.5 2.414v7.793a.5.5 0 0 1-.5.5Z"
                    />
                  </g>
                </svg>
              {{/if}}
            </Button>
          </field.Control>
        </field.Label>

        {{#if @error}}
          <field.Error id={{field.errorId}} @error={{@error}} data-error />
        {{/if}}

        {{#if @files.length}}
          <FileList
            @files={{@files}}
            @onDelete={{this.handleDelete}}
            @deleteLabel={{@deleteLabel}}
            class="mt-1.5"
          />
        {{/if}}
      </Field>
    </div>
  </template>
}
