import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

import CheckboxControl from '../../../../../components/form/controls/checkbox';
import { uniqueId } from '../../../../utils';

interface ToucanCoreMultiselectOptionComponentSignature {
  Args: {
    /**
     * When true, means that the option is currently hovered over with a mouse
     * or "focused" with a keyboard.
     */
    isActive?: boolean;

    /**
     * Sets the underlying checkbox element to disabled.
     */
    isDisabled?: boolean;

    /**
     * Sets the underlying checkbox element to readonly.
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
     * Sets the underlying checkbox element `value` attribute.
     */
    value?: string;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLLIElement;
}

export const className = 'toucan-form-select-option-control';

export const selector = `.${className}`;

export default class ToucanCoreMultiselectControlComponent extends Component<ToucanCoreMultiselectOptionComponentSignature> {
  className = className;

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
    {{#let (uniqueId) as |id|}}
      <li
        aria-current={{if @isActive "true" "false"}}
        aria-selected={{if @isSelected "true" "false"}}
        class="my-0 flex cursor-default items-center gap-2 px-2 py-2 leading-4
          {{this.styles}}
          {{this.className}}
          "
        id="{{@popoverId}}-{{@index}}"
        role="option"
        {{on "click" this.onClick}}
        {{! template-lint-disable no-pointer-down-event-binding }}
        {{on "mousedown" this.onMousedown}}
        {{on "mouseover" @onMouseover}}
        ...attributes
      >
        {{!
        We set \`tabindex="-1"\` here to remove the checkbox from the tab order.
        Instead, we allow the user to use the keyboard arrows to "focus" and
        make options active.  If we remove this line, you'll notice that the
        focus returns to the body when tabbing out of the multiautocomplete
        component, which is a strange user experience.

        Template lint doesn't like us setting tabindex, but we need it here
        as we don't want these elements focusable!
    }}
        {{! template-lint-disable no-nested-interactive }}
        <CheckboxControl
          id={{id}}
          tabindex="-1"
          @isChecked={{@isSelected}}
          @isDisabled={{@isDisabled}}
          @isReadOnly={{@isReadOnly}}
          @value={{@value}}
          data-multiselect-checkbox
        />

        <span class="truncate">
          {{yield}}
        </span>
      </li>
    {{/let}}
  </template>
}
