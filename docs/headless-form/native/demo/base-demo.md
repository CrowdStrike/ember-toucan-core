```hbs template
{{! note - write your own map-error helper }}
{{! field.rawErrors.map(error => error.message) }}
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
      @error={{map-errors field.rawErrors}}
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
}
```
