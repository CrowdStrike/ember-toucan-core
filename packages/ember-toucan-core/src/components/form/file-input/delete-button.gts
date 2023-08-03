import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';

export type onDeleteFileHandler = (
  file: File,
  event: Event | InputEvent,
) => void;

interface ToucanFormFileInputDeleteButtonComponentSignature {
  Element: HTMLButtonElement;
  Args: {
    /**
     * The current file associated with this delete button.
     */
    file: File;

    /**
     * Called when the delete button is pressed.
     */
    onDelete: onDeleteFileHandler;

    /**
     * The label for the delete button.
     */
    deleteLabel: string;
  };
}

export default class ToucanFormFileInputDeleteButtonComponent extends Component<ToucanFormFileInputDeleteButtonComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormFileInputDeleteButtonComponentSignature['Args'],
  ) {
    assert(
      'A "@file" argument is required for Form::FileInput::DeleteButton. If using the Form::Fields::FileInput this should be provided automatically.',
      args.file !== undefined,
    );

    assert(
      'A "@onDelete" argument is required for Form::FileInput::DeleteButton. If using the Form::Fields::FileInput this should be provided automatically.',
      args.onDelete !== undefined,
    );

    assert(
      'A "@deleteLabel" argument is required for Form::FileInput::DeleteButton. If using the Form::Fields::FileInput this should be provided automatically.',
      args.deleteLabel !== undefined,
    );

    super(owner, args);
  }

  <template>
    <button
      aria-label={{@deleteLabel}}
      {{! TODO: remove reset-styles https://github.com/CrowdStrike/ember-oss-docs/issues/17 }}
      class="reset-styles focusable focus:interactive-normal hover:interactive-normal rounded-sm transition"
      type="button"
      {{on "click" (fn @onDelete @file)}}
      data-delete-file
      ...attributes
    >
      <svg
        aria-hidden="true"
        class="text-text-and-icons"
        width="16"
        height="16"
        viewBox="0 0 16 16"
        fill="currentColor"
      ><g fill-rule="evenodd" clip-rule="evenodd"><path
            d="M2 3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1V13a1.5 1.5 0 0 1-1.5 1.5H4A1.5 1.5 0 0 1 2.5 13V3.5A.5.5 0 0 1 2 3Zm1.5.5V13a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5V3.5h-9Z"
          /><path
            d="M6 11.5v-6h1v6H6Zm3 0v-6h1v6H9ZM8 1a1.5 1.5 0 0 0-1.5 1.5h-1a2.5 2.5 0 0 1 5 0h-1A1.5 1.5 0 0 0 8 1Z"
          /></g></svg>
    </button>
  </template>
}
