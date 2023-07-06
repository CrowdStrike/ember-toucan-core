import Component from '@glimmer/component';
import { action } from '@ember/object';

import Check from '../../../../../-private/icons/check';

interface ToucanFormSelectOptionControlComponentSignature {
  Args: {
    isActive?: boolean;
    isDisabled?: boolean;
    isReadOnly?: boolean;
    isSelected?: boolean;
    index: number;
    onClick: () => void;
    onMouseover: () => void;
    popoverId: string;
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
      return 'bg-overlay-1 text-titles-and-attributes';
    }

    if (this.args.isSelected) {
      return 'bg-selected text-titles-and-attributes';
    }

    return 'text-body-and-labels';
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
