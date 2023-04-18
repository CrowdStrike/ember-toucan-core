```hbs template
<ToucanForm
  class='space-y-4'
  @data={{this.data}}
  @onSubmit={{this.handleSubmit}}
  as |form|
>
  <form.Input @label='First name' @name='firstName' required />
  <form.Input @label='Last name' @name='lastName' required />
  <form.Textarea @label='Comment' @name='comment' required />
  <form.Checkbox @label='Agree to the Terms' @name='terms' required />

  <Button type='submit'>Submit</Button>
</ToucanForm>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class extends Component {
  data = {};

  @action
  handleSubmit(data) {
    console.log({ data });

    alert(
      `Form submitted with:\n${Object.entries(data)
        .map(([key, value]) => `${key}: ${value}`)
        .join('\n')}`
    );
  }
}
```
