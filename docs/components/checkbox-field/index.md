# Checkbox Field

Provides an underlying checkbox element building on top of the Field component.

## Label

Provide a string to `@label` to render the text into the `<label>` of the Field.

## Hint

Optional. Provide a string to `@hint` to render the text into the Hint section of the Field.

## Error

Optional. Provide a string or array of strings to `@error` to render the text into the Error section of the Field.

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

It's most common to use this in combination with `@isChecked` which will set the `checked` attribute for the Checkbox.

To access the indeterminate property of the checkbox, use `e.target.indeterminate`.

```hbs
<Form::CheckboxField
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

### CheckboxField with label

<div class="mb-4 w-64">
<Form::CheckboxField
@label='This is an option that expands to multiple lines'
/>
</div>

### CheckboxField with label and hint

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@hint='With hint text'
/>
</div>

### CheckboxField with label and error

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@error='With error'
/>
</div>

### CheckboxField with label, hint, and error

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@error='With error'
@hint="With hint text"
/>
</div>

### CheckboxField with label and isDisabled

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@isDisabled={{true}}
/>
</div>

### CheckboxField with label, isChecked, and isDisabled

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@isChecked={{true}}
@isDisabled={{true}}
/>
</div>

### CheckboxField with label, isIndeterminate, and isDisabled

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@isIndeterminate={{true}}
@isDisabled={{true}}
/>
</div>

### CheckboxField with isChecked

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@isChecked={{true}}
/>
</div>

### CheckboxField with isIndeterminate

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@isIndeterminate={{true}}
/>
</div>

### CheckboxField with isIndeterminate and hint

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@hint='With hint text'
@isIndeterminate={{true}}
/>
</div>

### CheckboxField with multiple errors

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@error={{(array "With error 1" "With error 2" "With error 3")}}
/>
</div>

### CheckboxField with hint and isChecked

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@hint='With hint text'
@isChecked={{true}}
/>
</div>

### CheckboxField with long label and short error

<div class="mb-4 w-64">
<Form::CheckboxField
@label='This is an option that expands to multiple lines'
@error="With error"
/>
</div>

### CheckboxField with long label and hint

<div class="mb-4 w-64">
<Form::CheckboxField
@label='This is an option that expands to multiple lines'
@hint="Here is helper text that overflows onto multiple lines"
/>
</div>

### CheckboxField with hint and isDisabled

<div class="mb-4 w-64">
<Form::CheckboxField
@label='Label'
@hint="With hint text"
@isDisabled={{true}}
/>
</div>
