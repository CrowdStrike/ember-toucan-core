```hbs template
<Form::Fields::CheckboxGroup
  @label='Label'
  @hint='Extra information about the field'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.CheckboxField @label='Option 1' @value='option-1' />
  <group.CheckboxField
    @label='Option 2'
    @hint='Extra information about the radio'
    @value='option-2'
  />
  <group.CheckboxField @label='Option 3' @value='option-3' />
  <group.CheckboxField
    @label='Option 4'
    @hint='Extra information about the radio'
    @value='option-4'
  />
</Form::Fields::CheckboxGroup>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked groupValue = ['option-1'];

  @action
  updateValue(value) {
    this.groupValue = value;
  }
}
```
