import Component from '@glimmer/component';

import type { ToucanFormTextareaFieldComponentSignature as BaseTextareaFieldSignature } from '@crowdstrike/ember-toucan-core/components/form/fields/textarea';

type ComponentArguments = BaseTextareaFieldSignature['Args'] & {
  name: string;

  // TODO: We need to type this properly
  // What is the type when we are a component?
  // Is this possible with TS+Glint today?
  form: {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    Field: any;
  };
};

export interface ToucanFormTextareaFieldComponentSignature {
  Element: HTMLTextAreaElement;
  Args: ComponentArguments;
  Blocks: {
    default: [];
  };
}

export default class ToucanFormTextareaFieldComponent extends Component<ToucanFormTextareaFieldComponentSignature> {
  mapErrors = (errors: Array<{ message: string }>) => {
    if (!errors) {
      return;
    }

    return errors.map((error) => error.message);
  };
}
