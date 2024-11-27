```hbs template
<div class='mx-auto max-w-md'>
  <ToucanForm
    class='space-y-4'
    @data={{this.data}}
    @onSubmit={{this.handleSubmit}}
    @validate={{validate-yup this.schema}}
    as |form|
  >
    <form.Input @label='Name' @name='name' />
    <form.Input @label='Email' @name='email' />

    <Button class='w-full' type='submit'>Submit</Button>
  </ToucanForm>
</div>
```

```js component
import Component from '@glimmer/component';
import { object, string } from 'yup';

export default class extends Component {
  data = {
    name: '',
    email: '',
  };

  schema = object({
    name: string().required(),
    email: string().required().email(),
  });

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
