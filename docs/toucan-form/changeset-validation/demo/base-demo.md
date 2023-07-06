```hbs template
<ToucanForm
  class='space-y-4 max-w-xs'
  @data={{changeset this.data this.validations}}
  @dataMode='mutable'
  @onSubmit={{this.handleSubmit}}
  @validate={{(validate-changeset)}}
  as |form|
>
  <form.Input @label='First name' @name='firstName' />
  <form.Input @label='Last name' @name='lastName' />
  <form.Textarea @label='Comment' @name='comment' />

  <form.CheckboxGroup @label='Fruit selection' @name='fruit' as |group|>
    <group.CheckboxField
      @label='Banana'
      @value='banana'
      data-checkbox-group-1
    />
    <group.CheckboxField @label='Apple' @value='apple' data-checkbox-group-2 />
    <group.CheckboxField @label='Pear' @value='pear' data-checkbox-group-3 />
  </form.CheckboxGroup>

  <form.RadioGroup @label='Vegetable selection' @name='vegetable' as |group|>
    <group.RadioField @label='Avocado' @value='avocado' data-radio-1 />
    <group.RadioField @label='Broccoli' @value='broccoli' data-radio-2 />
  </form.RadioGroup>

  <form.Combobox
    @contentClass='z-10'
    @label='Color'
    @name='color'
    @noResultsText='No results'
    @options={{this.options}}
    @optionKey='label'
    as |combobox|
  >
    <combobox.Option>
      {{combobox.option.label}}
    </combobox.Option>
  </form.Combobox>

  <form.FileInput
    @label='Files to attach'
    @trigger='Select files'
    @deleteLabel='Delete'
    @name='files'
  />

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
    color: validatePresence(true),
    files: validatePresence(true),
    firstName: validatePresence(true),
    fruit: validatePresence(true),
    lastName: validatePresence(true),
    terms: validatePresence(true),
    vegetable: validatePresence(true),
  };

  options = [
    {
      label: 'Blue',
      value: 'blue',
    },
    {
      label: 'Green',
      value: 'green',
    },
    {
      label: 'Yellow',
      value: 'yellow',
    },
    {
      label: 'Orange',
      value: 'orange',
    },
    {
      label: 'Red',
      value: 'red',
    },
    {
      label: 'Purple',
      value: 'purple',
    },
    {
      label: 'Teal',
      value: 'teal',
    },
  ];

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
