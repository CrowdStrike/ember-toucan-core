import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

import Check from '../../../../../-private/icons/check';

interface ToucanCoreAutocompleteOptionComponentSignature {
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

export default class ToucanCoreAutocompleteOptionComponent extends Component<ToucanCoreAutocompleteOptionComponentSignature> {
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

  <template>
    {{! template-lint-disable require-presentational-children }}
    <li
      aria-selected={{if @isSelected "true" "false"}}
      class="my-0 flex cursor-default items-center gap-2 px-2 py-2 leading-4
        {{this.styles}}
        {{this.className}}
        "
      data-active={{if @isActive "true" "false"}}
      id="{{@popoverId}}-{{@index}}"
      role="option"
      {{on "click" this.onClick}}
      {{! template-lint-disable no-pointer-down-event-binding }}
      {{on "mousedown" this.onMousedown}}
      {{on "mouseover" @onMouseover}}
      ...attributes
    >
      <this.Check aria-hidden="true" class={{unless @isSelected "invisible"}} />
      {{yield}}

      {{! TODO: Do we make \`@value\` required? }}
      {{!
      We'll need Form::Controls::Select to work with real forms and the native \`FormData\` API.
      That means it'll need to be backed by a real INPUT. Screenreaders already have all the information
      they need, which means the INPUT is superfluous and is thus noise?
  }}
      {{! template-lint-disable no-nested-interactive }}
      {{! template-lint-disable require-input-label }}
      <input
        class="hidden"
        checked={{@isSelected}}
        disabled={{@isDisabled}}
        readonly={{@isReadOnly}}
        type="checkbox"
        value={{@value}}
      />
    </li>
  </template>
}
