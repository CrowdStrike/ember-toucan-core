```hbs template
<HeadlessForm
  class='space-y-4'
  @data={{this.data}}
  @onSubmit={{this.handleSubmit}}
  as |form|
>
  <form.Field @name='name' as |field|>
    <Form::InputField
      @label='Name'
      @hint='What should we call you?'
      @error={{this.mapErrors field.rawErrors}}
      @value={{field.value}}
      @onChange={{field.setValue}}
      name='name'
      required
    />
  </form.Field>

  <form.Field @name='email' as |field|>
    <Form::InputField
      @label='Email'
      @hint='How do we contact you?'
      @error={{this.mapErrors field.rawErrors}}
      @value={{field.value}}
      @onChange={{field.setValue}}
      name='email'
      required
      type='email'
    />
  </form.Field>

  <Button type='submit'>Submit</Button>
</HeadlessForm>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class MyFormComponent extends Component {
  data = { name: 'CrowdStrike', email: null };

  @action
  handleSubmit(data) {
    console.log({ data });

    const { name, email } = data;

    alert(`Form submitted with: ${name} ${email}`);
  }

  mapErrors = (errors) => {
    if (!errors) {
      return;
    }

    return errors.map((error) => error.message);
  };
}
```
