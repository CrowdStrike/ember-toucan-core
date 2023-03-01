import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

export interface ToucanFormCheckboxControlComponentSignature {
  Element: HTMLInputElement;
  Args: {
    isDisabled?: boolean;
    onChange?: (
      isChecked: boolean,
      e: Event | InputEvent,
      isIndeterminate: boolean
    ) => void;
    isIndeterminate?: boolean;
    value?: boolean;
  };
}

export default class ToucanFormCheckboxControlComponent extends Component<ToucanFormCheckboxControlComponentSignature> {
  get isChecked() {
    return this.args.value ?? false;
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

  /**
   * We use the data-checked attribute to help signal what state the checkbox is in.
   * This is most helpful in tests. The "mixed" value is used for the indeterminate state.
   * We don't use aria-checked directly, as we are a valid <input type="checkbox", but
   * we follow the possible states outlined by aria-checked.
   *
   * @see https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-checked
   */
  get checkedState() {
    if (this.isIndeterminate) {
      return 'mixed';
    }

    if (this.isChecked) {
      return 'true';
    }

    return 'false';
  }

  get styles() {
    let { isDisabled } = this.args;
    let isCheckedOrIndeterminate = this.isCheckedOrIndeterminate;

    return isCheckedOrIndeterminate && !isDisabled
      ? ['bg-primary-idle border-none']
      : isCheckedOrIndeterminate && isDisabled
      ? ['bg-disabled border-none']
      : !isCheckedOrIndeterminate && isDisabled
      ? ['bg-transparent border-disabled']
      : ['bg-normal-idle'];
  }

  @action
  handleInput(e: Event | InputEvent): void {
    assert('Expected HTMLInputElement', e.target instanceof HTMLInputElement);

    this.args.onChange?.(e.target.checked, e, e.target.indeterminate);
  }
}
