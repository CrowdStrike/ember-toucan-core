# Select Field

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
  as |select|
>
  <select.Option @value={{select.value}}>
    {{select.option}}
  </select.Option>
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

<Form::Fields::Select
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  as |select|
>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
  <:default>
    <select.Option @value={{select.value}}>
      {{select.option}}
    </select.Option>
  </:default>
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
  @hint='Here is a hint'
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  as |select|
>
  <select.Option @value={{select.value}}>
    {{select.option}}
  </select.Option>
</Form::Fields::Select>
```

### `:hint`

```hbs
<Form::Fields::Select
  @label='Label'
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  as |select|
>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
  <:default>
    <select.Option @value={{select.value}}>
      {{select.option}}
    </select.Option>
  </:default>
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
  @label='Label'
  @error={{(array 'Error 1' 'Error 2')}}
  @onChange={{this.onChange}}
  as |select|
>
  <select.Option @value={{select.value}}>
    {{select.option}}
  </select.Option>
</Form::Fields::Select>
```

## `@onChange`

Provide an `@onChange` callback to be notified when the user's selections have changed.
`@onChange` will receive the value as its only argument.

```hbs
<Form::Fields::Select @label='Label' @onChange={{this.onChange}} as |select|>
  <select.Option @value={{select.value}}>
    {{select.option}}
  </select.Option>
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
<Form::Fields::Select @label='Label' @rootTestSelector='example' />
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
  <Form::Fields::Select @label='Label' placeholder='Colors' />
</div>

### SelectField with `@label` and `@hint`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @hint='With hint text'
    placeholder='Colors'
  />
</div>

### SelectField with `:label` and `:hint` blocks

<div class='mb-4 w-64'>
  <Form::Fields::Select placeholder='Colors'>
    <:label>Label <svg class="inline w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
    <:hint>Hint text <a href="https://www.crowdstrike.com/">link</a></:hint>
    <:default as |select|>
      <select.Option>
        {{select.option}}
      </select.Option>
    </:default>
  </Form::Fields::Select>
</div>

### SelectField with `@label` and `@error`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @error='With error text'
    placeholder='Colors'
  />
</div>

### SelectField with `@label`, `@hint`, and `@error`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @hint='With hint text'
    @error='With error text'
    placeholder='Colors'
  />
</div>

### SelectField with `@label` and `@isDisabled`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @isDisabled={{true}}
    placeholder='Colors'
  />
</div>

### SelectField with `@label`, `@value`, and `@isDisabled`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @isDisabled={{true}}
    @selected="blue"
    @options={{(array 'blue' 'red')}}
    placeholder='Colors'
  as |select|>
    <select.Option>
      {{select.option}}
    </select.Option>
  </Form::Fields::Select>
</div>

### SelectField with multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @options={{(array 'blue' 'red')}}
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
    placeholder='Colors'
  as |select|>
    <select.Option>
      {{select.option}}
    </select.Option>
  </Form::Fields::Select>
</div>

### SelectField with `@isReadOnly`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @hint='With hint text'
    @isReadOnly={{true}}
  />
</div>

### SelectField with `@isReadOnly` and `@selected`

<div class='mb-4 w-64'>
  <Form::Fields::Select
    @label='Label'
    @isReadOnly={{true}}
    @selected="blue"
    @options={{(array 'blue' 'red')}}
    placeholder='Colors'
  as |select|>
    <select.Option>
      {{select.option}}
    </select.Option>
  </Form::Fields::Select>
</div>
