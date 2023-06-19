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
    /**
     * Sets the readonly attribute of the checkbox.
     */
    isReadOnly?: boolean;
    onChange?: (files: File[] | [], event: FileEvent) => void;
    multiple?: boolean;
    files?: File[];
    accept?: string;
  };
}

export default class ToucanFormControlsFileInputComponent extends Component<ToucanFormControlsFileInputComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormControlsFileInputComponentSignature['Args']
  ) {
    assert(
      'A "@trigger" argument is required for Form::Controls::FileInput. If using the Form::Fields::FileInput, this should be provided automatically.',
      args.trigger !== undefined
    );

    super(owner, args);
  }

  get accept() {
    return this.args.accept ?? '*';
  }

  get multiple() {
    return this.args.multiple ? true : undefined;
  }

  @action
  onChange(event: FileEvent) {
    let files: File[] = [];

    if (!event.target?.files) {
      return;
    }

    if (this.args.multiple) {
      // add the files (FileList) from the event target to the existing files
      files = [...(this.args.files ?? []), ...event.target.files];
    } else {
      // replace with the single file from the event
      if (
        event.target.files.length > 0 &&
        typeof event.target.files[0] !== 'undefined'
      ) {
        files = [event.target.files[0]];
      } else {
        return;
      }
    }

    return this.args.onChange?.(files, event);
  }

  /**
   * As of 2023-06-15 on Chrome, when a file is selected in an input[type="file"]
   * field multiple times change events are not triggered on the input.
   *
   * To get around that, we need to clear the input's value before the user
   * selects the file again.
   *
   * This isn't a testable change because our test setup does not have high
   * level user interactions such as "select file". To test this manually
   * would require us to manually trigger the change event on the input field
   * with the selected file(s), but that would not have caught the issue
   * because we'd then need to *also* simulate the click event on the input
   * as well.
   *
   * - https://stackoverflow.com/questions/39484895/how-to-allow-input-type-file-to-select-the-same-file-in-react-component
   * - https://github.com/ngokevin/react-file-reader-input/issues/11#issuecomment-363484861
   */
  @action
  resetValue(event: Event) {
    (event.target as HTMLInputElement).value = '';
  }
}
