# Radio

Provides a Toucan-styled [radio element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/radio). 
If you are building forms, you may be interested in the [RadioField](./radio-field) component instead.

## Value

Optional.

To set the `value` attribute of the radio, provide `@value`. This is required.

```hbs
<Form::Controls::Radio @value='value-1' data-radio-1 />
<Form::Controls::Radio @value='value-2' data-radio-2 />
```

## Checked State

Optional.

To set the `checked` attribute of the radio, provide `@isChecked`.

```hbs
<Form::Controls::Radio @value='value-1' @isChecked={{true}} data-radio-1 />
<Form::Controls::Radio @value='value-2' @isChecked={{false}} data-radio-2 />
```

```js
assert.dom('[data-radio-1]').isChecked();
assert.dom('[data-radio-2]').isNotChecked();
```

## onChange

Optional.

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the value attribute from the target (e.target.value)
2. the raw event object

```hbs
<Form::Controls::Radio @value='value-1' @onChange={{this.handleChange}} />
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @action
  handleChange(value, e) {
    console.log({ e, value });
  }
}
```

## Disabled State

Optional.

Set the `@isDisabled` argument to disable the radio.

```hbs
<Form::Controls::Radio @isDisabled={{true}} />
```

## Read Only State

Optional.

Set the `@isReadOnly` argument to put the radio in the read only state.

```hbs
<Form::Controls::Radio @isReadOnly={{true}} />
```
