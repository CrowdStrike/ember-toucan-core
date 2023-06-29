import templateOnlyComponent from '@ember/component/template-only';

export interface ToucanFormHintComponentSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Sets disabled styling on the hint.
     */
    isDisabled?: boolean;
  };
  Blocks: {
    default: [];
  };
}

export default templateOnlyComponent<ToucanFormHintComponentSignature>();
