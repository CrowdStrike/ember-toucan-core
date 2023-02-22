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
    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;
    value?: ToucanFormTextareaControlArguments['value'];
  };
}

export default templateOnlyComponent<ToucanFormTextareaFieldComponentSignature>();
