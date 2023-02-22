```hbs template
<Form::InputField
  @label="Label"
  @hint="extra information about the field"
  type="text"
  @value="hello i am an input field"
  @onChange={{this.handleChange}}
/>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class extends Component {

  @action
  handleChange(value, event) {
    console.log({ value, event });
  }
}
```
