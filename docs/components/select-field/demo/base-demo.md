```hbs template
<Form::Fields::Select
  @contentClass='z-10'
  @error={{this.errorMessage}}
  @hint='Type "blue" into the field'
  @label='Label'
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @optionKey='label'
  @options={{this.options}}
  @selected={{this.selected}}
  placeholder='Colors'
  as |select|
>
  <select.Option>
    {{select.option.label}}
  </select.Option>
</Form::Fields::Select>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;
  @tracked errorMessage;

  options = [
    {
      label: 'Blue',
      name: 'blue',
    },
    {
      label: 'Green',
      name: 'green',
    },
    {
      label: 'Yellow',
      name: 'yellow',
    },
    {
      label: 'Orange',
      name: 'orange',
    },
    {
      label: 'Red',
      name: 'red',
    },
    {
      label: 'Purple',
      name: 'purple',
    },
    {
      label: 'Teal',
      name: 'teal',
    },
  ];

  @action
  onChange(option) {
    this.selected = option;
    console.log(option);

    if (option.label !== 'Blue') {
      this.errorMessage = 'Please select "Blue"';
      return;
    }

    this.errorMessage = null;
  }
}
```
