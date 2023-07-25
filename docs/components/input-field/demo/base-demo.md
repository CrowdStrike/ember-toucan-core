```hbs template
<div class='w-96'>
  <Form::Fields::Input
    @label='Label'
    @hint='Type "input" into the field'
    @error={{this.errorMessage}}
    @value={{this.value}}
    @onChange={{this.handleChange}}
    type='text'
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
  handleChange(value, event) {
    this.value = value;
    console.log({ value, event });

    if (value !== 'input') {
      this.errorMessage = 'Input must match "input"';
      return;
    }

    this.errorMessage = null;
  }
}
```
