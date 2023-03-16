import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

type FileTarget = EventTarget & { files?: FileList };
export type FileEvent = (Event | MouseEvent) & { target: FileTarget | null };

interface ToucanFormControlsFileInputComponentSignature {
  Element: HTMLInputElement;
  Args: {
    hasError?: boolean;
    trigger: string;
    isDisabled?: boolean;
    onChange?: (files: File[], event: FileEvent) => void;
  };
}

export default class ToucanFormControlsFileInputComponent extends Component<ToucanFormControlsFileInputComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormControlsFileInputComponentSignature['Args']
  ) {
    assert(
      'A "@trigger" argument is required for Form::Controls::FileInput. If using the Form::FileInputField, this should be provided automatically.',
      args.trigger !== undefined
    );

    super(owner, args);
  }

  @action
  onChange(event: FileEvent) {
    if (!event.target?.files) {
      return;
    }

    const files = [...event.target.files];

    if (this.args.onChange) {
      return this.args.onChange(files, event);
    }

    return;
  }
}
