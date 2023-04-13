import Component from '@glimmer/component';

import TextareaFieldComponent from '../-private/textarea-field';

import type { WithBoundArgs } from '@glint/template';
import type { HeadlessFormComponentSignature } from 'ember-headless-form/components/headless-form';

type UserData = object;

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
        Textarea?: WithBoundArgs<typeof TextareaFieldComponent, 'form'>;
        // TODO: Need to figure out a type for this
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        Field: any;
      }
    ];
  };
}

export default class ToucanFormComponent<
  DATA extends UserData,
  SUBMISSION_VALUE
> extends Component<ToucanFormComponentSignature<DATA, SUBMISSION_VALUE>> {
  TextareaFieldComponent = TextareaFieldComponent;

  get validateOn() {
    let { validateOn } = this.args;

    return validateOn || 'focusout';
  }
}
