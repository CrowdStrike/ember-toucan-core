import Component from '@glimmer/component';

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
  };
}

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ToucanFormControlCharacterCount extends Component<ToucanFormControlCharacterCountComponentSignature> {}
