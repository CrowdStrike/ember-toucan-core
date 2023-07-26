import Component from '@glimmer/component';
import { assert } from '@ember/debug';

import Cross from '../../../../../-private/icons/cross';

interface ToucanFormMultiselectRemoveComponentSignature {
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

export default class ToucanFormMultiselectRemoveComponent extends Component<ToucanFormMultiselectRemoveComponentSignature> {
  Cross = Cross;

  constructor(
    owner: unknown,
    args: ToucanFormMultiselectRemoveComponentSignature['Args']
  ) {
    assert('The Remove component "@label" argument is required', args.label);
    super(owner, args);
  }
}
