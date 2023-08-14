import { PageObject } from 'fractal-page-object';

export class AutocompletePageObject extends PageObject {
  get active() {
    return this.element
      ?.closest('[data-autocomplete]')
      ?.querySelector('[aria-current="true"]');
  }

  get list() {
    return this.element
      ?.closest('[data-autocomplete]')
      ?.querySelector('[role="listbox"]');
  }

  get options() {
    return this.element
      ?.closest('[data-autocomplete]')
      ?.querySelectorAll('[role="option"]');
  }

  get selected() {
    return this.element
      ?.closest('[data-autocomplete]')
      ?.querySelector('[aria-selected="true"]');
  }

  get status() {
    return this.element
      ?.closest('[data-autocomplete]')
      ?.querySelector('[role="status"]');
  }
}
