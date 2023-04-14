import Component from '@glimmer/component';

import InputFieldComponent from '../-private/input-field';
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
        Textarea: WithBoundArgs<typeof TextareaFieldComponent<DATA>, 'form'>;
        Input: WithBoundArgs<typeof InputFieldComponent<DATA>, 'form'>;
        Field: HeadlessFormBlock<DATA>['Field'];
      }
    ];
  };
}

export default class ToucanFormComponent<
  DATA extends UserData,
  SUBMISSION_VALUE
> extends Component<ToucanFormComponentSignature<DATA, SUBMISSION_VALUE>> {
  TextareaFieldComponent = TextareaFieldComponent<DATA>;
  InputFieldComponent = InputFieldComponent<DATA>;

  get validateOn() {
    let { validateOn } = this.args;

    return validateOn || 'focusout';
  }
}
