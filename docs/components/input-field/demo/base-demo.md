```hbs template
<Form::Fields::Input
  @label='Label'
  @hint='Type "input" into the field'
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.updateValue}}
  type='text'
/>
>
  <:character as |data|><Form::Controls::CharacterCount
      @id={{data.id}}
      @current={{this.count}}
      @max={{255}}
    /></:character>
</Form::Fields::Input>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked value;
  @tracked errorMessage;
  @tracked count = 0;

  @action
  updateValue(value, e) {
    this.value = value;

    if (value !== 'input') {
      this.errorMessage = 'Input must match "input"';
      return;
    }

    this.errorMessage = null;
  }

  @action
  handleChange(value, event) {
    console.log({ value, event });
    this.count = value.length;
  }
}
```
