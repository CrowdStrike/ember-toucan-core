import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { assert } from '@ember/debug';
import { action } from '@ember/object';

import assertBlockOrArgumentExists from '../../../-private/assert-block-or-argument-exists';
import CharacterCount from '../../../components/form/controls/character-count';

import type { AssertBlockOrArg } from '../../../-private/assert-block-or-argument-exists';
import type { ErrorMessage } from '../../../-private/types';
import type { ToucanFormTextareaControlComponentSignature } from '../controls/textarea';
import type { WithBoundArgs } from '@glint/template';

export interface ToucanFormTextareaFieldComponentSignature {
  Element: HTMLTextAreaElement;
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
     * Sets the readonly attribute of the textarea.
     */
    isReadOnly?: boolean;

    /**
     * Provide a string to this argument to render inside of the label tag.
     */
    label?: string;

    /**
     * The function called when the element is typed into.
     */
    onChange?: ToucanFormTextareaControlComponentSignature['Args']['onChange'];

    /**
     * A test selector for targeting the root element of the field. In this case, the wrapping div element.
     */
    rootTestSelector?: string;

    /**
     * Sets the value attribute of the textarea.
     */
    value?: ToucanFormTextareaControlComponentSignature['Args']['value'];
  };
  Blocks: {
    label: [];
    hint: [];
    secondary: [
      {
        CharacterCount: WithBoundArgs<typeof CharacterCount, 'current'>;
      }
    ];
  };
}

export default class ToucanFormTextareaFieldComponent extends Component<ToucanFormTextareaFieldComponentSignature> {
  @tracked count = this.args.value?.length ?? 0;

  CharacterCount = CharacterCount;
  assertBlockOrArgumentExists = ({
    blockExists,
    argName,
    arg,
    isRequired,
  }: AssertBlockOrArg) =>
    assertBlockOrArgumentExists({ blockExists, argName, arg, isRequired });

  constructor(
    owner: unknown,
    args: ToucanFormTextareaFieldComponentSignature['Args']
  ) {
    super(owner, args);
  }

  @action
  handleCount(event: Event | InputEvent): void {
    assert(
      'Expected HTMLTextAreaElement',
      event.target instanceof HTMLTextAreaElement
    );
    this.count = event.target?.value.length ?? 0;
  }

  get hasError() {
    return Boolean(this.args?.error);
  }
}
