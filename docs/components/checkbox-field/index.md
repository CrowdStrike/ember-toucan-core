# Checkbox Field

Provides an underlying checkbox element building on top of the Field component.

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the Label section.

### @label

```hbs template
<Form::Fields::Checkbox
  @label='Label here'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
/>
```

### :label

```hbs template
<Form::Fields::Checkbox
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
</Form::Fields::Checkbox>
```

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section.

### @hint

```hbs template
<Form::Fields::Checkbox
  @hint='Here is a hint'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
/>
```

### :hint

```hbs template
<Form::Fields::Checkbox
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
</Form::Fields::Checkbox>
```

## Error

Optional.

Provide a string or array of strings to `@error` to render the text into the Error section of the Field.

```hbs
<Form::Fields::Checkbox @label='Single error' @error='Error' />
```

```hbs
<Form::Fields::Checkbox
  @label='Multiple errors'
  @error={{(array 'Error 1' 'Error 2')}}
/>
```

## Value and onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the checked attribute from the target
2. the raw event object

It's most common to use this in combination with `@isChecked` which will set the `checked` attribute for the Checkbox.

To access the indeterminate property of the checkbox, use `e.target.indeterminate`.

```hbs
<Form::Fields::Checkbox
  @label='Label'
  @isChecked={{this.isChecked}}
  @onChange={{this.handleChange}}
/>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked isChecked;

  @action
  handleChange(checkedState, e) {
    console.log({ e, indeterminate: e.target.indeterminate, checkedState });
    this.isChecked = checkedState;
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the checkbox.

## Read Only State

Set the `@isReadOnly` argument to put the checkbox in the read only state.

## Indeterminate State

Set the `@isIndeterminate` argument. To learn more, view the [Checkbox documentation](./checkbox).

## Attributes and Modifiers

Consumers have direct access to the underlying [checkbox element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox), so all attributes are supported. Modifiers can also be added directly to the Checkbox as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
<Form::Fields::Checkbox @label='Label' @rootTestSelector='example' />
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

### CheckboxField with label

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='This is an option that expands to multiple lines'
  />
</div>

### CheckboxField with label and hint

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @hint='With hint text'
  />
</div>

### CheckboxField with label and error

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @error='With error'
  />
</div>

### CheckboxField with label, hint, and error

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @error='With error'
    @hint='With hint text'
  />
</div>

### CheckboxField with label and hint blocks

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
  >
    <:label>Label <svg class="inline w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
    <:hint>Select <a href="https://www.crowdstrike.com/">link</a></:hint>
  </Form::Fields::Checkbox>
</div>

### CheckboxField with label and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @isDisabled={{true}}
  />
</div>

### CheckboxField with label, isChecked, and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @isChecked={{true}}
    @isDisabled={{true}}
  />
</div>

### CheckboxField with label, isIndeterminate, and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @isIndeterminate={{true}}
    @isDisabled={{true}}
  />
</div>

### CheckboxField with isChecked

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @isChecked={{true}}
  />
</div>

### CheckboxField with isIndeterminate

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @isIndeterminate={{true}}
  />
</div>

### CheckboxField with isIndeterminate and hint

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @hint='With hint text'
    @isIndeterminate={{true}}
  />
</div>

### CheckboxField with multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
  />
</div>

### CheckboxField with hint and isChecked

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @hint='With hint text'
    @isChecked={{true}}
  />
</div>

### CheckboxField with long label and short error

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='This is an option that expands to multiple lines'
    @error='With error'
  />
</div>

### CheckboxField with long label and hint

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='This is an option that expands to multiple lines'
    @hint='Here is helper text that overflows onto multiple lines'
  />
</div>

### CheckboxField with hint and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @hint='With hint text'
    @isDisabled={{true}}
  />
</div>

### CheckboxField with isReadOnly

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @isReadOnly={{true}}
  />
</div>

### CheckboxField with isChecked and isReadOnly

<div class='mb-4 w-64'>
  <Form::Fields::Checkbox
    @label='Label'
    @isChecked={{true}}
    @isReadOnly={{true}}
  />
</div>
