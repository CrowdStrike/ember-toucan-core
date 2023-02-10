import Component from '@glimmer/component';

import Wrapper from './wrapper';

interface ToucanFormFieldComponentSignature {
  Element: HTMLDivElement;
  Args: {};
  Blocks: {
    // TODO - type these properly!
    default: any;
    label?: any;
    hint?: any;
    control?: any;
    error?: any;
  };
}

export default class ToucanFormFieldComponent extends Component<ToucanFormFieldComponentSignature> {
  Wrapper = Wrapper;
}
