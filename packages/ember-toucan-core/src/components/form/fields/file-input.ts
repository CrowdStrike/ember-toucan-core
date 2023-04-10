import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';

type FileTarget = EventTarget & { files?: FileList };
export type FileEvent = (Event | MouseEvent) & { target: FileTarget | null };

interface ToucanFormFileInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Provide a string to this argument, a comma separated list of file types
     * @example: `@accept="video/*"`
     * @example: `@accept="image/png, image/jpeg"`
     */
    accept?: string;
    /**
     * Provide a string to this argument for the delete button a11y text
     */
    deleteLabel: string;
    /**
     * Provide a string to this argument to render an error message and apply error styling to the Field.
     */
    error?: ErrorMessage;
    /**
     * Provide an array of File objects. This is handled automatically when a user uploads files.
     */
    files?: File[];
    /**
     * Provide a string to this argument to render a hint message to help describe the control.
     */
    hint?: string;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * Provide a string to this argument to replace the "Select Files" text. Used for internationalization purposes.
     */
    trigger: string;

    /**
     * Sets the disabled attribute on the fieldset.
     */
    isDisabled?: boolean;

    /**
     * Provide a boolean. Sets the multiple attribute on the file input.
     * If not set, defaults no multiple attribute. In this case (single file upload) a file upload will REPLACE any existing file that is in the file list.
     */
    multiple?: boolean;

    /**
      * Provide a callback to add additional functionality when files are added
    */
    onChange?: (files: File[], event: FileEvent) => void;

    /**
      * Provide a string. Used for an alternate named test rootTestSelector
    */
    rootTestSelector?: string;
  };
  Blocks: {
    label: [];
    hint: [];
  };
}

export default class ToucanFormFileInputFieldComponent extends Component<ToucanFormFileInputFieldComponentSignature> {
  assertBlockOrArgumentExists = ({
    blockExists,
    argName,
    arg,
    isRequired,
  }: AssertBlockOrArg) =>
    assertBlockOrArgumentExists({ blockExists, argName, arg, isRequired });

  constructor(
    owner: unknown,
    args: ToucanFormFileInputFieldComponentSignature['Args']
  ) {
    assert(
      'A "@deleteLabel" argument is required for Form::FileInput::Field. This provides an accessible label for the delete button.',
      args.deleteLabel !== undefined
    );

    assert(
      'A "@trigger" argument is required for FileInputField, this prompts the user to select files',
      args.trigger !== undefined
    );

    super(owner, args);
  }

  get hasError() {
    return Boolean(this.args?.error);
  }

  @action
  handleChange(field: { id: string }) {
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
      (currentFile) => currentFile !== file
    );

    if (this.args.onChange) {
      this.args.onChange(files, event);
    }
  }
}
