import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
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
    secondaryInformation: [
      {
        CharacterCount: WithBoundArgs<typeof CharacterCount, 'current'>;
      }
    ];
  };
}

export default class ToucanFormInputFieldComponent extends Component<ToucanFormInputFieldComponentSignature> {
  @tracked count = 0;

  CharacterCount = CharacterCount;

  constructor(
    owner: unknown,
    args: ToucanFormInputFieldComponentSignature['Args']
  ) {
    super(owner, args);

    if (this.args.value) {
      this.count = this.args.value.length;
    }
  }
  assertBlockOrArgumentExists = ({
    blockExists,
    argName,
    arg,
    isRequired,
  }: AssertBlockOrArg) =>
    assertBlockOrArgumentExists({ blockExists, argName, arg, isRequired });

  @action
  handleCount(event: Event | InputEvent): void {
    assert(
      'Expected HTMLInputElement',
      event.target instanceof HTMLInputElement
    );

    if (event.target?.value) {
      this.count = event.target.value.length;
    } else {
      this.count = 0;
    }
  }

  get hasError() {
    return Boolean(this.args?.error);
  }

  /**
   * Used to help us determine if we should render a single error
   * or render a ul list of errors.
   */
  get hasMoreThanOneError() {
    return Array.isArray(this.args.error) && this.args.error?.length > 1;
  }
}
