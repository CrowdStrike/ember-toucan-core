```hbs template
<div class='flex flex-col gap-4 w-96'>
  <Form::Controls::Autocomplete
    @onChange={{this.onChange}}
    @options={{this.options}}
    @contentClass='z-10'
    @selected={{this.selected}}
    @noResultsText='No results'
    placeholder='Colors'
    as |autocomplete|
  >
    <autocomplete.Option>
      {{autocomplete.option}}
    </autocomplete.Option>
  </Form::Controls::Autocomplete>

  <Form::Controls::Autocomplete
    @onChange={{this.onChange2}}
    @options={{this.options2}}
    @contentClass='z-10'
    @selected={{this.selected2}}
    @noResultsText='No results'
    placeholder='Names'
    as |autocomplete|
  >
    <autocomplete.Option>
      {{autocomplete.option}}
    </autocomplete.Option>
  </Form::Controls::Autocomplete>

  <Form::Controls::Autocomplete
    @onChange={{this.onChange3}}
    @options={{this.options}}
    @contentClass='z-10'
    @selected={{this.selected3}}
    @onFilter={{this.onFilter}}
    @noResultsText='No results'
    placeholder='Colors w/ Filtering'
    as |autocomplete|
  >
    <autocomplete.Option>
      {{autocomplete.option}}
    </autocomplete.Option>
  </Form::Controls::Autocomplete>
</div>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;
  @tracked selected2;
  @tracked selected3;

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

  options2 = [
    'Billy',
    'Bob',
    'Cameron',
    'Clinton',
    'Daniel',
    'David',
    'Mary',
    'Nicole',
    'Simon',
    'Tony',
  ];

  @action
  onChange(option) {
    this.selected = option;
    console.log(option);
  }

  @action
  onChange2(option) {
    this.selected2 = option;
    console.log(option);
  }

  @action
  onChange3(option) {
    this.selected3 = option;
    console.log(option);
  }

  @action
  onFilter(value) {
    console.log(`filtering with the value "${value}"`);

    return value === ''
      ? this.options
      : this.options.filter((option) => {
        return option.toLowerCase().includes(value.toLowerCase())
      });
  }
}
```
