import Component from '@glimmer/component';
import { action } from '@ember/object';

type FileTarget = EventTarget & { files?: FileList };
export type FileEvent = (Event | MouseEvent) & { target: FileTarget | null };

interface ToucanFormControlsFileInputComponentSignature {
  Element: HTMLInputElement;
  Args: {
    accept?: string;
    error?: string;
    files?: File[];
    hint?: string;
    trigger: string;
    hasError?: boolean;
    isDisabled?: boolean;
    multiple?: boolean;
    onChange: (files: File[], event: FileEvent) => void;
    rootTestSelector?: string;
  };
}

export default class ToucanFormControlsFileInputComponent extends Component<ToucanFormControlsFileInputComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormControlsFileInputComponentSignature['Args']
  ) {
    super(owner, args);
  }

  get hasError() {
    return Boolean(this.args?.error);
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
