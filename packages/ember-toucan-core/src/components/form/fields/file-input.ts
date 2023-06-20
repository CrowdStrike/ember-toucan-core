import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/components/lock-icon';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';

type FileTarget = EventTarget & { files?: FileList };
export type FileEvent = (Event | MouseEvent) & { target: FileTarget | null };

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
    onChange?: (files: File[], event: FileEvent) => void;

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
      (currentFile) => currentFile !== file
    );

    if (this.args.onChange) {
      this.args.onChange(files, event);
    }
  }
}
