import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import LockIcon from '../../../-private/components/lock-icon';
import CharacterCount from '../../../components/form/controls/character-count';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage, OnChangeCallback } from '../../../-private/types';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormInputFieldComponentSignature {
  Element: HTMLInputElement;
  Args: {
    /**
     * Provide a string or array of strings to this argument to render an error message and apply error styling to the Field.
     */
    error?: ErrorMessage;

    /**
     * Provide a string to this argument to render a hint message to help describe the control.
     */
    hint?: string;

    /**
     * Sets the disabled attribute on the control.
     */
    isDisabled?: boolean;

    /**
     * Sets the readonly attribute of the input.
     */
    isReadOnly?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * The function called when the element is typed into.
     */
    onChange?: OnChangeCallback<string>;

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * Sets the value attribute of the input.
     */
    value?: string;
  };
  Blocks: {
    default: [];
    label: [];
    hint: [];
    secondary: [
      {
        CharacterCount: WithBoundArgs<typeof CharacterCount, 'current'>;
      }
    ];
  };
}

export default class ToucanFormInputFieldComponent extends Component<ToucanFormInputFieldComponentSignature> {
  @tracked count = this.args.value?.length ?? 0;

  CharacterCount = CharacterCount;
  LockIcon = LockIcon;

  assertBlockOrArgumentExists = ({
    blockExists,
    argName,
    arg,
    isRequired,
  }: AssertBlockOrArg) =>
    assertBlockOrArgumentExists({ blockExists, argName, arg, isRequired });

  get hasError() {
    return Boolean(this.args?.error);
  }

  get isReadOnlyOrDisabled() {
    return this.args?.isDisabled || this.args?.isReadOnly;
  }

  @action
  handleCount(event: Event | InputEvent): void {
    assert(
      'Expected HTMLInputElement',
      event.target instanceof HTMLInputElement
    );

    this.count = event.target?.value.length ?? 0;
  }
}
