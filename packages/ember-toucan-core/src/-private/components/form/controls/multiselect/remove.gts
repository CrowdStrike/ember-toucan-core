import Component from '@glimmer/component';
import { assert } from '@ember/debug';
import { on } from '@ember/modifier';

import Cross from '../../../../../-private/icons/cross';

interface ToucanCoreMultiselectRemoveComponentSignature {
  Args: {
    /**
     * Determines if the component should be displayed or not.  When the multiselect
     * is disabled or readonly, the remove button is not displayed.
     */
    isVisible?: boolean;

    /**
     * Maps to the `aria-label` attribute of the button. Used for screenreaders.
     */
    label?: string;

    /**
     * Event called when this button is clicked.
     */
    onClick: (event: MouseEvent) => void;

    /**
     * Event called when the mousedown event occurs.
     */
    onMouseDown: (event: MouseEvent) => void;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLButtonElement;
}

export default class ToucanCoreMultiselectRemoveComponent extends Component<ToucanCoreMultiselectRemoveComponentSignature> {
  Cross = Cross;

  constructor(
    owner: unknown,
    args: ToucanCoreMultiselectRemoveComponentSignature['Args'],
  ) {
    assert('The Remove component "@label" argument is required', args.label);
    super(owner, args);
  }

  <template>
    {{#if @isVisible}}
      {{! We have to use mousedown here to prevent default. Up does not work the same. }}
      {{!  template-lint-disable no-pointer-down-event-binding }}
      <button
        aria-label={{@label}}
        {{! TODO: remove reset-styles https://github.com/CrowdStrike/ember-oss-docs/issues/17 }}
        class="focusable reset-styles p-1"
        data-multiselect-remove-option
        type="button"
        {{on "click" @onClick}}
        {{on "mousedown" @onMouseDown}}
        ...attributes
      >
        <this.Cross />
      </button>
    {{/if}}
  </template>
}
