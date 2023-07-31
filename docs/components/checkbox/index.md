# Checkbox

Provides a Toucan-styled [checkbox element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox). 
If you are building forms, you may be interested in the [CheckboxField](./checkbox-field) component instead.

## Checked State

Optional.

To set the `checked` attribute of the checkbox, provide `@isChecked`.

```hbs
<Form::Controls::Checkbox @isChecked={{true}} data-checkbox-1 />
<Form::Controls::Checkbox @isChecked={{false}} data-checkbox-2 />
```

To verify the checked attribute in tests, use:

```js
assert.dom('[data-checkbox-1]').isChecked();
assert.dom('[data-checkbox-2]').isNotChecked();
```

## Indeterminate

Optional.

Checkboxes have the ability to be in the [indeterminate state](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#indeterminate_state_checkboxes). 
This is accomplished with `@isIndeterminate`. 
It is up to the consumer to decide what will force the checkbox into the indeterminate state.

```hbs
<Form::Controls::Checkbox @isIndeterminate={{true}} data-checkbox />
```

To check the indeterminate property in tests, use:

```js
assert.dom('[data-checkbox]').hasProperty('indeterminate', true);
```

## Disabled State

Optional.

Set the `@isDisabled` argument to disable the checkbox.

```hbs
<Form::Controls::Checkbox @isDisabled={{true}} />
```

## Read Only State

Optional.

Set the `@isReadOnly` argument to put the checkbox in the read only state.

```hbs
<Form::Controls::Checkbox @isReadOnly={{true}} />
```

## onChange

Optional.

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the checked attribute from the target (e.target.checked)
2. the raw event object

To access the indeterminate property of the checkbox, use `e.target.indeterminate`.

```hbs
<Form::Controls::Checkbox
  @isChecked={{this.isChecked}}
  @onChange={{this.handleChange}}
/>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked isChecked = false;

  @action
  handleChange(checkedState, e) {
    console.log({ e, indeterminate: e.target.indeterminate, checkedState });
    this.isChecked = checkedState;
  }
}
```
