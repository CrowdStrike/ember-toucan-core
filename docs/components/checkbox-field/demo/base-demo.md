```hbs template
<Form::CheckboxField
  @label='Label'
  @value={{this.value}}
  @onChange={{this.updateValue}}
/>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked value = false;

  @action
  updateValue(value) {
    this.value = value;
  }
}
```
