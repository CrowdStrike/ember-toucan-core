```hbs template
<Form::Fields::RadioGroup
  @label='Label'
  @hint='Extra information about the field'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
>
  <:default as |group|>
    <group.RadioField @label='Option 1' @value='option-1' />
    <group.RadioField
      @label='Option 2'
      @value='option-2'
      @hint='Extra information about the radio'
    />
    <group.RadioField @label='Option 3' @value='option-3' />
    <group.RadioField
      @label='Option 4'
      @value='option-4'
      @hint='Extra information about the radio'
    />
  </:default>

  <:label>extra label info</:label>
  <:hint>extra hint info</:hint>
</Form::Fields::RadioGroup>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked groupValue = 'option-1';

  @action
  updateValue(value) {
    this.groupValue = value;
  }
}
```
