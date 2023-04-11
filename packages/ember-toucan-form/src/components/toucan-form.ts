import Component from '@glimmer/component';

import type { HeadlessFormComponentSignature } from 'ember-headless-form/components/headless-form';

// TODO: Should we export this from ember-headless-form and use it here instead? This is probably fine?
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
  // TODO: Probably want to yield https://github.com/CrowdStrike/ember-headless-form/blob/main/packages/ember-headless-form/src/components/headless-form.ts#L88 as well
  Blocks: {
    default: [];
  };
}

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class ToucanFormComponent<
  DATA extends UserData,
  SUBMISSION_VALUE
> extends Component<ToucanFormComponentSignature<DATA, SUBMISSION_VALUE>> {}
