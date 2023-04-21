# Checkbox Group Field

Provides a checkbox group to be used within forms. It yields [CheckboxFields](./checkbox-field) back to the consumer so they can render as many checkboxes as needed with built-in state tracking for the selected values.

## Yielded Items

- `CheckboxField`: An underlying [CheckboxField](./checkbox-field) component. All arguments and attributes of CheckboxField can be supplied (e.g., `@isDisabled`, `@hint`, etc.). To give each option a unique value, use the `@value` argument.

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the legend of the fieldset.

### @label

```hbs template
<Form::Fields::CheckboxGroup
  @label='Label here'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
/>
```

### :label

```hbs template
<Form::Fields::CheckboxGroup
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
>
  {{!-- default block is required here when using :label --}}
  <:default as |group|>
    {{!-- render checkboxes here --}}
  </:default>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
</Form::Fields::CheckboxGroup>
```

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section.

### @hint

```hbs template
<Form::Fields::CheckboxGroup
  @hint='Here is a hint'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
/>
```

### :hint

```hbs template
<Form::Fields::CheckboxGroup
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
>
  {{! default block is required here when using :hint}}
  <:default as |group|>
    {{! render checkboxes here }}
  </:default>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
</Form::Fields::CheckboxGroup>
```

## Error

Optional. Provide a string to `@error` to render the text into the Error section of the fieldset.

## Value and onChange

To tie into the input event when a checkbox is clicked, provide `@onChange`. `@onChange` will return two arguments:

1. an array containing the selected values
2. the raw event object

A `@value` argument to the CheckboxGroupField is used to determine which of the checkboxes is currently selected. It does so by comparing `@value` provided to the CheckboxGroupField to each `@value` of the checkbox. When an `@onChange` event occurs, it's most common to update the `@value` argument to the newly selected values as shown in the example below.

```hbs
<Form::Fields::CheckboxGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.CheckboxField @label='Option 1' @value='option-1' />
  <group.CheckboxField @label='Option 2' @value='option-2' />
</Form::Fields::CheckboxGroup>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked groupValue = [];

  @action
  updateValue(value) {
    this.groupValue = value;
  }
}
```

## Disabled State

### Fieldset

To disable the fieldset and all child checkboxes, set the `@isDisabled` argument directly on the checkbox group field.

```hbs
<Form::Fields::CheckboxGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  @isDisabled={{true}}
  as |group|
>
  <!-- This will now be disabled as well! -->
  <group.CheckboxField @label='Option 1' @value='option-1' />
</Form::Fields::CheckboxGroup>
```

### Individual Checkboxes

To disable individual checkbox fields, set the `@isDisabled` argument directly on the checkbox field.

```hbs
<Form::Fields::CheckboxGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.CheckboxField
    @label='Option 1'
    @value='option-1'
    @isDisabled={{true}}
  />
</Form::Fields::CheckboxGroup>
```

## Read Only State

### Fieldset

To set all checkbox group options to readonly, use the `@isReadOnly` argument directly on the Checkbox Group.

```hbs
<Form::Fields::CheckboxGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  @isReadOnly={{true}}
  as |group|
>
  <!-- This will now be readonly as well! -->
  <group.CheckboxField @label='Option 1' @value='option-1' />
</Form::Fields::CheckboxGroup>
```

### Individual Checkboxes

Individual checkboxes can be set to read only by setting the `@isReadOnly` argument directly on the checkbox field.

```hbs
<Form::Fields::CheckboxGroup
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.CheckboxField
    @label='Option 1'
    @value='option-1'
    @isReadOnly={{true}}
  />
</Form::Fields::CheckboxGroup>
```

## Attributes and Modifiers

Consumers have direct access to the underlying [checkbox element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox), so all attributes are supported. Modifiers can also be added directly to individual radio fields.

## All UI States

### CheckboxGroupField with label

<div class='mb-4 w-64'>
  <Form::Fields::CheckboxGroup
    @label='Label'
    @name='options-a'
    as |group|
  >
    <group.CheckboxField @label='Option 1' @value='option-1' />
    <group.CheckboxField @label='Option 2' @value='option-2'/>
    <group.CheckboxField @label='Option 3' @value='option-3'/>
    <group.CheckboxField @label='Option 4' @value='option-4'/>
  </Form::Fields::CheckboxGroup>
</div>

### CheckboxGroupField with label and hint

<div class='mb-4 w-64'>
  <Form::Fields::CheckboxGroup @label='Label' @name='options-b' @hint='Select an option' as |group|>
    <group.CheckboxField @label='Option 1' @value='option-1' />
    <group.CheckboxField @label='Option 2' @value='option-2' />
    <group.CheckboxField @label='Option 3' @value='option-3' />
  </Form::Fields::CheckboxGroup>
</div>

### CheckboxGroupField with label block and hint block

<div class='mb-4 w-64'>
  <Form::Fields::CheckboxGroup @name='options-b'>
    <:default as |group|>
      <group.CheckboxField @label='Option 1' @value='option-1' />
      <group.CheckboxField @label='Option 2' @value='option-2' />
      <group.CheckboxField @label='Option 3' @value='option-3' />
    </:default>
    <:label>Label <svg class="inline" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
    <:hint>Select an option <a href="https://www.crowdstrike.com/">link</a></:hint>
  </Form::Fields::CheckboxGroup>
</div>

### CheckboxGroupField with label and error

<div class='mb-4 w-64'>
  <Form::Fields::CheckboxGroup @label='Label' @name='options-c' @error='With error' as |group|>
    <group.CheckboxField @label='Option 1' @value='option-1' />
    <group.CheckboxField @label='Option 2' @value='option-2' />
    <group.CheckboxField @label='Option 3' @value='option-3' />
  </Form::Fields::CheckboxGroup>
</div>

### CheckboxGroupField with label, hint, and error

<div class='mb-4 w-64'>
  <Form::Fields::CheckboxGroup @label='Label' @name='options-d' @hint='Select an option' @error='With error' as |group|>
    <group.CheckboxField @label='Option 1' @value='option-1' />
    <group.CheckboxField @label='Option 2' @value='option-2' />
    <group.CheckboxField @label='Option 3' @value='option-3' />
  </Form::Fields::CheckboxGroup>
</div>

### CheckboxGroupField with label and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::CheckboxGroup @label='Label' @name='disabled'  @isDisabled={{true}} as |group|>
    <group.CheckboxField @label='Option 1' @value='option-1' />
    <group.CheckboxField @label='Option 2' @value='option-2' />
    <group.CheckboxField @label='Option 3' @value='option-3' />
  </Form::Fields::CheckboxGroup>
</div>

### CheckboxGroupField with label, hint, and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::CheckboxGroup @label='Label' @name='disabled' @hint='With disabled' @isDisabled={{true}} as |group|>
    <group.CheckboxField @label='Option 1' @value='option-1' />
    <group.CheckboxField @label='Option 2' @value='option-2' />
    <group.CheckboxField @label='Option 3' @value='option-3' />
  </Form::Fields::CheckboxGroup>
</div>

### CheckboxGroupField with label and multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::CheckboxGroup @label='Label' @name='multiple-errors' @error={{(array 'With error 1' 'With error 2' 'With error 3')}} as |group|>
    <group.CheckboxField @label='Option 1' @value='option-1' />
    <group.CheckboxField @label='Option 2' @value='option-2' />
    <group.CheckboxField @label='Option 3' @value='option-3' />
  </Form::Fields::CheckboxGroup>
</div>
