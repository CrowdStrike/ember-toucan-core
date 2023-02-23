import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ToucanFormTextareaControlComponentSignature } from './controls/textarea';

export interface ToucanFormTextareaFieldComponentSignature {
  Element: HTMLTextAreaElement;
  Args: {
    error?: string;
    hint?: string;
    isDisabled?: boolean;
    label: string;
    onChange?: ToucanFormTextareaControlComponentSignature['Args']['onChange'];
    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;
    value?: ToucanFormTextareaControlComponentSignature['Args']['value'];
  };
}

export default class ToucanFormTextareaFieldComponent extends Component<ToucanFormTextareaFieldComponentSignature> {
  constructor(
    owner: unknown,
    args: ToucanFormTextareaFieldComponentSignature['Args']
  ) {
    assert('A "@label" argument is required', args.label);
    super(owner, args);
  }

  get hasError() {
    return Boolean(this.args?.error);
  }
}
