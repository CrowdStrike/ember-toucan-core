import templateOnlyComponent from '@ember/component/template-only';

export interface ToucanFormTextareaFieldComponentSignature {
  Element: HTMLTextAreaElement;
  Args: {
    error?: string;
    hint?: string;
    isDisabled?: boolean;
    label: string;
  };
  Blocks: {
    default: [];
  };
}

export default templateOnlyComponent<ToucanFormTextareaFieldComponentSignature>();
