```hbs template
<ToucanForm
  class='space-y-4'
  @data={{changeset this.data this.validations}}
  @dataMode='mutable'
  @onSubmit={{this.handleSubmit}}
  @validate={{validate-changeset}}
  as |form|
>
  <form.Input @label='First name' @name='firstName' />
  <form.Input @label='Last name' @name='lastName' />
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
  data = {};

  validations = {
    comment: validatePresence(true),
    firstName: validatePresence(true),
    lastName: validatePresence(true),
  };

  handleSubmit(data) {
    console.log({ data });

    alert(
      `Form submitted with:\n${Object.entries(data.get('pendingData'))
        .map(([key, value]) => `${key}: ${value}`)
        .join('\n')}`
    );
  }
}
```
