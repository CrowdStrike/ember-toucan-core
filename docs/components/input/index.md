# Input 

Provides a Toucan-styled [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input). If you are building forms, you may be interested in the TextareaField component instead.

## Value

To set the `value` attribute of the `<input>`, provide `@value`.

```hbs
<Form::Controls::Input @value='value' />
```

## onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments, the first being the value, while the second being the raw event.

```hbs
<Form::Controls::Input
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

Set the `@isDisabled` argument to disable the `<input>`.
