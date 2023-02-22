# Textarea Field

Provides an underlying `<textarea>` element building on top of the Field component.

## Label

Provide a string to `@label` to render the text into the `<label>` of the Field.

## Hint

Provide a string to `@hint` to render the text into the Hint section of the Field. This is optional.

## Error

Provide a string to `@error` to render the text into the Error section of the Field. This is optional.

## Value and onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments, the first being the value, while the second being the raw event object. It's most common to use this in combination with `@value` which will set the value for the textarea based on the input received from the change event.

```hbs
<Form::TextareaField
  @label='Label'
  @value={{this.value}}
  @onChange={{this.handleChange}}
/>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked value;

  @action
  handleChange(value, e) {
    console.log({ e, value });
    this.value = value;
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the `<textarea>`.

## Attributes and Modifiers

Consumers have direct access to the underlying [textarea element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea), so all attributes are supported. Modifiers can also be added directly to the textarea as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
<Form::TextareaField @label='Label' @rootTestSelector='example' />
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

<Form::TextareaField
@label='Label'
@hint='With value'
@value='a value'
/>

</div>
