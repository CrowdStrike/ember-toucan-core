```hbs template
<ToucanForm
  class='space-y-4 max-w-xs'
  @data={{changeset this.data this.validations}}
  @dataMode='mutable'
  @onSubmit={{this.handleSubmit}}
  @validate={{validate-changeset}}
  as |form|
>
  <form.Input @label='First name' @name='firstName' />
  <form.Input @label='Last name' @name='lastName' />
  <form.Textarea @label='Comment' @name='comment' />

  <form.RadioGroup @label='Radios' @name='radio' as |group|>
    <group.RadioField @label='Option 1' @value='option-1' data-radio-1 />
    <group.RadioField @label='Option 2' @value='option-2' data-radio-2 />
  </form.RadioGroup>

  <form.CheckboxGroup @label='Checkboxes' @name='checkboxes' as |group|>
    <group.CheckboxField
      @label='Option 1'
      @value='option-1'
      data-checkbox-group-1
    />
    <group.CheckboxField
      @label='Option 2'
      @value='option-2'
      data-checkbox-group-2
    />
    <group.CheckboxField
      @label='Option 3'
      @value='option-3'
      data-checkbox-group-3
    />
  </form.CheckboxGroup>

  <form.Checkbox @label='Agree to the Terms' @name='terms' />

  <Button type='submit'>Submit</Button>
</ToucanForm>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import {
  validatePresence,
  validateFormat,
} from 'ember-changeset-validations/validators';

export default class extends Component {
  data = {};

  validations = {
    comment: validatePresence(true),
    checkboxes: validatePresence(true),
    firstName: validatePresence(true),
    lastName: validatePresence(true),
    radio: validatePresence(true),
    terms: validatePresence(true),
  };

  handleSubmit(data) {
    console.log({ data });

    alert(
      `Form submitted with:\n${Object.entries(data.get('pendingData'))
        .map(([key, value]) => `${key}: ${value}`)
        .join('\n')}`
    );
  }
}
```
