# Checkbox

Provides a Toucan-styled [checkbox element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox). If you are building forms, you may be interested in the CheckboxField component instead.

## Checked Value

To set the `checked` attribute of the checkbox, provide `@value`.

```hbs
<Form::Controls::Checkbox @value={{true}} data-checkbox-1 />
<Form::Controls::Checkbox @value={{false}} data-checkbox-2 />
```

To check the checked attribute in tests, use:

```js
assert.dom('[data-checkbox-1]').isChecked();
assert.dom('[data-checkbox-2]').isNotChecked();
```

## Indeterminate

Checkboxes have the ability to be in the [indeterminate state](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#indeterminate_state_checkboxes). This is accomplished with `@isIndeterminate`. It is up to the consumer to decide what will force the checkbox into the indeterminate state.

```hbs
<Form::Controls::Checkbox @isIndeterminate={{true}} data-checkbox />
```

To check the indeterminate property in tests, use:

```js
assert.dom('[data-checkbox]').hasProperty('indeterminate', true);
```

## onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the checked attribute from the target (e.target.checked)
2. the raw event object

To access the indeterminate property of the checkbox, use `e.target.indeterminate`.

```hbs
<Form::Controls::Checkbox
  @value={{this.value}}
  @onChange={{this.handleChange}}
/>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked value = false;

  @action
  handleChange(value, e) {
    console.log({ e, indeterminate: e.target.indeterminate, value });
    this.value = value;
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the checkbox.
