import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

import type { OnChangeCallback } from '../../../-private/types';

export interface ToucanFormCheckboxControlComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Sets the disabled attribute of the checkbox.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the checkbox.
     */
    isReadOnly?: boolean;

    /**
     * The function called when the checkbox is clicked.
     */
    onChange?: OnChangeCallback<boolean>;

    /**
     * Sets the checked state of the checkbox.
     */
    isChecked?: boolean;

    /**
     * Sets the indeterminate state of the checkbox.
     *
     * @see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#indeterminate_state_checkboxes
     */
    isIndeterminate?: boolean;

    /**
     * Sets the value attribute of the checkbox.
     */
    value?: string;
  };
}

export default class ToucanFormCheckboxControlComponent extends Component<ToucanFormCheckboxControlComponentSignature> {
  get isChecked() {
    return this.args.isChecked ?? false;
  }

  get isIndeterminate() {
    return this.args.isIndeterminate ?? false;
  }

  /**
   * Used in our template so we don't need to pull in ember-truth-helpers (yet).
   */
  get isCheckedOrIndeterminate() {
    return this.isChecked || this.isIndeterminate;
  }

  get styles() {
    let { isDisabled, isReadOnly } = this.args;
    let isCheckedOrIndeterminate = this.isCheckedOrIndeterminate;

    if (isCheckedOrIndeterminate && !isDisabled && !isReadOnly) {
      return ['bg-primary-idle border-none'];
    }

    if (isCheckedOrIndeterminate && isDisabled && !isReadOnly) {
      return ['bg-disabled border-none'];
    }

    if (isCheckedOrIndeterminate && isReadOnly) {
      return ['bg-titles-and-attributes border-none'];
    }

    if (!isCheckedOrIndeterminate && isDisabled && !isReadOnly) {
      return ['bg-transparent border-disabled'];
    }

    if (!isCheckedOrIndeterminate && isReadOnly) {
      return ['bg-surface-xl'];
    }

    return ['bg-normal-idle'];
  }

  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    this.args.onChange?.(e.target.checked, e);
  }

  <template>
    <div
      class="min-w-4 min-h-4 relative flex h-4 w-4 items-center justify-center"
    >
      <input
        class="border-body-and-labels focusable-outer focus:outline-none inline-block h-4 w-4 transform-gpu appearance-none rounded-sm border p-0 align-middle focus-visible:scale-75
          {{this.styles}}"
        type="checkbox"
        checked={{this.isChecked}}
        indeterminate={{this.isIndeterminate}}
        disabled={{@isDisabled}}
        readonly={{@isReadOnly}}
        value={{@value}}
        ...attributes
        {{on "click" this.handleInput}}
      />

      {{#if this.isCheckedOrIndeterminate}}
        <div class="pointer-events-none absolute">
          {{#if this.isIndeterminate}}
            <svg
              aria-hidden="true"
              class="text-ground-floor"
              width="12"
              height="12"
              viewBox="0 0 12 12"
              fill="currentColor"
            ><path d="M10 5v2H2V5h8Z" /></svg>
          {{else}}
            <svg
              aria-hidden="true"
              class="text-ground-floor h-3 w-3"
              width="12"
              height="12"
              viewBox="0 0 12 12"
              fill="currentColor"
            ><path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M10.207 4.207 5 9.414 2.293 6.707l1.414-1.414L5 6.586l3.793-3.793 1.414 1.414Z"
              /></svg>
          {{/if}}
        </div>
      {{/if}}
    </div>
  </template>
}
