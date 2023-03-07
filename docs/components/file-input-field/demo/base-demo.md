```hbs template
<Form::FileInputField
  @label='Label'
  @hint='Hint text'
  @onChange={{this.handleChange}}
>
  <:triggerText>
    Select files
  </:triggerText> 
</Form::FileInputField>
```
```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class extends Component {

  @action
  handleChange(files, event) {
    console.log({files, event});
  }
}
```
