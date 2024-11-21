import Component from '@glimmer/component';
import { hash } from '@ember/helper';

import { HeadlessForm } from 'ember-headless-form';
import { TrackedAsyncData } from 'ember-async-data';

import AutocompleteFieldComponent from '../-private/autocomplete-field';
import CheckboxFieldComponent from '../-private/checkbox-field';
import CheckboxGroupFieldComponent from '../-private/checkbox-group-field';
import FileInputFieldComponent from '../-private/file-input-field';
import InputFieldComponent from '../-private/input-field';
import MultiselectFieldComponent from '../-private/multiselect-field';
import RadioGroupFieldComponent from '../-private/radio-group-field';
import TextareaFieldComponent from '../-private/textarea-field';

import type { HeadlessFormBlock, UserData } from '../-private/types';
import type { WithBoundArgs } from '@glint/template';
import type { ErrorRecord } from 'ember-headless-form';
import type { HeadlessFormComponentSignature } from 'ember-headless-form/components/headless-form';

type HeadlessFormArguments<
  DATA extends UserData,
  SUBMISSION_VALUE,
> = HeadlessFormComponentSignature<DATA, SUBMISSION_VALUE>['Args'];

export interface ToucanFormComponentSignature<
  DATA extends UserData,
  SUBMISSION_VALUE,
> {
  Element: HTMLFormElement;
  Args: HeadlessFormArguments<DATA, SUBMISSION_VALUE>;
  Blocks: {
    default: [
      {
        Autocomplete: WithBoundArgs<
          typeof AutocompleteFieldComponent<DATA>,
          'form'
        >;
        Checkbox: WithBoundArgs<typeof CheckboxFieldComponent<DATA>, 'form'>;
        CheckboxGroup: WithBoundArgs<
          typeof CheckboxGroupFieldComponent<DATA>,
          'form'
        >;
        Field: HeadlessFormBlock<DATA>['Field'];
        FileInput: WithBoundArgs<typeof FileInputFieldComponent<DATA>, 'form'>;
        Input: WithBoundArgs<typeof InputFieldComponent<DATA>, 'form'>;
        Multiselect: WithBoundArgs<
          typeof MultiselectFieldComponent<DATA>,
          'form'
        >;
        RadioGroup: WithBoundArgs<
          typeof RadioGroupFieldComponent<DATA>,
          'form'
        >;
        Textarea: WithBoundArgs<typeof TextareaFieldComponent<DATA>, 'form'>;

       /**
         * The (async) validation state as `TrackedAsyncData`.
         *
         * Use derived state like `.isPending` to render the UI conditionally.
         */
        validationState?: TrackedAsyncData<ErrorRecord<DATA>>;

        /**
         * The (async) submission state as `TrackedAsyncData`.
         *
         * Use derived state like `.isPending` to render the UI conditionally.
         */
        submissionState?: TrackedAsyncData<SUBMISSION_VALUE>;

        /**
         * Will be true if at least one form field is invalid.
         */
        isInvalid: boolean;

        /**
         * An ErrorRecord, for custom rendering of error output
         */
        rawErrors?: ErrorRecord<DATA>;

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
      },
    ];
  };
}

export default class ToucanFormComponent<
  DATA extends UserData,
  SUBMISSION_VALUE,
> extends Component<ToucanFormComponentSignature<DATA, SUBMISSION_VALUE>> {
  AutocompleteFieldComponent = AutocompleteFieldComponent<DATA>;
  CheckboxComponent = CheckboxFieldComponent<DATA>;
  CheckboxGroupComponent = CheckboxGroupFieldComponent<DATA>;
  FileInputFieldComponent = FileInputFieldComponent<DATA>;
  InputFieldComponent = InputFieldComponent<DATA>;
  MultiselectFieldComponent = MultiselectFieldComponent<DATA>;
  RadioGroupFieldComponent = RadioGroupFieldComponent<DATA>;
  TextareaFieldComponent = TextareaFieldComponent<DATA>;

  get validateOn() {
    let { validateOn } = this.args;

    return validateOn || 'focusout';
  }

  <template>
    <HeadlessForm
      @data={{@data}}
      @dataMode={{@dataMode}}
      @validateOn={{this.validateOn}}
      @revalidateOn={{@revalidateOn}}
      @validate={{@validate}}
      @onSubmit={{@onSubmit}}
      @onInvalid={{@onInvalid}}
      ...attributes
      as |form|
    >
      {{yield
        (hash
          Autocomplete=(component this.AutocompleteFieldComponent form=form)
          Checkbox=(component this.CheckboxComponent form=form)
          CheckboxGroup=(component this.CheckboxGroupComponent form=form)
          Field=form.Field
          FileInput=(component this.FileInputFieldComponent form=form)
          Input=(component this.InputFieldComponent form=form)
          Multiselect=(component this.MultiselectFieldComponent form=form)
          RadioGroup=(component this.RadioGroupFieldComponent form=form)
          Textarea=(component this.TextareaFieldComponent form=form)
          validationState=form.validationState
          submissionState=form.submissionState
          isInvalid=form.isInvalid
          rawErrors=form.rawErrors
          reset=form.reset
          submit=form.submit
        )
      }}
    </HeadlessForm>
  </template>
}
