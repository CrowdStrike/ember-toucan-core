# Radio Group Field

Provides a radio group to be used within forms. It yields [RadioFields](./radio-field) back to the consumer so they can render as many radio options as needed with built-in state tracking for the selected value.

## Yielded Items

- `RadioField`: An underlying [RadioField](./radio-field) component. All arguments and attributes of RadioField can be supplied (e.g., `@isDisabled`, `@hint`, etc.)

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the legend of the fieldset.

### @label

```hbs
<Form::Fields::RadioGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
/>
```

### :label

```hbs
<Form::Fields::RadioGroup
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
>
  {{!-- note default block is required here --}}
  <:default as |group|>
    {{!-- radio components rendered here --}}
  </:default>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
</Form::Fields::RadioGroup>
```

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the legend of the fieldset.

### @hint

```hbs
<Form::Fields::RadioGroup
  @label='Label'
  @hint='Extra information about the field'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
/>
```

### :hint

```hbs
<Form::Fields::RadioGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
>
  {{! note default block is required here }}
  <:default as |group|>
    {{! radio components rendered here }}
  </:default>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
</Form::Fields::RadioGroup>
```

## Error

Optional.

Provide a string or array of strings to `@error` to render the text into the Error section of the fieldset.

```hbs
<Form::Fields::RadioGroup @label='Label' @name='single-error' @error='Error' />
```

```hbs
<Form::Fields::RadioGroup
  @label='Label'
  @name='multiple-errors'
  @error={{(array 'Error 1' 'Error 2')}}
/>
```

## Value and onChange

To tie into the input event when a radio is clicked, provide `@onChange`. `@onChange` will return two arguments:

1. the value from the target
2. the raw event object

A `@value` argument to the RadioGroupField is used to determine which of the radios is currently selected. When an `@onChange` event occurs, it's most common to update the `@value` argument to the newly selected value as shown in the example below.

```hbs
<Form::Fields::RadioGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.RadioField @label='Option 1' @value='option-1' />
  <group.RadioField @label='Option 2' @value='option-2' />
</Form::Fields::RadioGroup>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked groupValue = 'option-1';

  @action
  updateValue(value) {
    this.groupValue = value;
  }
}
```

## Disabled State

### Fieldset

To disable the fieldset and all child radios, set the `@isDisabled` argument directly on the radio group field.

```hbs
<Form::Fields::RadioGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  @isDisabled={{true}}
  as |group|
>
  <!-- This will now be disabled as well! -->
  <group.RadioField @label='Option 1' @value='option-1' />
</Form::Fields::RadioGroup>
```

### Individual Radios

To disable individual radio fields, set the `@isDisabled` argument directly on the radio field.

```hbs
<Form::Fields::RadioGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.RadioField @label='Option 1' @value='option-1' @isDisabled={{true}} />
</Form::Fields::RadioGroup>
```

## Read Only State

### Fieldset

To set all radio group options to readonly, use the `@isReadOnly` argument directly on the Radio Group.

```hbs
<Form::Fields::RadioGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  @isReadOnly={{true}}
  as |group|
>
  <!-- This will now be readonly as well! -->
  <group.RadioField @label='Option 1' @value='option-1' />
</Form::Fields::RadioGroup>
```

### Individual Radios

Individual radio fields can be set to read only by setting the `@isReadOnly` argument directly on the radio field.

```hbs
<Form::Fields::RadioGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.RadioField @label='Option 1' @value='option-1' @isReadOnly={{true}} />
</Form::Fields::RadioGroup>
```

## Attributes and Modifiers

Consumers have direct access to the underlying [radio element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio), so all attributes are supported. Modifiers can also be added directly to individual radio fields.

## All UI States

### RadioGroupField with label

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup
    @label='Label'
    @name='options-a'
    as |group|
  >
    <group.RadioField @label='Option 1' @value='option-1' />
    <group.RadioField @label='Option 2' @value='option-2'/>
    <group.RadioField @label='Option 3' @value='option-3'/>
    <group.RadioField @label='Option 4' @value='option-4'/>
  </Form::Fields::RadioGroup>
</div>

### RadioGroupField with label and hint

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup @label='Label' @name='options-b' @hint='Select an option' as |group|>
  <group.RadioField @label='Option 1' @value='option-1' />
  <group.RadioField @label='Option 2' @value='option-2' />
  <group.RadioField @label='Option 3' @value='option-3' />
  </Form::Fields::RadioGroup>
</div>

### RadioGroupField with label and hint blocks

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup @name='options-b'>
    <:default as |group|>
      <group.RadioField @label='Option 1' @value='option-1' />
      <group.RadioField @label='Option 2' @value='option-2' />
      <group.RadioField @label='Option 3' @value='option-3' />
    </:default>
  <:label>Label <svg class="inline w-4 h-4 -mt-1" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
  <:hint>Select an option <a href="https://www.crowdstrike.com/">link</a></:hint>
  </Form::Fields::RadioGroup>
</div>

### RadioGroupField with label and error

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup @label='Label' @name='options-c' @error='With error' as |group|>
    <group.RadioField @label='Option 1' @value='option-1' />
    <group.RadioField @label='Option 2' @value='option-2' />
    <group.RadioField @label='Option 3' @value='option-3' />
  </Form::Fields::RadioGroup>
</div>

### RadioGroupField with label, hint, and error

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup @label='Label' @name='options-d' @hint='Select an option' @error='With error' as |group|>
    <group.RadioField @label='Option 1' @value='option-1' />
    <group.RadioField @label='Option 2' @value='option-2' />
    <group.RadioField @label='Option 3' @value='option-3' />
  </Form::Fields::RadioGroup>
</div>

### RadioGroupField with label and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup @label='Label' @isDisabled={{true}} @name='options-e' as |group|>
    <group.RadioField @label='Option 1' @value='option-1' />
    <group.RadioField @label='Option 2' @value='option-2' />
    <group.RadioField @label='Option 3' @value='option-3' />
  </Form::Fields::RadioGroup>
</div>

### RadioGroupField with label, hint, and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup @label='Label' @name='options-f' @isDisabled={{true}} @hint='With hint text' as |group|>
    <group.RadioField @label='Option 1' @value='option-1' />
    <group.RadioField @label='Option 2' @value='option-2' />
    <group.RadioField @label='Option 3' @value='option-3' />
  </Form::Fields::RadioGroup>
</div>

### RadioGroupField with label and multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup @label='Label' @name='multiple-errors' @error={{(array 'With error 1' 'With error 2' 'With error 3')}} as |group|>
    <group.RadioField @label='Option 1' @value='option-1' />
    <group.RadioField @label='Option 2' @value='option-2' />
    <group.RadioField @label='Option 3' @value='option-3' />
  </Form::Fields::RadioGroup>
</div>

### RadioGroupField with label and all read only

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup @label='Label' @name='read-only' as |group|>
    <group.RadioField @label='Option 1' @value='option-1' @isReadOnly={{true}} />
    <group.RadioField @label='Option 2' @value='option-2' @isReadOnly={{true}} />
    <group.RadioField @label='Option 3' @value='option-3' @isReadOnly={{true}} />
  </Form::Fields::RadioGroup>
</div>

### RadioGroupField with label and all read only with one checked

<div class='mb-4 w-64'>
  <Form::Fields::RadioGroup @label='Label' @name='read-only-checked' @value="option-2" as |group|>
    <group.RadioField @label='Option 1' @value='option-1' @isReadOnly={{true}} />
    <group.RadioField @label='Option 2' @value='option-2' @isReadOnly={{true}} />
    <group.RadioField @label='Option 3' @value='option-3' @isReadOnly={{true}} />
  </Form::Fields::RadioGroup>
</div>
