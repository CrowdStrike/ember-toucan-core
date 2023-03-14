import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

type FileTarget = EventTarget & { files?: FileList };
export type FileEvent = (Event | MouseEvent) & { target: FileTarget | null };

interface ToucanFormFileInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    accept?: string;
    error?: string;
    files?: File[];
    hint?: string;
    label: string;
    trigger: string;
    isDisabled?: boolean;
    multiple?: boolean;
    onChange: (files: File[], event: FileEvent) => void;
    onDelete: (file: File, event: Event | InputEvent) => void;
    rootTestSelector?: string;
  };
}

export default class ToucanFormFileInputFieldComponent extends Component<ToucanFormFileInputFieldComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormFileInputFieldComponentSignature['Args']
  ) {
    assert(
      'A "@label" argument is required for FileInputField',
      args.label !== undefined
    );

    assert(
      'A "@trigger" argument is required for FileInputField, this prompts the user to select files',
      args.trigger !== undefined
    );

    assert(
      'An "@onChange" argument is required for FileInputField',
      args.onChange !== undefined
    );

    assert(
      'An "@onDelete" argument is required for FileInputField',
      args.onDelete !== undefined
    );

    super(owner, args);
  }

  get accept() {
    return this.args.accept ?? '*';
  }

  get multiple() {
    return this.args.multiple ?? true;
  }

  formatSize(size: number) {
    return `${Math.round(size / 1000)} KB`;
  }

  @action
  onChange(event: FileEvent) {
    if (event.target?.files) {
      const files = [...event.target.files];

      return this.args.onChange(files, event);
    }

    return this.args.onChange([], event);
  }
}
