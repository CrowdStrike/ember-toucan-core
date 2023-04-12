```hbs template
<ToucanForm
  class='space-y-4'
  @data={{this.data}}
  @onSubmit={{this.handleSubmit}}
  as |form|
>
  <form.Textarea @label='Comment' @name='comment' required />
  <Button type='submit'>Submit</Button>
</ToucanForm>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class extends Component {
  data = { comment: null };

  @action
  handleSubmit(data) {
    console.log({ data });

    const { comment } = data;

    alert(`Form submitted with: ${comment}`);
  }
}
```
