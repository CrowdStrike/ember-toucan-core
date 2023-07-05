# Select field

Provides a Toucan-styled select with filtering that builds on top of the Field component.

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the Label section of the Field.

### `@label`

```hbs
<Form::Fields::Select
  @label='Label'
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  placeholder='Colors'
>
  <select.Option @label='Blue' @value='blue' />
</Form::Fields::Select>
```

### `:label`

```hbs
<Form::Fields::Select
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  placeholder='Colors'
>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>

  <select.Option @label="Blue" @value="blue" />
</Form::Fields::Select>
```

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section of the Field.

### @hint

```hbs
<Form::Fields::Select
  @label='Label'
  placeholder='Colors'
  @hint='Type "input" into the field'
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
>
  <select.Option @label='Blue' @value='blue' />
</Form::Fields::Select>
```

### `:hint`

```hbs
<Form::Fields::Select
  @label='Label'
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  placeholder='Colors'
>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>

  <select.Option @label='Blue' @value='blue' />
</Form::Fields::Select>
```

## Error

Optional.

Provide a string or array of strings to `@error` to render the text into the Error section of the Field.

```hbs
<Form::Fields::Select @label='Single error' @error='Error' />
```

```hbs
<Form::Fields::Select
  @label='Multiple errors'
  @error={{(array 'Error 1' 'Error 2')}}
  placeholder='Colors'
>
  <select.Option @label='Blue' @value='blue' />
</Form::Fields::Select>
```

## `@onChange`

Provide an `@onChange` callback to be notified when the user's selections have changed.
`@onChange` will receive an array of values as its only argument.

```hbs
<Form::Fields::Select
  @label='Label'
  @onChange={{this.onChange}}
  placeholder='Colors'
/>
  <select.Option @label="Blue" @value="blue" />
</Form::Fields::Select>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class extends Component {
  @action
  onChange(values) {
    console.log(values);
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the input.

## Read Only State

Set the `@isReadOnly` argument to put the input in the read only state.

## Attributes and Modifiers

Consumers have direct access to the underlying [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input), so all attributes are supported.
Modifiers can also be added directly to the input as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`.
This test selector will be used as the value for the `data-root-field` attribute.
The Field can be targeted via:

```hbs
<Form::Fields::Select
  @label='Label'
  placeholder='Colors'
  @rootTestSelector='example'
/>
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

### SelectField with `@label`

<div class='mb-4 w-64'>
  <Form::Fields::Select @label='Label' placeholder='Colors' as |select|>
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>

### SelectField with `@label` and `@hint`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @hint='With hint text'
    placeholder='Colors'
    as |select|
  >
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>

### SelectField with `:label` and `:hint` blocks

<div class='mb-4 w-64'>
  <Form::Fields::Select @popoverClass="z-10" placeholder='Colors'>
    <:label>Label <svg class="inline w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
    <:hint>Hint text <a href="https://www.crowdstrike.com/">link</a></:hint>
    <:default as |select|>
      <select.Option @label="Blue" @value="blue" />
      <select.Option @label="Green" @value="green" />
      <select.Option @label="Yellow" @value="yellow" />
    </:default>
  </Form::Fields::Select>
</div>

### SelectField with `@label` and `@error`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @error='With error text'
    placeholder='Colors'
    as |select|
  >
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>

### SelectField with `@label`, `@hint`, and `@error`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @hint='With hint text'
    @error='With error text'
    placeholder='Colors'
    as |select|
  >
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>

### SelectField with `@label` and `@isDisabled`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label' placeholder='Colors'
    @initialSelectedValues={{array "blue"}}
    @isDisabled={{true}}
    placeholder='Colors'
  as |select|>
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>

### SelectField with `@label`, `@value`, and `@isDisabled`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @isDisabled={{true}}
    placeholder='Colors'
  as |select|>
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>

### SelectField with `@label`, `@value`, `@isDisabled`, and `@initialSelectedValues`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @initialSelectedValues={{array "blue"}}
    @isDisabled={{true}}
    placeholder='Colors'
  as |select|>
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>

### SelectField with multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    placeholder='Colors'
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
  as |select|>
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>

### SelectField with `@isReadOnly`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    placeholder='Colors'
    @isReadOnly={{true}}
  as |select|>
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>

### SelectField with `@isReadOnly` and `@initialSelectedValues`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    placeholder='Colors'
    @isReadOnly={{true}}
    @initialSelectedValues={{array "blue"}}
  as |select|>
    <select.Option @label="Blue" @value="blue" />
    <select.Option @label="Green" @value="green" />
    <select.Option @label="Yellow" @value="yellow" />
  </Form::Fields::Select>
</div>
