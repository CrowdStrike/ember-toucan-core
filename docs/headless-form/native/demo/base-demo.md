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
      @hint='This is where you put your name'
      @error={{this.mapErrors field.rawErrors}}
      name='name'
      required
      @value={{field.value}}
      @onChange={{field.setValue}}
    />
  </form.Field>

  <Button type='submit'>Submit</Button>
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

  mapErrors = (errors) => {
    if (!errors) {
      return
    } 

    return errors.map((error) => error.message);
  }
}
```