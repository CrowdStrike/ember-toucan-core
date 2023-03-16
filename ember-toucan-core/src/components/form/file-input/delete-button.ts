import Component from '@glimmer/component';

import type { onDeleteFileHandler } from './field';

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
    super(owner, args);
  }
}
