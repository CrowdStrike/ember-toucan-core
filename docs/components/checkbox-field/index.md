# Checkbox Field

Provides an underlying checkbox element building on top of the Field component.

## Label

Provide a string to `@label` to render the text into the `<label>` of the Field.

## Hint

Provide a string to `@hint` to render the text into the Hint section of the Field. This is optional.

## Error

Provide a string or array of strings to `@error` to render the text into the Error section of the Field. This is optional.

```hbs
<Form::CheckboxField @label='Single error' @error='Error' />
```

```hbs
<Form::CheckboxField
  @label='Multiple errors'
  @error={{(array 'Error 1' 'Error 2')}}
/>
```

## Value and onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the checked attribute from the target
2. the raw event object

It's most common to use this in combination with `@value` which will set the `checked` attribute for the Checkbox.

To access the indeterminate property of the checkbox, use `e.target.indeterminate`.

```hbs
<Form::CheckboxField
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
    console.log({ e, indeterminate: e.target.indeterminate, value });
    this.value = value;
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the checkbox.

## Indeterminate State

Set the `@isIndeterminate` argument. To learn more, view the [Checkbox documentation](./checkbox).

## Attributes and Modifiers

Consumers have direct access to the underlying [checkbox element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox), so all attributes are supported. Modifiers can also be added directly to the Checkbox as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
<Form::CheckboxField @label='Label' @rootTestSelector='example' />
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

<div class="flex flex-col space-y-4" style="max-width: 14rem">
<Form::CheckboxField
@label='Label'
/>

<Form::CheckboxField
@label='Label'
@error="With error"
/>

<Form::CheckboxField
@label='Label'
@hint='With hint text'
/>

<Form::CheckboxField
@label='Label'
@hint='With hint text'
@error="With error"
/>

<Form::CheckboxField
@label='Label'
@hint='Checked'
@value={{true}}
/>

<Form::CheckboxField
@label='Label'
@hint='Indeterminate'
@isIndeterminate={{true}}
/>

<Form::CheckboxField
@label='This is an option that expands to multiple lines'
/>

<Form::CheckboxField
@label='This is an option that expands to multiple lines'
@hint="Here is helper text that overflows onto multiple lines"
/>

<Form::CheckboxField
@label='This is an option that expands to multiple lines'
@error="With error"
/>

<Form::CheckboxField
@label='Disabled'
@isDisabled={{true}}
/>

<Form::CheckboxField
@label='Disabled'
@hint="With hint"
@isDisabled={{true}}
/>

<Form::CheckboxField
@label='Disabled + checked'
@value={{true}}
@isDisabled={{true}}
/>

<Form::CheckboxField
@label='Multiple errors'
@error={{(array "With error 1" "With error 2" "With error 3")}}
/>

</div>
