import Component from '@glimmer/component';
import { assert } from '@ember/debug';

export type onDeleteFileHandler = (
  file: File,
  event: Event | InputEvent
) => void;

interface ToucanFormFileInputDeleteButtonComponentSignature {
  Element: HTMLInputElement;
  Args: {
    file: File;
    onDelete: onDeleteFileHandler;
    deleteLabel: string;
  };
}

export default class ToucanFormFileInputDeleteButtonComponent extends Component<ToucanFormFileInputDeleteButtonComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormFileInputDeleteButtonComponentSignature['Args']
  ) {
    assert(
      'A "@file" argument is required for Form::FileInput::DeleteButton. If using the Form::FileInputField this should be provided automatically.',
      args.file !== undefined
    );

    assert(
      'A "@onDelete" argument is required for Form::FileInput::DeleteButton. If using the Form::FileInputField this should be provided automatically.',
      args.onDelete !== undefined
    );

    assert(
      'A "@deleteLabel" argument is required for Form::FileInput::DeleteButton. If using the Form::FileInputField this should be provided automatically.',
      args.deleteLabel !== undefined
    );

    super(owner, args);
  }
}
