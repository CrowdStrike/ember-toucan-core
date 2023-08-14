import { click } from '@ember/test-helpers';

import { PageObject } from 'fractal-page-object';

export class ButtonPageObject extends PageObject {
  async click() {
    if (this.element) {
      await click(this.element);
    }
  }

  get isLoading() {
    return Boolean(this.element?.querySelector('[data-loading]'));
  }

  get isDisabled() {
    return Boolean(this.element?.hasAttribute('aria-disabled'));
  }

  get text() {
    return this.element?.textContent?.trim();
  }
}
