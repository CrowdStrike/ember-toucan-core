import Component from '@glimmer/component';

import Control from './control';
import Error from './error';
import Hint from './hint';
import Label from './label';

interface ToucanFormWrapperComponentSignature {
  Element: HTMLDivElement;
  Args: {};
  Blocks:
    | {
        default: [
          {
            Label: typeof Label;
            Hint: typeof Hint;
            Control: typeof Control;
            Error: typeof Error;
          }
        ];
      }
    | {
        hint: typeof Hint;
        control: typeof Control;
        label: typeof Label;
        error: typeof Error;
      };
}

export default class ToucanFormWrapperComponent extends Component<ToucanFormWrapperComponentSignature> {
  Label = Label;
  Hint = Hint;
  Control = Control;
  Error = Error;
}
