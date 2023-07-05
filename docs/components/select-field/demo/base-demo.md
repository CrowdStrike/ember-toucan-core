```hbs template
<Form::Fields::Select
  @label='Label'
  @hint='Type "blue" into the field'
  @error={{this.errorMessage}}
  @onChange={{this.onChange}}
  @options={{this.options}}
  @contentClass='z-10'
  @selected={{this.selected}}
  @selectedLabel={{this.selected.label}}
  @optionKey='label'
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
