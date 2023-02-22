import templateOnlyComponent from '@ember/component/template-only';

import type { ToucanFormTextareaControlArguments } from './controls/textarea';

export interface ToucanFormTextareaFieldComponentSignature {
  Element: HTMLTextAreaElement;
  Args: {
    error?: string;
    hint?: string;
    isDisabled?: boolean;
    label: string;
    onChange?: ToucanFormTextareaControlArguments['onChange'];
    value?: ToucanFormTextareaControlArguments['value'];
  };
}

export default templateOnlyComponent<ToucanFormTextareaFieldComponentSignature>();
