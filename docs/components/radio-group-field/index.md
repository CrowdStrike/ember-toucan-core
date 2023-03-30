# Radio Group Field

Provides a radio group to be used within forms. It yields [RadioFields](./radio-field) back to the consumer so they can render as many radio options as needed with built-in state tracking for the selected value.

## Yielded Items

- `RadioField`: An underlying [RadioField](./radio-field) component. All arguments and attributes of RadioField can be supplied (e.g., `@isDisabled`, `@hint`, etc.)

## Label

Provide a string to `@label` to render the text into the `<legend>` of the fieldset.

## Hint

Optional. Provide a string to `@hint` to render the text into the Hint section of the fieldset.

## Error

Optional. Provide a string or array of strings to `@error` to render the text into the Error section of the fieldset.

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
