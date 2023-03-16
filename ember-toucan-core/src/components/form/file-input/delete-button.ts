import Component from '@glimmer/component';

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
    super(owner, args);
  }
}
