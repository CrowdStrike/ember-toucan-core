```hbs template
<div class='mx-auto max-w-md'>
  <ToucanForm
    class='space-y-4'
    @data={{changeset this.data this.validations}}
    @dataMode='mutable'
    @onSubmit={{this.handleSubmit}}
    @validate={{(validate-changeset)}}
    as |form|
  >
    <form.Input @label='First name' @name='firstName' />

    <form.Input @label='Last name' @name='lastName'>
      <:secondary as |secondary|>
        <secondary.CharacterCount @max={{255}} />
      </:secondary>
    </form.Input>

    <form.Textarea @label='Comment' @name='comment' />

    <form.Textarea @label='Description' @name='description'>
      <:secondary as |secondary|>
        <secondary.CharacterCount @max={{255}} />
      </:secondary>
    </form.Textarea>

    <form.CheckboxGroup @label='Fruit selection' @name='fruit' as |group|>
      <group.CheckboxField
        @label='Banana'
        @value='banana'
        data-checkbox-group-1
      />
      <group.CheckboxField
        @label='Apple'
        @value='apple'
        data-checkbox-group-2
      />
      <group.CheckboxField @label='Pear' @value='pear' data-checkbox-group-3 />
    </form.CheckboxGroup>

    <form.RadioGroup @label='Vegetable selection' @name='vegetable' as |group|>
      <group.RadioField @label='Avocado' @value='avocado' data-radio-1 />
      <group.RadioField @label='Broccoli' @value='broccoli' data-radio-2 />
    </form.RadioGroup>

    <form.FileInput
      @label='Files to attach'
      @trigger='Select files'
      @deleteLabel='Delete'
      @name='files'
    />

    <form.Autocomplete
      @contentClass='z-10'
      @label='Color'
      @name='color'
      @noResultsText='No results'
      @options={{this.options}}
      as |autocomplete|
    >
      <autocomplete.Option>
        {{autocomplete.option}}
      </autocomplete.Option>
    </form.Autocomplete>

    <form.Multiselect
      @contentClass='z-10'
      @label='Multiselect'
      @name='multiselect'
      @options={{this.options}}
    >
      <:noResults>No results</:noResults>

      <:chip as |chip|>
        <chip.Chip>
          {{chip.option}}
          <chip.Remove @label={{(concat 'Remove' ' ' chip.option)}} />
        </chip.Chip>
      </:chip>

      <:default as |multiselect|>
        <multiselect.Option>{{multiselect.option}}</multiselect.Option>
      </:default>
    </form.Multiselect>

    <form.Checkbox @label='Agree to the Terms' @name='terms' />

    <Button class='w-full' type='submit'>Submit</Button>
  </ToucanForm>
</div>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import {
  validatePresence,
  validateFormat,
  validateLength,
} from 'ember-changeset-validations/validators';

export default class extends Component {
  data = {};

  validations = {
    color: validatePresence(true),
    comment: validatePresence(true),
    description: [validatePresence(true), validateLength({ max: 255 })],
    files: validatePresence(true),
    firstName: validatePresence(true),
    fruit: validatePresence(true),
    lastName: [validatePresence(true), validateLength({ max: 255 })],
    multiselect: validatePresence(true),
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
  ].map(({ label }) => label);

  handleSubmit(data) {
    console.log({ data: data.get('pendingData') });

    alert(
      `Form submitted with:\n${Object.entries(data.get('pendingData'))
        .map(([key, value]) => `${key}: ${value}`)
        .join('\n')}`
    );
  }
}
```
