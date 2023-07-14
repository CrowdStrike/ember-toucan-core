# Combobox Field

Provides a Toucan-styled combobox with filtering that builds on top of the Field component.

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the Label section of the Field.

### `@label`

```hbs
<Form::Fields::Combobox
  @label='Label'
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  as |combobox|
>
  <combobox.Option @value={{combobox.value}}>
    {{combobox.option}}
  </combobox.Option>
</Form::Fields::Combobox>
```

### `:label`

```hbs
<Form::Fields::Combobox
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  placeholder='Colors'
  as |combobox|
>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>

  <combobox.Option @label="Blue" @value="blue" />
</Form::Fields::Combobox>

<Form::Fields::Combobox
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  as |combobox|
>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
  <:default>
    <combobox.Option @value={{combobox.value}}>
      {{combobox.option}}
    </combobox.Option>
  </:default>
</Form::Fields::Combobox>
```

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section of the Field.

### @hint

```hbs
<Form::Fields::Combobox
  @label='Label'
  @hint='Here is a hint'
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  as |combobox|
>
  <combobox.Option @value={{combobox.value}}>
    {{combobox.option}}
  </combobox.Option>
</Form::Fields::Combobox>
```

### `:hint`

```hbs
<Form::Fields::Combobox
  @label='Label'
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  as |combobox|
>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
  <:default>
    <combobox.Option @value={{combobox.value}}>
      {{combobox.option}}
    </combobox.Option>
  </:default>
</Form::Fields::Combobox>
```

## Error

Optional.

Provide a string or array of strings to `@error` to render the text into the Error section of the Field.

```hbs
<Form::Fields::Combobox @label='Single error' @error='Error' />
```

```hbs
<Form::Fields::Combobox
  @label='Label'
  @error={{(array 'Error 1' 'Error 2')}}
  @onChange={{this.onChange}}
  as |combobox|
>
  <combobox.Option @value={{combobox.value}}>
    {{combobox.option}}
  </combobox.Option>
</Form::Fields::Combobox>
```

## `@onChange`

Provide an `@onChange` callback to be notified when the user's selections have changed.
`@onChange` will receive the value as its only argument.

```hbs
<Form::Fields::Combobox
  @label='Label'
  @onChange={{this.onChange}}
  as |combobox|
>
  <combobox.Option @value={{combobox.value}}>
    {{combobox.option}}
  </combobox.Option>
</Form::Fields::Combobox>
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
<Form::Fields::Combobox @label='Label' @rootTestSelector='example' />
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

### ComboboxField with `@label`

<div class='mb-4 w-64'>
  <Form::Fields::Combobox @label='Label' placeholder='Colors' />
</div>

### ComboboxField with `@label` and `@hint`

<div class='mb-4 w-64'>
  <Form::Fields::Combobox
    @label='Label'
    @hint='With hint text'
    placeholder='Colors'
  />
</div>

### ComboboxField with `:label` and `:hint` blocks

<div class='mb-4 w-64'>
  <Form::Fields::Combobox placeholder='Colors'>
    <:label>Label <svg class="inline w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
    <:hint>Hint text <a href="https://www.crowdstrike.com/">link</a></:hint>
    <:default as |combobox|>
      <combobox.Option>
        {{combobox.option}}
      </combobox.Option>
    </:default>
  </Form::Fields::Combobox>
</div>

### ComboboxField with `@label` and `@error`

<div class='mb-4 w-64'>
  <Form::Fields::Combobox
    @label='Label'
    @error='With error text'
    placeholder='Colors'
  />
</div>

### ComboboxField with `@label`, `@hint`, and `@error`

<div class='mb-4 w-64'>
  <Form::Fields::Combobox
    @label='Label'
    @hint='With hint text'
    @error='With error text'
    placeholder='Colors'
  />
</div>

### ComboboxField with `@label` and `@isDisabled`

<div class='mb-4 w-64'>
  <Form::Fields::Combobox
    @label='Label'
    @isDisabled={{true}}
    placeholder='Colors'
  />
</div>

### ComboboxField with `@label`, `@value`, and `@isDisabled`

<div class='mb-4 w-64'>
  <Form::Fields::Combobox
    @label='Label'
    @isDisabled={{true}}
    @selected="blue"
    @options={{(array 'blue' 'red')}}
    placeholder='Colors'
  as |combobox|>
    <combobox.Option>
      {{combobox.option}}
    </combobox.Option>
  </Form::Fields::Combobox>
</div>

### ComboboxField with multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::Combobox
    @label='Label'
    @options={{(array 'blue' 'red')}}
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
    placeholder='Colors'
  as |combobox|>
    <combobox.Option>
      {{combobox.option}}
    </combobox.Option>
  </Form::Fields::Combobox>
</div>

### ComboboxField with `@isReadOnly`

<div class='mb-4 w-64'>
  <Form::Fields::Combobox
    @label='Label'
    @hint='With hint text'
    @isReadOnly={{true}}
  />
</div>

### ComboboxField with `@isReadOnly` and `@selected`

<div class='mb-4 w-64'>
  <Form::Fields::Combobox
    @label='Label'
    @isReadOnly={{true}}
    @selected="blue"
    @options={{(array 'blue' 'red')}}
    placeholder='Colors'
  as |combobox|>
    <combobox.Option>
      {{combobox.option}}
    </combobox.Option>
  </Form::Fields::Combobox>
</div>
