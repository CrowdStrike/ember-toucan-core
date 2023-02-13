import Component from '@glimmer/component';

import Control from './control';
import Error from './error';
import Hint from './hint';
import Label from './label';

interface ToucanFormWrapperComponentSignature {
  Element: HTMLDivElement;
  Args: {};
  Blocks: {
    default?: [
      {
        Label: typeof Label;
        Hint: typeof Hint;
        Control: typeof Control;
        Error: typeof Error;
      }
    ];
    hint?: any;
    control?: any;
    // (property) ToucanFormWrapperComponent.Hint: TemplateOnlyComponent<ToucanFormHintComponentSignature>
    // Argument of type '[TemplateOnlyComponent<ToucanFormHintComponentSignature>]' is not assignable to parameter of type 'TemplateOnlyComponent<ToucanFormLabelComponentSignature>'.
    // Property '[Data]' is missing in type '[TemplateOnlyComponent<ToucanFormHintComponentSignature>]' but required in type 'TemplateOnlyComponent<ToucanFormLabelComponentSignature>'.glint:ts(2345)
    // label?: typeof Label;
    label?: any;
    error?: any;
  };
}

export default class ToucanFormWrapperComponent extends Component<ToucanFormWrapperComponentSignature> {
  Label = Label;
  Hint = Hint;
  Control = Control;
  Error = Error;
}
