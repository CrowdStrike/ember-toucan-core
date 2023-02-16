# Textarea Field

Provides an underlying `<textarea>` element building on top of the Field component.

## Label

Provide a string to `@label` to render the text into the `<label>` of the Field.

## Hint

Provide a string to `@hint` to render the text into the Hint section of the Field. This is optional.

## Error

Provide a string to `@error` to render the text into the Error section of the Field. This is optional.

## Disabled State

Set the `@isDisabled` to disabled the Field.

## Attributes and Modifiers

Consumers have direct access to the underlying [textarea element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea), so all attributes are supported. Modifiers can also be added directly to the textarea as shown in the demo.

## All UI States

<div class="flex flex-col space-y-4">
<Form::TextareaField
@label='Label'
/>

<Form::TextareaField
@label='Label'
@error="With error"
/>

<Form::TextareaField
@label='Label'
@hint='With hint text'
/>

<Form::TextareaField
@label='Label'
@hint='With hint text'
@error="With error"
/>

</div>
