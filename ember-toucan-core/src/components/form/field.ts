import Component from '@glimmer/component';

import Control from '../../-private/components/control';
import Error from '../../-private/components/error';
import Hint from '../../-private/components/hint';
import Label from '../../-private/components/label';

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
        Label: typeof Label;
        Hint: typeof Hint;
        Control: typeof Control;
        Error: typeof Error;
      }
    ];
  };
}

export default class ToucanFormFieldComponent extends Component<ToucanFormFieldComponentSignature> {
  Label = Label;
  Hint = Hint;
  Control = Control;
  Error = Error;
}
