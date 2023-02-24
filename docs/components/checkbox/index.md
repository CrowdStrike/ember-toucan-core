# Checkbox

Provides a Toucan-styled [checkbox element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox). If you are building forms, you may be interested in the CheckboxField component instead.

## Checked Value

To set the `checked` attribute of the checkbox, provide `@value`.

```hbs
<Form::Controls::Checkbox @value={{true}} />
<Form::Controls::Checkbox @value={{false}} />
```

## Indeterminate

Checkboxes have the ability to be in the [indeterminate state](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/checkbox#indeterminate_state_checkboxes). This is accomplished with `@isIndeterminate`. It is up to the consumer to decide what will force the checkbox into the indeterminate state. The [data-checked](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-checked) attribute is set to either "true", "false", or "mixed" depending on the state (where "mixed" is set if `@isIndeterminate={{true}}`).

```hbs
<Form::Controls::Checkbox @isIndeterminate={{true}} />
```

## onChange

To tie into the input event, provide `@onChange`. `@onChange` will return three arguments:

1. the checked attribute from the target
2. the raw event object
3. the indeterminate attribute from the target

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
  handleChange(value, e, indeterminate) {
    console.log({ e, indeterminate, value });
    this.value = value;
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the checkbox.
