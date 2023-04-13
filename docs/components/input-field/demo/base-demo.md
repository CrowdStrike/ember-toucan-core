```hbs template
<Form::Fields::Input
  @label='Label'
  @hint='Hint text'
  @error={{this.errorMessage}}
  @value={{this.value}}
  @onChange={{this.handleChange}}
  type='text'
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
  @tracked count = 0;
  @tracked errorMessage;

  @action
  handleChange(value, event) {
    console.log({ value, event });
    this.count = value.length;

    if (value !== 'input') {
      this.errorMessage = 'Input must match "input"';
      return;
    }

    this.errorMessage = null;

  }
}
```
