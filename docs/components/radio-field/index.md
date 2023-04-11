# Radio Field

Provides an opinionated radio element building on top of the Field component. If you are building real radio groups in forms, you'll want to check out our [RadioGroupField](./radio-group-field) component.

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the Label section of the Field.

### @label

```hbs
<Form::Fields::Radio
  @label='Label'
  @hint='Some hint'
  @name='options'
  @value='option-2'
  @onChange={{this.updateValue}}
  @selectedValue='option-2'
/>
```

### :label

```hbs
<Form::Fields::Radio
  @hint='Some hint'
  @name='options'
  @value='option-2'
  @onChange={{this.updateValue}}
  @selectedValue='option-2'
>
    <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
</Form::Fields::Radio>
```

## Name

Required.

Provide a string to `@name` to set the `name` attribute of the Field.

## Value

Required.

Provide a string to `@value` to set the `value` attribute of the radio.

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section of the Field.

### @hint

```hbs
<Form::Fields::Radio
  @label='Label'
  @hint='Some hint'
  @name='options'
  @value='option-2'
  @onChange={{this.updateValue}}
  @selectedValue='option-2'
/>
```

### :hint

```hbs
<Form::Fields::Radio
  @label='Label'
  @name='options'
  @value='option-2'
  @onChange={{this.updateValue}}
  @selectedValue='option-2'
>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
</Form::Fields::Radio>
```

## Value, Checked State, and onChange

The `@value` argument is required. To tie into the change event, provide `@onChange`. `@onChange` will return two arguments:

1. the value attribute from the target
2. the raw event object

To set the checked state of the radio, the `@selectedValue` and `@value` must match. If these two arguments do not match, the radio will not be checked.

```hbs
<Form::Fields::Radio
  @label='Label'
  @name='options'
  @value='option-1'
  @onChange={{this.handleChange}}
  @selectedValue={{this.selectedValue}}
/>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selectedValue = 'option-1';

  @action
  updateValue(value, e) {
    console.log({ e, value });
    this.selectedValue = value;
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the radio.

## Attributes and Modifiers

Consumers have direct access to the underlying [radio element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio), so all attributes are supported. Modifiers can also be added directly to the Radio as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
<Form::Fields::Radio @label='Label' @rootTestSelector='example' />
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

## All UI States

### RadioField with label

<div class='mb-4 w-64'>
  <Form::Fields::Radio
    @label='Label'
    @name='options-a'
    @value='option-1'
  />
</div>

### RadioField with label and hint

<div class='mb-4 w-64'>
  <Form::Fields::Radio
    @label='Label'
    @name='options-b'
    @hint='with hint text'
    @value='option-1'
  />
</div>

### RadioField with label and hint blocks

<div class='mb-4 w-64'>
  <Form::Fields::Radio
    @name='options-b'
    @value='option-1'
  >
  <:label>Label <svg class="inline" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
  <:hint>Hint text <a href="https://www.crowdstrike.com/">link</a></:hint>
  </Form::Fields::Radio>
</div>

### RadioField with label and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Radio
    @label='Label'
    @name='options-c'
    @isDisabled={{true}}
    @value='option-1'
  />
</div>

### RadioField with label, hint, and selectedValue

<div class='mb-4 w-64'>
  <Form::Fields::Radio
    @label='Label'
    @name='options-d'
    @hint='With hint text'
    @value='option-1'
    @selectedValue='option-1'
  />
</div>

### RadioField with long label, and short error

<div class='mb-4 w-64'>
  <Form::Fields::Radio
    @label='This is an option that expands to multiple lines'
    @name='options-e'
    @value='option-1'
  />
</div>

### RadioField with long label and hint

<div class='mb-4 w-64'>
  <Form::Fields::Radio
    @label='This is an option that expands to multiple lines'
    @name='options-f'
    @hint='Here is helper text that overflows onto multiple lines'
    @value='option-1'
  />
</div>

### RadioField with label, hint, and value isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Radio
    @label='Label'
    @name='options-g'
    @hint='With hint text'
    @isDisabled={{true}}
    @value='option-1'
  />
</div>

### RadioField with label, selectedValue, and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::Radio
    @label='Label'
    @name='options-h'
    @selectedValue='option-1'
    @isDisabled={{true}}
    @value='option-1'
  />
</div>
