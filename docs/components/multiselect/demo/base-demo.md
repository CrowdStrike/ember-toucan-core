```hbs template
<div class='flex flex-col gap-4 w-96'>
  <Form::Controls::Multiselect
    @onChange={{this.onChange}}
    @options={{this.options}}
    @contentClass='z-10'
    @removeButtonLabelFunction={{this.formatRemoveButtonAriaLabelStringObject}}
    @selected={{this.selected}}
    @optionKey='label'
    @noResultsText='No results'
    placeholder='Colors'
    as |multiselect|
  >
    <multiselect.Option>
      {{multiselect.option.label}}
    </multiselect.Option>
  </Form::Controls::Multiselect>

  <Form::Controls::Multiselect
    @onChange={{this.onChange2}}
    @options={{this.options2}}
    @contentClass='z-10'
    @removeButtonLabelFunction={{this.formatRemoveButtonAriaLabelString}}
    @selected={{this.selected2}}
    @noResultsText='No results'
    placeholder='Names'
    as |multiselect|
  >
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </Form::Controls::Multiselect>

  <Form::Controls::Multiselect
    @onChange={{this.onChange3}}
    @options={{this.options}}
    @contentClass='z-10'
    @removeButtonLabelFunction={{this.formatRemoveButtonAriaLabelStringObject}}
    @selected={{this.selected3}}
    @optionKey='label'
    @onFilter={{this.onFilterBy}}
    @noResultsText='No results'
    placeholder='Colors w/ Filtering'
    as |multiselect|
  >
    <multiselect.Option>
      {{multiselect.option.label}}
    </multiselect.Option>
  </Form::Controls::Multiselect>
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
  ];

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

  formatRemoveButtonAriaLabelString(option) {
    return `Remove ${option}`;
  }

  formatRemoveButtonAriaLabelStringObject(option) {
    return `Remove ${option.label}`;
  }

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
  onFilterBy(input) {
    console.log(`filtering with the value "${input}"`);

    if (input.length > 0) {
      return this.options.filter((option) =>
        option.label.toLowerCase().startsWith(input.toLowerCase())
      );
    } else {
      return this.options;
    }
  }
}
```
