import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { onDeleteFileHandler } from './delete-button';

interface ToucanFormFileInputListItemComponentSignature {
  Element: HTMLInputElement;
  Args: {
    file: File;
    onDelete: onDeleteFileHandler;
    deleteLabel: string;
  };
}

export default class ToucanFormFileInputListComponent extends Component<ToucanFormFileInputListItemComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormFileInputListItemComponentSignature['Args']
  ) {
    assert(
      'An "@onDelete" argument is required for Form::FileInput::List inside of Form::FileInput::Field',
      args.onDelete !== undefined
    );

    assert(
      'An "@file" argument is required for Form::FileInput::List inside of Form::FileInput::Field',
      args.file !== undefined
    );

    assert(
      'An "@deleteLabel" argument is required for Form::FileInput::List inside of Form::FileInput::Field',
      args.deleteLabel !== undefined
    );

    super(owner, args);
  }

  formatSize(size: number) {
    return `${Math.round(size / 1000)} KB`;
  }
}
