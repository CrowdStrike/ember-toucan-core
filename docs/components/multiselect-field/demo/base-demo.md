```hbs template
<div class='w-96'>
  <Form::Fields::Multiselect
    @label='Label'
    @hint='Select a color'
    @contentClass='z-10'
    @onChange={{this.onChange}}
    @options={{this.options}}
    @noResultsText="No results"
    @selected={{this.selected}}
    placeholder='Colors'
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label={{(concat 'Remove' ' ' chip.option)}} />
      </chip.Chip>
    </:chip>

    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;

  options = [
    {
      label: 'Blue',
      name: 'blue',
      value: 'blue',
    },
    {
      label: 'Green',
      name: 'green',
      value: 'green',
    },
    {
      label: 'Yellow',
      name: 'yellow',
      value: 'yellow',
    },
    {
      label: 'Orange',
      name: 'orange',
      value: 'orange',
    },
    {
      label: 'Red',
      name: 'red',
      value: 'red',
    },
    {
      label: 'Purple',
      name: 'purple',
      value: 'purple',
    },
    {
      label: 'Teal',
      name: 'teal',
      value: 'teal',
    },
  ].map(({ label }) => label);

  @action
  onChange(option) {
    this.selected = option;
    console.log(option);
  }
}
```
