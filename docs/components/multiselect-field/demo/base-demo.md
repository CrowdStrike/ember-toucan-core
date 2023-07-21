```hbs template
<div class='flex flex-col gap-4 w-96'>
  <Form::Fields::Multiselect
    @label='Label'
    @hint='Select a color'
    @contentClass='z-10'
    @onChange={{this.onChange}}
    @optionKey='label'
    @options={{this.options}}
    @selected={{this.selected}}
    placeholder='Colors'
  >
    <:noResults>No results</:noResults>

    <:remove as |remove|>
      <remove.Remove @label={{(concat 'Remove' ' ' remove.option.label)}} />
    </:remove>

    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option.label}}
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
  ];

  @action
  onChange(option) {
    this.selected = option;
    console.log(option);
  }
}
```
