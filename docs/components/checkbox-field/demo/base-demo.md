```hbs template
<Form::CheckboxField
  @label='Label'
  @isChecked={{this.isChecked}}
  @onChange={{this.handleChange}}
/>
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
