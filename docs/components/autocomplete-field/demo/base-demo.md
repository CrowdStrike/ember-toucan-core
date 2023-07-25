```hbs template
<div class='w-96'>
  <Form::Fields::Autocomplete
    @contentClass='z-10'
    @error={{this.errorMessage}}
    @hint='Type "blue" into the field'
    @label='Label'
    @noResultsText='No results'
    @onChange={{this.onChange}}
    @options={{this.options}}
    @selected={{this.selected}}
    placeholder='Colors'
    as |autocomplete|
  >
    <autocomplete.Option>
      {{autocomplete.option}}
    </autocomplete.Option>
  </Form::Fields::Autocomplete>
</div>
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
  ].map(({ label }) => label);

  @action
  onChange(option) {
    this.selected = option;
    console.log(option);

    if (option !== 'Blue') {
      this.errorMessage = 'Please select "Blue"';
      return;
    }

    this.errorMessage = null;
  }
}
```
