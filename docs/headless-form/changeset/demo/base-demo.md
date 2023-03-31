```hbs template
<HeadlessForm
  class='space-y-4'
  @data={{changeset this.data this.validations}}
  @dataMode='mutable'
  @onSubmit={{this.handleSubmit}}
  @validate={{validate-changeset}}
  as |form|
>
  <form.Field @name='name' as |field|>
    <Form::Fields::Input
      @label='Name'
      @error={{this.mapErrors field.rawErrors}}
      @hint='What should we call you?'
      @value={{field.value}}
      @onChange={{field.setValue}}
      name='name'
    />
  </form.Field>

  <form.Field @name='email' as |field|>
    <Form::Fields::Input
      @label='Email'
      @error={{this.mapErrors field.rawErrors}}
      @hint='How do we contact you?'
      @value={{field.value}}
      @onChange={{field.setValue}}
      name='email'
      type='email'
    />
  </form.Field>
  <Button type='submit'>Submit</Button>
</HeadlessForm>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import {
  validatePresence,
  validateFormat,
} from 'ember-changeset-validations/validators';

export default class MyFormComponent extends Component {
  data = { name: 'CrowdStrike', email: null };

  validations = {
    name: validatePresence(true),
    email: validateFormat({ type: 'email' }),
  };

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
