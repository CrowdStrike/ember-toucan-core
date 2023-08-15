import { PageObject } from 'fractal-page-object';

export class MultiselectPageObject extends PageObject {
  get active() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelector('[aria-current="true"]');
  }

  get checkboxes() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelectorAll('[data-multiselect-checkbox]');
  }

  get chips() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelectorAll('[data-multiselect-chip]');
  }

  get container() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelector('[data-multiselect-container]');
  }

  get list() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelector('[role="listbox"]');
  }

  get options() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelectorAll('[role="option"]');
  }

  get removes() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelectorAll('[data-multiselect-remove-option]');
  }

  get selectAll() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelector('[data-multiselect-select-all]');
  }

  get selectAllCheckbox() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelector('[data-multiselect-select-all-checkbox]');
  }

  get selected() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelectorAll('[aria-selected="true"]');
  }

  get status() {
    return this.element
      ?.closest('[data-multiselect]')
      ?.querySelector('[role="status"]');
  }
}
