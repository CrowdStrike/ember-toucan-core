```hbs template
<div class='space-y-4'>
  <Form::RadioField
    @label='Option 1'
    @value='option-1'
    @onChange={{this.updateValue}}
    @isChecked={{this.eq 'option-1' this.selectedValue}}
  />
  <Form::RadioField
    @label='Option 2'
    @value='option-2'
    @onChange={{this.updateValue}}
    @isChecked={{this.eq 'option-2' this.selectedValue}}
  />
  <Form::RadioField
    @label='Option 3'
    @value='option-3'
    @onChange={{this.updateValue}}
    @isChecked={{this.eq 'option-3' this.selectedValue}}
  />
</div>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selectedValue = 'option-1';

  eq = (value, selectedValue) => {
    return value === selectedValue;
  };

  @action
  updateValue(value) {
    this.selectedValue = value;
  }
}
```
