import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import type { ErrorMessage } from '../../../-private/types';

type FileTarget = EventTarget & { files?: FileList };
export type FileEvent = (Event | MouseEvent) & { target: FileTarget | null };

interface ToucanFormFileInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    accept?: string;
    deleteLabel: string;
    error?: ErrorMessage;
    files?: File[];
    hint?: string;
    label: string;
    trigger: string;
    isDisabled?: boolean;
    multiple?: boolean;
    onChange?: (files: File[], event: FileEvent) => void;
    rootTestSelector?: string;
  };
}

export default class ToucanFormFileInputFieldComponent extends Component<ToucanFormFileInputFieldComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormFileInputFieldComponentSignature['Args']
  ) {
    assert(
      'A "@label" argument is required for Form::FileInput::Field',
      args.label !== undefined
    );

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
