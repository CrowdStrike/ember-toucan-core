# Input

Provides a Toucan-styled [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input). 
If you are building forms, you may be interested in the [InputField](./input-field) component instead.

## Value

Optional.

To set the `value` attribute of the `<input>`, provide `@value`.

```hbs
<Form::Controls::Input @value='value' />
```

## onChange

Optional.

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments, the first being the value, while the second being the raw event.

```hbs
<Form::Controls::Input @value={{this.value}} @onChange={{this.handleChange}} />
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

Optional.

Set the `@isDisabled` argument to disable the input.

```hbs
<Form::Controls::Input @isDisabled={{true}} />
```

## Read Only State

Optional.

Set the `@isReadOnly` argument to put the input in the read only state.

```hbs
<Form::Controls::Input @isReadOnly={{true}} />
```

## Error State

Optional.

Set the `@hasError` argument to apply an error box shadow to the `<input>`.
