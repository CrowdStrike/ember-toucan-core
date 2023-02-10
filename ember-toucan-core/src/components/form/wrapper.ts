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
        // TODO: Figure out how to resolve these type errors
        // (property) Label: typeof Label
        // Type 'abstract new () => PartiallyAppliedComponent<EmptyObject, {}, AcceptsBlocks<FlattenBlockParams<{ default: { Params: { Positional: []; }; }; }>, HTMLLabelElement>>' is not assignable to type 'typeof ToucanFormLabel'.
        // Cannot assign an abstract constructor type to a non-abstract constructor type.glint:ts(2322)
        Label: any;
        Hint: any;
        Control: any;
        Error: any;
      }
    ];
    // TODO: Figure out how to resolve these type errors
    // Error: Property '[Data]' is missing in type 'abstract new () => PartiallyAppliedComponent<EmptyObject, {}, AcceptsBlocks<FlattenBlockParams<{ default: { Params: { Positional: []; }; }; }>, HTMLDivElement>>' but required in type 'TemplateOnlyComponent<ToucanFormHintComponentSignature>'
    hint?: any;
    control?: any;
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
