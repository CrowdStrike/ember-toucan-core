import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ErrorMessage } from '../../-private/types';

export interface ToucanFormInlineErrorComponentSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Provide a string or array of strings to this argument to render styled errors.
     */
    error?: ErrorMessage;
  };
  Blocks: {};
}

export default class ToucanFormInlineErrorComponent extends Component<ToucanFormInlineErrorComponentSignature> {
  /**
   * Used to help us determine if we should render a single error
   * or render a ul list of errors.
   */
  get hasMoreThanOneError() {
    return Array.isArray(this.args.error) && this.args.error?.length > 1;
  }

  get errors(): Array<string> {
    let { error } = this.args;

    assert(
      '"@error" must be either a string or an array of strings',
      typeof error === 'string' || Array.isArray(error)
    );

    if (typeof error === 'string') {
      return [error];
    }

    return error;
  }
}
