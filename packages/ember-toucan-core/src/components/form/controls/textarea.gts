import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

export interface ToucanFormTextareaControlComponentSignature {
  Element: HTMLTextAreaElement;
  Args: {
    /**
     * Sets the textarea to an errored-state via styling.
     */
    hasError?: boolean;

    /**
     * Sets the disabled attribute of the textarea.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the textarea.
     */
    isReadOnly?: boolean;

    /**
     * The function called when the element is typed into.
     */
    onChange?: OnChangeCallback<string>;

    /**
     * Sets the value attribute of the textarea.
     */
    value?: string;
  };
}

export default class ToucanFormTextareaControlComponent extends Component<ToucanFormTextareaControlComponentSignature> {
  get styles() {
    let { isDisabled, isReadOnly, hasError } = this.args;

    if (isDisabled) {
      return 'shadow-focusable-outline bg-overlay-1 text-disabled';
    }

    if (isReadOnly) {
      return 'focus-within:shadow-focus-outline bg-surface-xl shadow-read-only-outline text-titles-and-attributes';
    }

    if (hasError) {
      return 'shadow-error-outline focus-within:shadow-error-focus-outline bg-overlay-1 text-titles-and-attributes';
    }

    return 'shadow-focusable-outline focus-within:shadow-focus-outline bg-overlay-1 text-titles-and-attributes';
  }

  @action
  handleInput(e: Event | InputEvent): void {
    assert(
      'Expected HTMLTextAreaElement',
      e.target instanceof HTMLTextAreaElement,
    );

    this.args.onChange?.(e.target?.value, e);
  }

  <template>
    {{!
        A styled container div is used here so that we can give some space for
        the textarea resize handle and focus/error shadows.  Otherwise, the
        shadows / handle visually collides.
     }}
    <div
      class="{{this.styles}} w-full py-1 px-2 rounded-sm transition-shadow"
      data-container
    >
      <textarea
        class="min-h-6 focus:outline-none block h-20 bg-transparent w-full"
        disabled={{@isDisabled}}
        readonly={{@isReadOnly}}
        ...attributes
        {{on "input" this.handleInput}}
      >{{@value}}</textarea>
    </div>
  </template>
}
