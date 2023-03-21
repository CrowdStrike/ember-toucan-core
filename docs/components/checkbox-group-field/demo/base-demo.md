```hbs template
<Form::CheckboxGroupField
  @label='Label'
  @hint='Extra information about the field'
  @name='options'
  @value={{this.groupValue}}
  @onChange={{this.updateValue}}
  as |group|
>
  <group.CheckboxField @label='Option 1' @option='option-1' />
  <group.CheckboxField
    @label='Option 2'
    @option='option-2'
    @hint='Extra information about the radio'
  />
  <group.CheckboxField @label='Option 3' @option='option-3' />
  <group.CheckboxField
    @label='Option 4'
    @option='option-4'
    @hint='Extra information about the radio'
  />
</Form::CheckboxGroupField>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked groupValue = [];

  @action
  updateValue(value) {
    this.groupValue = value;
  }
}
```
