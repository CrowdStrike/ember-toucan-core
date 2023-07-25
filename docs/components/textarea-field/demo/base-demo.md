```hbs template
<div class='w-96'>
  <Form::Fields::Textarea
    @label='Label'
    @hint='Type "textarea" into the field'
    @error={{this.errorMessage}}
    @value={{this.value}}
    @onChange={{this.updateValue}}
  />
</div>
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

    if (value !== 'textarea') {
      this.errorMessage = 'Input must match "textarea"';
      return;
    }

    this.errorMessage = null;
  }
}
```
