```hbs template
<ToucanForm
  class='space-y-4'
  @data={{changeset this.data this.validations}}
  @dataMode='mutable'
  @onSubmit={{this.handleSubmit}}
  @validate={{validate-changeset}}
  as |form|
>
  <form.Textarea @label='Comment' @name='comment' />

  <Button type='submit'>Submit</Button>
</ToucanForm>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import {
  validatePresence,
  validateFormat,
} from 'ember-changeset-validations/validators';

export default class extends Component {
  data = { comment: null };

  validations = {
    comment: validatePresence(true),
  };

  handleSubmit(data) {
    console.log({ data });

    const { comment } = data;

    alert(`Form submitted with: ${comment}`);
  }
}
```
