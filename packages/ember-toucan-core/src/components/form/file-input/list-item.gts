import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import DeleteButton from './delete-button';

import type { onDeleteFileHandler } from './delete-button';

interface ToucanFormFileInputListItemComponentSignature {
  Element: HTMLLIElement;
  Args: {
    /**
     * The label for the delete button.
     */
    deleteLabel: string;

    /**
     * The current file associated with this delete button.
     */
    file: File;

    /**
     * Sets the element to an errored-state via styling.
     */
    hasError?: boolean;

    /**
     * Sets the disabled attribute on the element.
     */
    isDisabled?: boolean;

    /**
     * The event called when an item is deleted.
     */
    onDelete: onDeleteFileHandler;
  };
}

export default class ToucanFormFileInputListComponent extends Component<ToucanFormFileInputListItemComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormFileInputListItemComponentSignature['Args'],
  ) {
    assert(
      'An "@onDelete" argument is required for Form::FileInput::List. If using Form::Fields::FileInput, this should be provided automatically.',
      args.onDelete !== undefined,
    );

    assert(
      'An "@file" argument is required for Form::FileInput::List. If using Form::Fields::FileInput, this should be provided automatically.',
      args.file !== undefined,
    );

    assert(
      'An "@deleteLabel" argument is required for Form::FileInput::List. If using Form::Fields::FileInput, this should be provided automatically.',
      args.deleteLabel !== undefined,
    );
    super(owner, args);
  }

  formatSize(size: number) {
    return `${Math.round(size / 1000)} KB`;
  }

  <template>
    <li
      class="bg-overlay-1 focus:outline-none focus:shadow-focus-outline m-0 flex items-center justify-between rounded-sm px-2 py-1 transition-shadow
        {{if @isDisabled 'text-disabled' 'text-titles-and-attributes'}}
        {{if
          @hasError
          'shadow-error-outline focus:shadow-error-focus-outline'
          'shadow-focusable-outline'
        }}"
      ...attributes
    >
      {{! The \`pl-2\` added here is to offset the spacing added by the delete button below so that the horizontal axis spacing appears identical }}
      <div class="flex-1 py-1 pl-2">
        <p
          class="type-md-tight m-0 truncate p-0"
          data-file-name
        >{{@file.name}}</p>
        <span
          class="text-body-and-labels type-xs-tight mt-1 block"
          data-file-size
        >{{(this.formatSize @file.size)}}</span>
      </div>

      <DeleteButton
        class="p-2"
        @deleteLabel={{@deleteLabel}}
        @onDelete={{@onDelete}}
        @file={{@file}}
      />
    </li>
  </template>
}
