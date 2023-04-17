```hbs template
<ToucanForm
  class='space-y-4 max-w-xs'
  @data={{this.data}}
  @onSubmit={{this.handleSubmit}}
  as |form|
>
  <form.Input @label='First name' @name='firstName' required />
  <form.Input @label='Last name' @name='lastName' required />
  <form.Textarea @label='Comment' @name='comment' required />

  <form.RadioGroup @label='Radios' @name='radio' as |group|>
    <group.RadioField
      @label='option-1'
      @value='option-1'
      data-radio-1
      required
    />
    <group.RadioField @label='option-2' @value='option-2' data-radio-2 />
  </form.RadioGroup>

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
