import Component from '@glimmer/component';

import Control from './control';
import Error from './error';
import Hint from './hint';
import Label from './label';

interface ToucanFormFieldComponentSignature {
  Element: null;
  Args: {};
  Blocks: {
    default: [
      {
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
