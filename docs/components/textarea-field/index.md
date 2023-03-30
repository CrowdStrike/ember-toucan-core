# Textarea Field

Provides an underlying `<textarea>` element building on top of the Field component.

## Label

Provide a string to `@label` to render the text into the `<label>` of the Field.

## Hint

Optional. Provide a string to `@hint` to render the text into the Hint section of the Field.

## Error

Optional. Provide a string or array of strings to `@error` to render the text into the Error section of the Field.

```hbs
<Form::TextareaField @label='Single error' @error='Error' />
```

```hbs
<Form::TextareaField
  @label='Multiple errors'
  @error={{(array 'Error 1' 'Error 2')}}
/>
```

## Value and onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the value from the target
2. the raw event object

It's most common to use this in combination with `@value` which will set the value for the textarea based on the input received from the change event.

```hbs
<Form::TextareaField
  @label='Label'
  @value={{this.value}}
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
  handleChange(value, e) {
    console.log({ e, value });
    this.value = value;
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the `<textarea>`.

## Attributes and Modifiers

Consumers have direct access to the underlying [textarea element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea), so all attributes are supported. Modifiers can also be added directly to the textarea as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
<Form::TextareaField @label='Label' @rootTestSelector='example' />
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

### TextareaField with label

<div class='mb-4 w-64'>
  <Form::TextareaField @label='Label' />
</div>

### TextareaField with label and hint

<div class='mb-4 w-64'>
  <Form::TextareaField
    @label='Label'
    @hint='With hint text'
  />
</div>

### TextareaField with label and error

<div class='mb-4 w-64'>
  <Form::TextareaField
    @label='Label'
    @error='With error'
  />
</div>

### TextareaField with label, hint, and error

<div class='mb-4 w-64'>
  <Form::TextareaField
    @label='Label'
    @hint='With hint text'
    @error='With error'
  />
</div>

### TextareaField with label and isDisabled

<div class='mb-4 w-64'>
  <Form::TextareaField
    @label='Label'
    @isDisabled={{true}}
  />
</div>

### TextareaField with label, value, and isDisabled

<div class='mb-4 w-64'>
  <Form::TextareaField
    @label='Label'
    @isDisabled={{true}}
    @value='disabled'
  />
</div>

### TextareaField with a value

<div class='mb-4 w-64'>
  <Form::TextareaField
    @label='Label'
    @hint='With value'
    @value='a value'
  />
</div>

### TextareaField with multiple errors

<div class='mb-4 w-64'>
  <Form::TextareaField
    @label='Label'
    @hint='With hint text'
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
  />
</div>
