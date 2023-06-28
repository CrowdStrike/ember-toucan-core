import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

import Check from '../../../../../-private/icons/check';

// TODO: Should the directory structure of `-private` mirror the directory structure of the related component?
// Or should we simply put this subcomponent on the top level of `-private`?

interface ToucanFormSelectOptionControlComponentSignature {
  Args: {
    activeOption: { label: string; value: string } | null;
    label: string;
    onClick: (value: string) => void;
    onMouseover: (value: string) => void;
    selectedOptions: { label: string; value: string }[];
    value: string;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLInputElement;
}

const className = 'toucan-form-select-option-control';

export const selector = `.${className}`;

export default class ToucanFormSelectOptionControlComponent extends Component<ToucanFormSelectOptionControlComponentSignature> {
  @tracked isPopoverOpen = false;

  className = className;
  Check = Check;

  get isActive() {
    return this.args.value === this.args.activeOption?.value;
  }

  get isSelected() {
    return this.args.selectedOptions.some(
      (option) => option.value === this.args.value
    );
  }

  get styles() {
    if (this.isActive) {
      return 'bg-overlay-1 text-body-and-labels';
    }

    if (this.isSelected) {
      return 'bg-selected';
    }

    return '';
  }

  @action
  onClick(value: string, event: Event) {
    // Both "click" and "mousedown" steal focus, which we want to remain on the input.
    event.preventDefault();

    this.args.onClick(value);
  }

  @action
  onMousedown(event: Event) {
    // Both "click" and "mousedown" steal focus, which we want to remain on the input.
    event.preventDefault();
  }
}
