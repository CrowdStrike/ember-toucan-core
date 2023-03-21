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
    <Form::InputField
      @label='Name'
      @hint='This is where you put your name'
      name='name'
      @value={{field.value}}
      @onChange={{field.setValue}}
    />
    {{#if field.rawErrors.length}}
      {{#each field.rawErrors as |error|}}
        <p>{{error.message}}</p>
      {{/each}}
    {{/if}}
  </form.Field>

  <form.Field @name='email' as |field|>
    <Form::InputField
      @label='Email'
      @hint='This is where you put your email'
      name='email'
      type='email'
      @value={{field.value}}
      @onChange={{field.setValue}}
    />
    {{#if field.rawErrors.length}}
      {{#each field.rawErrors as |error|}}
        <p>{{error.message}}</p>
      {{/each}}
    {{/if}}
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
  data = { name: 'Nicole' };

  validations = {
    name: validatePresence(true),
    email: validateFormat({ type: 'email' }),
  };

  handleSubmit({ name, email }) {
    alert(`Form submitted with: ${name} ${email}`);
  }
}
```
