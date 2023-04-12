# Input field

Provides an underlying `<input>` element building on top of the Field component.

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the Label section of the Field.

### @label

```hbs
<Form::Fields::Input
  @label='Label'
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
  type='text'
/>
```

### :label

```hbs
<Form::Fields::Input
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
  type='text'
>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
</Form::Fields::Input>
```

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section of the Field.

### @hint

```hbs
<Form::Fields::Input
  @label='Label'
  @hint='Type "input" into the field'
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
  type='text'
/>
```

### :hint

```hbs
<Form::Fields::Input
  @label='Label'
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
  type='text'
>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
</Form::Fields::Input>
```

## Error

Optional.

Provide a string or array of strings to `@error` to render the text into the Error section of the Field.

```hbs
<Form::Fields::Input @label='Single error' @error='Error' />
```

```hbs
<Form::Fields::Input
  @label='Multiple errors'
  @error={{(array 'Error 1' 'Error 2')}}
/>
```

## Value and onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments, the first being the value, while the second being the raw event object. It's most common to use this in combination with `@value` which will set the value for the input based on the input received from the change event.

```hbs
<Form::Fields::Input
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

Set the `@isDisabled` argument to disable the `<input>`.

## Attributes and Modifiers

Consumers have direct access to the underlying [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input), so all attributes are supported. Modifiers can also be added directly to the input as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
<Form::Fields::Input @label='Label' @rootTestSelector='example' />
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

## UI States

### InputField with label

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
  />
</div>

### InputField with label and hint

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @hint='With hint text'
  />
</div>

### InputField with label and hint blocks

<div class='mb-4 w-64'>
  <Form::Fields::Input
  >
  <:label>Label <svg class="inline" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
  <:hint>Hint text <a href="https://www.crowdstrike.com/">link</a></:hint>
  </Form::Fields::Input>
</div>

### InputField with label and error

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @error='With error text'
  />
</div>

### InputField with label, hint, and error

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @hint='With hint text'
    @error='With error text'
  />
</div>

### InputField with label and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @isDisabled={{true}}
  />
</div>

### InputField with label, value, and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @isDisabled={{true}}
    @value='disabled'
  />
</div>

### InputField with a value

<div class='mb-4 w-64'>
<Form::Fields::Input
@label='Label'
@hint='With value'
@value='a value'
/>
</div>

### InputField with multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
  />
</div>

### InputField with character count

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    class="w-full"
    type='text'
  >
    <:secondary as |secondary|>
      <secondary.CharacterCount @max={{255}} />
    </:secondary>

</Form::Fields::Input>

</div>

### InputField with character count with single error

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @error="With error"
    class="w-full"
    type='text'
  >
    <:secondary as |secondary|>
      <secondary.CharacterCount @max={{255}} />
    </:secondary>

</Form::Fields::Input>

</div>

### InputField with character count with multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
    class="w-full"
    type='text'
  >
    <:secondary as |secondary|>
      <secondary.CharacterCount @max={{255}} />
    </:secondary>

</Form::Fields::Input>

</div>

### InputField with read only

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @isReadOnly={{true}}
  />
</div>

### InputField with read only and a value

<div class='mb-4 w-64'>
  <Form::Fields::Input
    @label='Label'
    @isReadOnly={{true}}
    @value="Input value"
  />
</div>
