import Component from '@glimmer/component';

import CheckboxFieldComponent from '../-private/checkbox-field';
import CheckboxGroupFieldComponent from '../-private/checkbox-group-field';
import ComboboxFieldComponent from '../-private/combobox-field';
import FileInputFieldComponent from '../-private/file-input-field';
import InputFieldComponent from '../-private/input-field';
import RadioGroupFieldComponent from '../-private/radio-group-field';
import TextareaFieldComponent from '../-private/textarea-field';

import type { HeadlessFormBlock, UserData } from '../-private/types';
import type { WithBoundArgs } from '@glint/template';
import type { HeadlessFormComponentSignature } from 'ember-headless-form/components/headless-form';

type HeadlessFormArguments<
  DATA extends UserData,
  SUBMISSION_VALUE
> = HeadlessFormComponentSignature<DATA, SUBMISSION_VALUE>['Args'];

export interface ToucanFormComponentSignature<
  DATA extends UserData,
  SUBMISSION_VALUE
> {
  Element: HTMLFormElement;
  Args: HeadlessFormArguments<DATA, SUBMISSION_VALUE>;
  Blocks: {
    default: [
      {
        Checkbox: WithBoundArgs<typeof CheckboxFieldComponent<DATA>, 'form'>;
        CheckboxGroup: WithBoundArgs<
          typeof CheckboxGroupFieldComponent<DATA>,
          'form'
        >;
        Combobox: WithBoundArgs<typeof ComboboxFieldComponent<DATA>, 'form'>;
        Field: HeadlessFormBlock<DATA>['Field'];
        FileInput: WithBoundArgs<typeof FileInputFieldComponent<DATA>, 'form'>;
        Input: WithBoundArgs<typeof InputFieldComponent<DATA>, 'form'>;
        RadioGroup: WithBoundArgs<
          typeof RadioGroupFieldComponent<DATA>,
          'form'
        >;
        Textarea: WithBoundArgs<typeof TextareaFieldComponent<DATA>, 'form'>;

        /**
         * Yielded action that will trigger form validation and submission, same as when triggering the native `submit` event on the form.
         *
         * View ember-headless-form's documentation for more information.
         *
         * Note that calling this directly is **not** required for most cases. The implementation only requires a button tag with the `type="submit"` attribute set; however, this is exposed for more complex cases.
         */
        submit: () => void;

        /**
         * Yielded action that will reset form state, same as when triggering the native `reset` event on the form.
         *
         * View ember-headless-form's documentation for more information.
         */
        reset: () => void;
      }
    ];
  };
}

export default class ToucanFormComponent<
  DATA extends UserData,
  SUBMISSION_VALUE
> extends Component<ToucanFormComponentSignature<DATA, SUBMISSION_VALUE>> {
  CheckboxComponent = CheckboxFieldComponent<DATA>;
  CheckboxGroupComponent = CheckboxGroupFieldComponent<DATA>;
  FileInputFieldComponent = FileInputFieldComponent<DATA>;
  InputFieldComponent = InputFieldComponent<DATA>;
  RadioGroupFieldComponent = RadioGroupFieldComponent<DATA>;
  ComboboxFieldComponent = ComboboxFieldComponent<DATA>;
  TextareaFieldComponent = TextareaFieldComponent<DATA>;

  get validateOn() {
    let { validateOn } = this.args;

    return validateOn || 'focusout';
  }
}
