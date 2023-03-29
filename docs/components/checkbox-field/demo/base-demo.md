```hbs template
<Form::Fields::Checkbox
  @label='Label'
  @isChecked={{this.isChecked}}
  @onChange={{this.handleChange}}
>
  <:label>extra label info</:label>
  <:hint>extra hint info</:hint>
</Form::CheckboxField>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked isChecked = false;

  @action
  handleChange(checkedState) {
    this.isChecked = checkedState;
  }
}
```
