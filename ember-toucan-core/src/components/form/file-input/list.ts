import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import ListItem from './list-item';

import type { onDeleteFileHandler } from './field';
import type { WithBoundArgs } from '@glint/template';

interface ToucanFormFileInputListComponentSignature {
  Element: HTMLInputElement;
  Args: {
    files: File[];
    onDelete: onDeleteFileHandler;
    deleteLabel: string;
  };
  Blocks: {
    default: [
      {
        ListItem: WithBoundArgs<
          typeof ListItem,
          'file' | 'onDelete' | 'deleteLabel'
        >;
      }
    ];
  };
}

export default class ToucanFormFileInputListComponent extends Component<ToucanFormFileInputListComponentSignature> {
  ListItem = ListItem;
  constructor(
    owner: unknown,
    args: ToucanFormFileInputListComponentSignature['Args']
  ) {
    assert(
      'An "@onDelete" argument is required for Form::FileInput::List inside of Form::FileInput::Field',
      args.onDelete !== undefined
    );
    super(owner, args);
  }

  formatSize(size: number) {
    return `${Math.round(size / 1000)} KB`;
  }
}
