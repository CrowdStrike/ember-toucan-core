# Radio Field

Provides an underlying radio element building on top of the Field component.

## Label

Provide a string to `@label` to render the text into the `<label>` of the Field.

## Hint

Provide a string to `@hint` to render the text into the Hint section of the Field. This is optional.

## Error

Provide a string to `@error` to render the text into the Error section of the Field. This is optional.

## Value, Checked State, and onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the value attribute from the target
2. the raw event object

It's most common to use this in combination with `@value` which will set the `checked` attribute for the Checkbox.

```hbs
<Form::RadioField
  @label='Label'
  @value='option-1'
  @onChange={{this.handleChange}}
  @isChecked={{this.eq 'option-1' this.selectedValue}}
/>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

function eq(params) {}

export default class extends Component {
  @tracked selectedValue = 'option-1';

  eq = (value, selectedValue) => {
    return value === selectedValue;
  };

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
<Form::RadioField @label='Label' @rootTestSelector='example' />
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
<Form::RadioField
@label='Label'
@value="option-1"
/>

<Form::RadioField
@label='Label'
@error="With error"
@value="option-1"
/>

<Form::RadioField
@label='Label'
@hint='With hint text'
@value="option-1"
/>

<Form::RadioField
@label='Label'
@hint='With hint text'
@error="With error"
@value="option-1"
/>

<Form::RadioField
@label='Label'
@hint='Checked'
@value="option-1"
@isChecked={{true}}
/>

<Form::RadioField
@label='This is an option that expands to multiple lines'
@value="option-1"
/>

<Form::RadioField
@label='This is an option that expands to multiple lines'
@hint="Here is helper text that overflows onto multiple lines"
@value="option-1"
/>

<Form::RadioField
@label='This is an option that expands to multiple lines'
@error="With error"
@value="option-1"
/>

<Form::RadioField
@label='Disabled'
@isDisabled={{true}}
@value="option-1"
/>

<Form::RadioField
@label='Disabled'
@hint="With hint"
@isDisabled={{true}}
@value="option-1"
/>

<Form::RadioField
@label='Disabled + checked'
@isChecked={{true}}
@isDisabled={{true}}
@value="option-1"
/>

</div>
