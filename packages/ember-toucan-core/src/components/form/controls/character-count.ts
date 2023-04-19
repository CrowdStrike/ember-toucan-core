import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';

export interface ToucanFormControlCharacterCountComponentSignature {
  Element: HTMLSpanElement;
  Args: {
    /**
     * The current number of characters inside the input
     */
    current?: number;

    /**
     * The max amount allowed for this input
     */
    max: number;
  };
}

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ToucanFormControlCharacterCount extends Component<ToucanFormControlCharacterCountComponentSignature> {
  @tracked current = this.args.current ?? 0;

  constructor(
    owner: unknown,
    args: ToucanFormControlCharacterCountComponentSignature['Args']
  ) {
    assert(
      'An "@max" argument is required for Form::Controls::CharacterCount',
      args.max !== undefined
    );
    // assert(
    //   'An "@current" argument is required for Form::Controls::CharacterCount',
    //   args.current !== undefined
    // );
    super(owner, args);
  }
}
