```hbs template
<div class='flex space-x-4'>
  <Form::Controls::Radio @value='1' />
  <Form::Controls::Radio @value='2' @isChecked={{true}} />
  <Form::Controls::Radio @value='3' @isDisabled={{true}} />
  <Form::Controls::Radio @value='4' @isChecked={{true}} @isDisabled={{true}} />
  <Form::Controls::Radio @value='5' @isChecked={{false}} @isReadOnly={{true}} />
  <Form::Controls::Radio @value='6' @isChecked={{true}} @isReadOnly={{true}} />
</div>
```

```js component
import Component from '@glimmer/component';

export default class extends Component {}
```
