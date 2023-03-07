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

1. the list of files (as a FileList) from the target
2. the raw event object

It's most common to use this in combination with `@files` which will set the files (FileList) for the input based on the input received from the change event.

```hbs
<Form::FileInputField
  @label='Label'
  @onChange={{this.handleChange}}
/>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked value;

  @action
  handleChange(files, e) {
    console.log({ files, e});
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the `<input type="file">`.

## Attributes and Modifiers

Consumers have direct access to the underlying [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea), so all attributes are supported. Modifiers can also be added directly to the input as shown in the demo.

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
```

### Label

Target the label element via `data-label`.

### Hint

Target the hint block via `data-hint`.

### Error

Target the error block via `data-error`.

## All UI States

<div class="flex flex-col space-y-4">
  <Form::FileInputField
  @label='Label'
  />

  <Form::FileInputField
  @label='Label'
  @error="With error"
  />

  <Form::FileInputField
  @label='Label'
  @hint='With hint text'
  />

  <Form::FileInputField
    @label='Label'
    @hint='With hint text'
    @error="With error"
  />

  <Form::FileInputField
    @label='Label'
    @hint='With hint text'
  />
</div>
