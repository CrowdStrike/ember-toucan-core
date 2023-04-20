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

  <form.CheckboxGroup @label='Fruit selection' @name='fruit' as |group|>
    <group.CheckboxField
      @label='Banana'
      @value='banana'
      required
      data-checkbox-group-1
    />
    <group.CheckboxField
      @label='Apple'
      @value='apple'
      required
      data-checkbox-group-2
    />
    <group.CheckboxField
      @label='Pear'
      @value='pear'
      required
      data-checkbox-group-3
    />
  </form.CheckboxGroup>

  <form.RadioGroup @label='Vegetable selection' @name='vegetable' as |group|>
    <group.RadioField @label='Avocado' @value='avocado' data-radio-1 />
    <group.RadioField @label='Broccoli' @value='broccoli' data-radio-2 />
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
