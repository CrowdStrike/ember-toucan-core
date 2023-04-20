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

  <form.CheckboxGroup @label='Checkboxes' @name='checkboxes' as |group|>
    <group.CheckboxField
      @label='Option 1'
      @value='option-1'
      required
      data-checkbox-group-1
    />
    <group.CheckboxField
      @label='Option 2'
      @value='option-2'
      required
      data-checkbox-group-2
    />
    <group.CheckboxField
      @label='Option 3'
      @value='option-3'
      required
      data-checkbox-group-3
    />
  </form.CheckboxGroup>

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
