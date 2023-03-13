import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

// what onChange actually returns
type FileTarget = EventTarget & { files?: FileList };
export type FileEvent = (Event | MouseEvent) & { target: FileTarget | null };

/** Change events return a files key which has a value of FileList
 * however, FileList is potentially getting deprecated, also it's
 * easier to work with an Array of files (File[])
 *
 * This is a convenience method for converting an array of Files (File[]) to a FileList
 *
 * To convert a FileList to an array of Files (File[]) just use the spread operator
 * @example
 * const files = [...event.target.files]
 *
 *
 * @description converts a list of File objects (File[]) to a FileList
 * @param {list: File[]}: an array of Files
 * @returns FileList
 **/
function convertFilesToFileList(list: File[]) {
  const result = new FileList();

  for (let i = 0; i < list.length; i++) {
    result[i] = list[i] as File;
  }

  return result;
}

interface ToucanFormFileInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    accept?: string;
    error?: string;
    files?: File[];
    hint?: string;
    label: string;
    isDisabled?: boolean;
    multiple?: boolean;
    onChange: (event: FileEvent) => void;
    onDeleteFile?: (file: File) => void;
    rootTestSelector?: string;
  };
  Blocks: {
    triggerText: [];
  };
}

export default class ToucanFormFileInputFieldComponent extends Component<ToucanFormFileInputFieldComponentSignature> {
  @tracked files: File[] = [];

  constructor(
    owner: unknown,
    args: ToucanFormFileInputFieldComponentSignature['Args']
  ) {
    assert(
      'A "@label" argument is required for FileInputField',
      args.label !== undefined
    );

    assert(
      'An "@onChange" argument is required for FileInputField',
      args.onChange !== undefined
    );
    super(owner, args);
  }

  get accept() {
    return this.args.accept ?? '*';
  }

  get multiple() {
    return this.args.multiple ?? true;
  }

  formatSize(size: number) {
    return `${Math.round(size / 1000)} KB`;
  }

  @action
  deleteFile(file: File, event: FileEvent) {
    const files: File[] | [] =
      this.args.files?.filter((currentFile) => currentFile !== file) ?? [];

    const currentEvent = { ...event };

    if (currentEvent.target) {
      currentEvent.target.files = convertFilesToFileList(files);
    } else {
      const target: FileTarget = {
        ...new EventTarget(),
        files: new FileList(),
      };

      currentEvent.target = target;
      currentEvent.target.files = convertFilesToFileList(files);
    }

    return this.args.onChange?.(currentEvent);
  }
}
