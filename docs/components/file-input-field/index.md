# File Input Field


Provides an underlying `<input type="file">` element building on top of the Field component.

## Label

Provide a string to `@label` to render the text into the `<input type="file">` of the Field.

## Hint

Provide a string to `@hint` to render the text into the Hint section of the Field. This is optional.

## Error

Provide a string to `@error` to render the text into the Error section of the Field. This is optional.

## Value and onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the list of files (`File[]`) from the target. **Note:** we convert the FileList we get from the event target to an array of [Files](https://developer.mozilla.org/en-US/docs/Web/API/File) to make it easier to use existing Array methods like `filter`.
2. the raw event object

It's most common to use this in combination with `@files` which will set the files (FileList) for the input based on the input received from the change event.

```hbs
<Form::FileInputField
  @label='Label'
  @files={{this.files}}
  @onChange={{this.handleChange}}
/>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked files = [];

  @action
  handleChange(e) {
    console.log({ files: e.target.files});
    this.files = event.target.files;
  }

}

```

## Disabled State

Set the `@isDisabled` argument to disable the `<input type="file">`.

## Attributes and Modifiers

Consumers have direct access to the underlying [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input), so all attributes are supported. Modifiers can also be added directly to the input as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
<Form::FileInputField @label='Label' @rootTestSelector='example' />
```

```js
assert.dom('[data-root-field="example"]');

// targeting this field's specific label
assert.dom('[data-root-field="example"] > [data-label]');

import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked files = [];

  @action
  handleChange(e) {
    console.log({ files: e.target.files});
    this.files = event.target.files;
  }

}
```

### Label

Target the label element via `data-label`.

### Hint

Target the hint block via `data-hint`.

### Error

Target the error block via `data-error`.

