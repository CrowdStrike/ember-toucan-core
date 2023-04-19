import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import type { ErrorMessage } from '../../-private/types';

export interface ToucanFormErrorComponentSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Provide a string or array of strings to this argument to render styled errors.
     */
    error?: ErrorMessage;

    /**
     * To render the component inline, removes flex
     */
    isInline?: boolean;
  };
  Blocks: {};
}

export default class ToucanFormErrorComponent extends Component<ToucanFormErrorComponentSignature> {
  /**
   * Used to help us determine if we should render a single error
   * or render a ul list of errors.
   */
  get hasMoreThanOneError() {
    return Array.isArray(this.args.error) && this.args.error?.length > 1;
  }

  /**
   * workaround for not having (and ...) or (or ...)
   */
  get hasMoreThanOneErrorAndIsInline() {
    return this.hasMoreThanOneError && this.args.isInline;
  }

  get hasSingleErrorAndIsInline() {
    return !this.hasMoreThanOneError && this.args.isInline;
  }
  /**
   * workaround for not having (and ...) or (or ...)
   */
  get hasMoreThanOneErrorAndNotInline() {
    return this.hasMoreThanOneError && !this.args.isInline;
  }

  /**
   * workaround for not having (and ...) or (or ...)
   */
  get hasSingleErrorAndNotInline() {
    return !this.hasMoreThanOneError && !this.args.isInline;
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
