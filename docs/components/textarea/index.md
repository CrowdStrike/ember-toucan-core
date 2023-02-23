# Textarea

Provides a Toucan-styled [textarea element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea). If you are building forms, you may be interested in the TextareaField component instead.

## Value

To set the `value` attribute of the `<textarea>`, provide `@value`.

```hbs
<Form::Controls::Textarea @value='value' />
```

## onChange

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the value from the target
2. the raw event object

```hbs
<Form::Controls::Textarea
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
