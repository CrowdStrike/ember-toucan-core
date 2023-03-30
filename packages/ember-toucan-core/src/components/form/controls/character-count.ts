import Component from '@glimmer/component';
import { assert } from '@ember/debug';

export interface ToucanFormControlCharacterCountComponentSignature {
  Element: HTMLElement;
  Args: {
    /**
     * The current number of characters inside the input
     */
    current?: number;

    /**
     * The max amount allowed for this input
     */
    max?: number;
    id: string;
  };
}

export default class ToucanFormControlCharacterCount extends Component<ToucanFormControlCharacterCountComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormControlCharacterCountComponentSignature['Args']
  ) {
    assert('A "@id" argument is required', args.id);
    super(owner, args);
  }

  get initialCount() {
    // not sure why I need id.id here
    const id = this.args.id;
    const input = <HTMLInputElement>document.getElementById(id);

    if (input) {
      return input.value.length;
    }

    return 0;
  }

  get currentCount() {
    if (!this.args.current) return this.initialCount;

    return this.args.current;
  }
}
