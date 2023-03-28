```hbs template
<Form::InputField
  @label='Label'
  @hint='Type "input" into the field'
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
  type='text'
/>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked value;
  @tracked errorMessage;

  @action
  updateValue(value, e) {
    this.value = value;

    if (value !== 'input') {
      this.errorMessage = 'Input must match "input"';
      return;
    }

    this.errorMessage = null;
  }
}
```
