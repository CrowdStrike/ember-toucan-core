import Component from '@glimmer/component';
import { action } from '@ember/object';

import Check from '../../../../../-private/icons/check';

interface ToucanFormAutocompleteOptionControlComponentSignature {
  Args: {
    /**
     * When true, means that the option is currently hovered over with a mouse
     * or "focused" with a keyboard.
     */
    isActive?: boolean;

    /**
     * Sets the underlying, hidden input element to disabled.
     */
    isDisabled?: boolean;

    /**
     * Sets the underlying, hidden input element to readonly.
     */
    isReadOnly?: boolean;

    /**
     * When set to true, the list item will have `aria-selected` set to true
     * and have selected styling.
     */
    isSelected?: boolean;

    /**
     * The index number of the list item when in a list.
     */
    index: number;

    /**
     * The event called when the item is clicked.
     */
    onClick: () => void;

    /**
     * The event called when the mouse rolls over the item.
     */
    onMouseover: () => void;

    /**
     * The `id` attribute of the popover this option is associated with.
     */
    popoverId: string;

    /**
     * Sets the underlying, hidden input element `value` attribute.
     */
    value?: string;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLLIElement;
}

const className = 'toucan-form-select-option-control';

export const selector = `.${className}`;

export default class ToucanFormAutocompleteOptionControlComponent extends Component<ToucanFormAutocompleteOptionControlComponentSignature> {
  className = className;
  Check = Check;

  get styles() {
    if (this.args.isActive) {
      return 'bg-overlay-1 text-titles-and-attributes';
    }

    if (this.args.isSelected) {
      return 'text-titles-and-attributes';
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
