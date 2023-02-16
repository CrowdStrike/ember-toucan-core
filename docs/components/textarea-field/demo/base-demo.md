```hbs template
<Form::TextareaField
  @label='Label'
  @hint='Type "textarea" into the field'
  @error={{this.errorMessage}}
  value={{this.value}}
  {{on 'input' this.updateValue}}
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
  updateValue(e) {
    this.value = e.target.value;

    if (e.target.value !== 'textarea') {
      this.errorMessage = 'Input must match "textarea"';
      return;
    }

    this.errorMessage = null;
  }
}
```
