import Component from '@glimmer/component';
import { hash } from '@ember/helper';

import Control from '../../-private/components/control';
import Error from '../../-private/components/error';
import Hint from '../../-private/components/hint';
import Label from '../../-private/components/label';
import { uniqueId } from '../../-private/utils';

interface ToucanFormFieldComponentSignature {
  Element: null;
  Args: {};
  Blocks: {
    default: [
      {
        /**
         * ID to link the Label and underlying control element for screenreaders.
         *
         * - Provide this to the `id` attribute on the control element.
         * - Provide this to the `for` attribute on the Label component.
         */
        id: string;

        /**
         * A provided ID for element descriptors. Normally used to link the
         * hint section with the control so that it is read by screenreaders.
         *
         * - Provide this to the `id` attribute on the Hint component.
         * - Add this to the `aria-describedby` of the control element.
         */
        hintId: string;

        /**
         * A provided ID for element descriptors. Normally used to link the
         * error section with the control so that it is read by screenreaders.
         *
         * - Provide this to the `id` attribute on the Error component.
         * - Add this to the `aria-describedby` or `aria-errormessage` of the control element.
         */
        errorId: string;

        /**
         * Renders a Toucan-styled label tag.
         */
        Label: typeof Label;

        /**
         * Renders a Toucan-styled hint block.
         */
        Hint: typeof Hint;

        /**
         * A wrapping element to provide a control, meaning whatever element
         * the user interacts with.  This is normally an underlying input, textarea,
         * or other common form element.
         */
        Control: typeof Control;

        /**
         * Renders a Toucan-styled error block.
         */
        Error: typeof Error;
      },
    ];
  };
}

export default class ToucanFormFieldComponent extends Component<ToucanFormFieldComponentSignature> {
  Label = Label;
  Hint = Hint;
  Control = Control;
  Error = Error;

  <template>
    {{#let (uniqueId) (uniqueId) (uniqueId) as |id hintId errorId|}}
      {{yield
        (hash
          Label=this.Label
          Hint=this.Hint
          Control=this.Control
          Error=this.Error
          id=id
          hintId=hintId
          errorId=errorId
        )
      }}
    {{/let}}
  </template>
}
