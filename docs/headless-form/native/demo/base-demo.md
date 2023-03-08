```hbs template
<HeadlessForm @data={{this.data}} @onSubmit={{this.handleSubmit}} as |form|>
  <form.Field @name='name' as |field|>
    <Form::InputField
      @label='Name'
      @hint='This is where you put your name'
      name='name'
      required
      @value={{field.value}}
      @onChange={{field.setValue}}
    />
    <field.Errors />
  </form.Field>

  <button type='submit'>Submit</button>
</HeadlessForm>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class MyFormComponent extends Component {
  data = { name: 'Nicole' };

  @action
  handleSubmit(data) {
    console.log({ data });
  }
}
```
