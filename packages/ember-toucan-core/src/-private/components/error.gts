import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { get } from '@ember/helper';

import type { ErrorMessage } from '../../-private/types';

export interface ToucanCoreErrorComponentSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Provide a string or array of strings to this argument to render styled errors.
     */
    error?: ErrorMessage;
  };
  Blocks: {};
}

export default class ToucanCoreErrorComponent extends Component<ToucanCoreErrorComponentSignature> {
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
      typeof error === 'string' || Array.isArray(error),
    );

    if (typeof error === 'string') {
      return [error];
    }

    return error;
  }

  <template>
    <div
      class="type-xs-tight text-critical mt-1.5 flex
        {{if this.hasMoreThanOneError 'items-start' 'items-center'}}"
      ...attributes
    >
      <svg
        aria-hidden="true"
        class="mr-1"
        width="12"
        height="12"
        viewBox="0 0 12 12"
        fill="currentColor"
      >
        <path
          d="M6.02979 9.06006C6.58207 9.06006 7.02979 8.61234 7.02979 8.06006C7.02979 7.50777 6.58207 7.06006 6.02979 7.06006C5.4775 7.06006 5.02979 7.50777 5.02979 8.06006C5.02979 8.61234 5.4775 9.06006 6.02979 9.06006Z"
        />
        <path d="M5.52979 3.12H6.52979V6.12H5.52979V3.12Z" />
        <path
          fill-rule="evenodd"
          clip-rule="evenodd"
          d="M11.76 9.54L6.82003 0.48C6.47003 -0.16 5.42003 -0.16 5.07003 0.48L0.120026 9.54C-0.0499739 9.85 -0.0399739 10.22 0.140026 10.53C0.320026 10.84 0.640026 11.02 1.00003 11.02H10.89C11.25 11.02 11.57 10.84 11.75 10.53C11.93 10.22 11.94 9.85 11.77 9.54H11.76ZM1.00003 10.02L5.94003 0.96L10.88 10.02H1.00003Z"
        />
      </svg>

      {{#if this.hasMoreThanOneError}}
        <ul class="m-0 list-none space-y-1.5 p-0">
          {{#each this.errors as |error index|}}
            <li
              class="m-0 p-0 leading-3"
              data-error-item={{index}}
            >{{error}}</li>
          {{/each}}
        </ul>
      {{else}}
        <span>{{get this.errors 0}}</span>
      {{/if}}
    </div>
  </template>
}
