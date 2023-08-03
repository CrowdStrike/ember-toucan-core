import Component from '@glimmer/component';
import { assert } from '@ember/debug';

export interface ToucanFormControlCharacterCountComponentSignature {
  Element: HTMLSpanElement;
  Args: {
    /**
     * The current number of characters inside the input
     */
    current: number;

    /**
     * The max amount allowed for this input
     */
    max: number;
  };
}

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ToucanFormControlCharacterCount extends Component<ToucanFormControlCharacterCountComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormControlCharacterCountComponentSignature['Args'],
  ) {
    assert(
      'An "@max" argument is required for Form::Controls::CharacterCount',
      args.max !== undefined,
    );
    assert(
      'An "@current" argument is required for Form::Controls::CharacterCount',
      args.current !== undefined,
    );
    super(owner, args);
  }

  /**
   * Determines if the current input length is greater than the provided
   * maximum length.  If so, a CSS class is applied.
   */
  get isCurrentGreaterThanMax() {
    return this.args.current > this.args.max;
  }

  <template>
    <span
      class="{{if this.isCurrentGreaterThanMax 'text-critical'}}"
      ...attributes
    >{{@current}}
      /
      {{@max}}</span>
  </template>
}
