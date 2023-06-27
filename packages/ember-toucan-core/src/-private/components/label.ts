import templateOnlyComponent from '@ember/component/template-only';

export interface ToucanFormLabelComponentSignature {
  Element: HTMLLabelElement;
  Args: {
    /**
     * Sets disabled styling on the label.
     */
    isDisabled?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export default templateOnlyComponent<ToucanFormLabelComponentSignature>();
