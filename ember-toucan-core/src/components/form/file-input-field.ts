import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

// Note, unlike other inputs the first parameter is not @value but @files
export type OnFileUploadChangeCallback = (
  files: FileList,
  e: Event | InputEvent
) => void;

interface ToucanFormFileInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    accept?: string;
    error?: string;
    files?: FileList;
    hint?: string;
    label: string;
    isDisabled?: boolean;
    multiple?: boolean;
    onChange?: OnFileUploadChangeCallback;
    rootTestSelector?: string;
  };
  Blocks: {
    triggerText: [];
  };
}

export default class ToucanFormFileInputFieldComponent extends Component<ToucanFormFileInputFieldComponentSignature> {
  @tracked files;

  constructor(
    owner: unknown,
    args: ToucanFormFileInputFieldComponentSignature['Args']
  ) {
    assert(
      'A "@label" argument is required for FileInputField',
      args.label !== undefined
    );
    super(owner, args);

    if (args.files) {
      this.files = args.files;
    }
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
  handleChange(event: Event | InputEvent): void {
    assert(
      'Expected HTMLInputElement',
      event.target instanceof HTMLInputElement
    );

    if (event.target.files) {
      this.files = event.target.files;

      return this.args.onChange?.(event.target.files, event);
    }

    return this.args.onChange?.(new FileList(), event);
  }
}
