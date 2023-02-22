import templateOnlyComponent from '@ember/component/template-only';

export interface ToucanFormTextareaFieldComponentSignature {
  Element: HTMLTextAreaElement;
  Args: {
    error?: string;
    hint?: string;
    isDisabled?: boolean;
    label: string;
  };
}

export default templateOnlyComponent<ToucanFormTextareaFieldComponentSignature>();
