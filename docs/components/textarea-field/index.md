# Textarea Field

Provides an underlying `<textarea>` element building on top of the Field component.

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the Label section of the Field.

### @label

```hbs
<Form::Fields::Textarea
  @label='Label'
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
/>
```

### :label

```hbs
<Form::Fields::Textarea
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
</Form::Fields::Textarea>
```

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section of the Field.

### @hint

```hbs
<Form::Fields::Textarea
  @label='Label'
  @hint='Here is a hint'
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
/>
```

### :hint

```hbs
<Form::Fields::Textarea
  @label='Label'
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
</Form::Fields::Textarea>
```

## Error

Optional.

Provide a string or array of strings to `@error` to render the text into the Error section of the Field.

```hbs
<Form::Fields::Textarea @label='Single error' @error='Error' />
```

```hbs
<Form::Fields::Textarea
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
<Form::Fields::Textarea
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

Set the `@isDisabled` argument to disable the textarea.

## Read Only State

Set the `@isReadOnly` argument to put the textarea in the read only state.

## Attributes and Modifiers

Consumers have direct access to the underlying [textarea element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea), so all attributes are supported. Modifiers can also be added directly to the textarea as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
<Form::Fields::Textarea @label='Label' @rootTestSelector='example' />
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
  <Form::Fields::Textarea @label='Label' />
</div>

### TextareaField with label and hint

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @hint='With hint text'
  />
</div>

### TextareaField with label and error

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @error='With error'
  />
</div>

### TextareaField with label, hint, and error

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @hint='With hint text'
    @error='With error'
  />
</div>

### TextareaField with label and hint blocks

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
  >
  <:label>Label <svg class="inline" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
  <:hint>Select an option <a href="https://www.crowdstrike.com/">link</a></:hint>
  </Form::Fields::Textarea>
</div>

### TextareaField with label and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @isDisabled={{true}}
  />
</div>

### TextareaField with label, value, and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @isDisabled={{true}}
    @value='disabled'
  />
</div>

### TextareaField with a value

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @hint='With value'
    @value='a value'
  />
</div>

### TextareaField with multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @hint='With hint text'
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
  />
</div>

### TextareaField with character count 

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @hint='With hint text'
  >
    <:secondary as |secondary|>
      <secondary.CharacterCount @max={{255}} />
    </:secondary>
  </Form::Fields::Textarea>
</div>

### TextareaField with character count with a single error 

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @hint='With hint text'
    @error="With error"
  >
    <:secondary as |secondary|>
      <secondary.CharacterCount @max={{255}} />
    </:secondary>
  </Form::Fields::Textarea>
</div>

### TextareaField with character count with multiple errors 

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @hint='With hint text'
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
  >
    <:secondary as |secondary|>
      <secondary.CharacterCount @max={{255}} />
    </:secondary>
  </Form::Fields::Textarea>
</div>

### TextareaField with isReadOnly

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @isReadOnly={{true}}
  />
</div>

### TextareaField with isReadOnly and a value

<div class='mb-4 w-64'>
  <Form::Fields::Textarea
    @label='Label'
    @isReadOnly={{true}}
    @value="Input value"
  />
</div>
