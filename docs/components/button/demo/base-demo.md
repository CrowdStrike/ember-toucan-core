```hbs template
<Button @onClick={{this.onClick}} @variant='secondary'>Button</Button>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class extends Component {
  @action
  onClick(e) {
    alert('Button clicked!');
  }
}
```
