import Component from '@glimmer/component';

interface ToucanFormInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    label?: string;
    hint?: string;
    error?: string;
    isDisabled?: boolean;
    readonly?: boolean;
  };
  Blocks: {
    default: [];
  };
}

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ToucanFormInputFieldComponent extends Component<ToucanFormInputFieldComponentSignature> {}
