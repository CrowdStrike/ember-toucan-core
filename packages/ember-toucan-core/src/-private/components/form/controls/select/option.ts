import Component from '@glimmer/component';
import { action } from '@ember/object';

import Check from '../../../../../-private/icons/check';

// TODO: Should the directory structure of `-private` mirror the directory structure of the related component?
// Or should we simply put this subcomponent on the top level of `-private`?

interface ToucanFormSelectOptionControlComponentSignature {
  Args: {
    isActive?: boolean;
    isDisabled?: boolean;
    isReadOnly?: boolean;
    isSelected?: boolean;
    onClick: () => void;
    onMouseover: () => void;
    value?: string;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLInputElement;
}

const className = 'toucan-form-select-option-control';

export const selector = `.${className}`;

export default class ToucanFormSelectOptionControlComponent extends Component<ToucanFormSelectOptionControlComponentSignature> {
  className = className;
  Check = Check;

  get styles() {
    if (this.args.isActive) {
      return 'bg-overlay-1 text-body-and-labels';
    }

    if (this.args.isSelected) {
      return 'bg-selected';
    }

    return '';
  }

  @action
  onClick(event: Event) {
    // Both "click" and "mousedown" steal focus, which we want to remain on the input.
    event.preventDefault();

    this.args.onClick();
  }

  @action
  onMousedown(event: Event) {
    // Both "click" and "mousedown" steal focus, which we want to remain on the input.
    event.preventDefault();
  }
}
