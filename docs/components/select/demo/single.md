```hbs template
<form class='flex flex-col gap-4 w-96'>
  <Form::Controls::Select
    @onChange={{this.onChange}}
    @options={{this.options}}
    @contentClass='z-10'
    @selectedLabel={{this.selected.label}}
    placeholder='Colors'
    as |select|
  >
    <select.Option
      @isSelected={{if
        (this.isEqual select.option.value this.selected.value)
        true
        false
      }}
    >
      {{select.option.label}}
    </select.Option>
  </Form::Controls::Select>
</form>
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

  isEqual(one: unknown, two: unknown) {
    return Object.is(one, two);
  }

  @action
  onChange(option) {
    this.selected = option;
  }
}
```
