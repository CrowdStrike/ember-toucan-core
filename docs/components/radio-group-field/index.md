# Radio Group Field

Provides a radio group to be used within forms. It yields [RadioFields](./radio-field) back to the consumer so they can render as many radio options as needed with built-in state tracking for the selected value.

## Yielded Items

- `RadioField`: An underlying [RadioField](./radio-field) component. All arguments and attributes of RadioField can be supplied (e.g., `@isDisabled`, `@hint`, etc.)

## Label

Provide a string to `@label` to render the text into the `<legend>` of the fieldset.

## Hint

Provide a string to `@hint` to render the text into the Hint section of the fieldset. This is optional.

## Error

Provide a string to `@error` to render the text into the Error section of the fieldset. This is optional.

## Value and onChange

To tie into the input event when a radio is clicked, provide `@onChange`. `@onChange` will return two arguments:

1. the value from the target
2. the raw event object

A `@value` argument to the RadioGroupField is used to determine which of the radios is currently selected. When an `@onChange` event occurs, it's most common to update the `@value` argument to the newly selected value as shown in the example below.

```hbs
<Form::RadioGroupField
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.RadioField @label='Option 1' @value='option-1' />
  <group.RadioField @label='Option 2' @value='option-2' />
</Form::RadioGroupField>
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

To disable individual radio fields, set the `@isDisabled` argument.

```hbs
<Form::RadioGroupField
  @label='Label'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.RadioField @label='Option 1' @value='option-1' @isDisabled={{true}} />
</Form::RadioGroupField>
```

## Attributes and Modifiers

Consumers have direct access to the underlying [radio element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio), so all attributes are supported. Modifiers can also be added directly to individual radio fields.

## All UI States

<div class="flex flex-col space-y-4" style="max-width: 14rem">
<Form::RadioGroupField
  @label='Label'
  @name='options'
  as |group|
>
  <group.RadioField @label='Option 1' @value='option-1' />
  <group.RadioField @label='Option 2' @value='option-2'/>
  <group.RadioField @label='Option 3' @value='option-3'/>
  <group.RadioField @label='Option 4' @value='option-4'/>
</Form::RadioGroupField>

<Form::RadioGroupField @label="Label" @name="options" @hint="Select an option" as |group|>
<group.RadioField @label="Option 1" @value="option-1" />
<group.RadioField @label="Option 2" @value="option-2" />
<group.RadioField @label="Option 3" @value="option-3" />
</Form::RadioGroupField>

<Form::RadioGroupField @label="Label" @name="options" @error="With error" as |group|>
<group.RadioField @label="Option 1" @value="option-1" />
<group.RadioField @label="Option 2" @value="option-2" />
<group.RadioField @label="Option 3" @value="option-3" />
</Form::RadioGroupField>

<Form::RadioGroupField @label="Label" @name="options" @hint="Select an option" @error="With error" as |group|>
<group.RadioField @label="Option 1" @value="option-1" />
<group.RadioField @label="Option 2" @value="option-2" />
<group.RadioField @label="Option 3" @value="option-3" />
</Form::RadioGroupField>

</div>
