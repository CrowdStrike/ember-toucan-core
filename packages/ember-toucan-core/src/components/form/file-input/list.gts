import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { hash } from '@ember/helper';

import ListItem from './list-item';

import type { onDeleteFileHandler } from './delete-button';
import type { WithBoundArgs } from '@glint/template';

interface ToucanFormFileInputListComponentSignature {
  Element: HTMLUListElement;
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
        file: File;
      },
    ];
  };
}

export default class ToucanFormFileInputListComponent extends Component<ToucanFormFileInputListComponentSignature> {
  ListItem = ListItem;
  constructor(
    owner: unknown,
    args: ToucanFormFileInputListComponentSignature['Args'],
  ) {
    assert(
      'An "@onDelete" argument is required for Form::FileInput::List. If using the Form::Fields::FileInput, this should be provided automatically.',
      args.onDelete !== undefined,
    );
    assert(
      'An "@files" argument is required for Form::FileInput::List. If using the Form::Fields::FileInput, this should be provided automatically.',
      args.files !== undefined,
    );

    assert(
      'An "@deleteLabel" argument is required for Form::FileInput::List. If using the Form::Fields::FileInput, this should be provided automatically.',
      args.deleteLabel !== undefined,
    );

    super(owner, args);
  }

  formatSize(size: number) {
    return `${Math.round(size / 1000)} KB`;
  }

  <template>
    <ul class="m-0 list-none space-y-1.5 p-0" data-files ...attributes>
      {{#each @files as |file|}}
        {{#if (has-block)}}
          {{yield
            (hash
              ListItem=(component
                this.ListItem
                file=file
                onDelete=@onDelete
                deleteLabel=@deleteLabel
              )
              file=file
            )
          }}
        {{else}}
          <this.ListItem
            @file={{file}}
            @onDelete={{@onDelete}}
            @deleteLabel={{@deleteLabel}}
          />
        {{/if}}
      {{/each}}
    </ul>
  </template>
}
