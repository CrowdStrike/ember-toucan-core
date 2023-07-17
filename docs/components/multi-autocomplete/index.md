# MultiAutocomplete

Provides a Toucan-styled autocomplete with filtering.
If you are building forms, you may be interested in the [AutocompleteField](./autocomplete-field) component instead.

## Popover z-index

A CSS class to add to this component's content container. Commonly used to specify a `z-index`.

```hbs
<Form::Controls::Autocomplete @contentClass='z-50' />
```

## Options

`@options` forms the content of this component. To support a variety of data shapes, `@options` is typed as `unknown[]` and treated as though it were opaque. `@options` is simply iterated over then passed back to you as a block parameter (`autocomplete.option`).

```hbs
<Form::Controls::Autocomplete
  @options={{this.options}}
  @selected={{this.selected}}
  as |autocomplete|
>
  <autocomplete.Option>
    <!-- The content of each popover list item will be rendered here -->
    {{autocomplete.option}}
  </autocomplete.Option>
</Form::Controls::Autocomplete>
```

## Selected

The currently selected option. Can be either an object or a string. If `@options` is an array of strings, provide a string. If `@options` is an array of objects, pass the entire object. Works in combination with `@onChange`.

```hbs
<Form::Controls::Autocomplete
  @options={{this.options}}
  @selected={{this.selected}}
  as |autocomplete|
>
  <autocomplete.Option>
    <!-- The content of each popover list item will be rendered here -->
    {{autocomplete.option}}
  </autocomplete.Option>
</Form::Controls::Autocomplete>
```

```js
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;
}
```

## onChange

Called when the user makes a selection. It is called with the selected option (derived from `@options`) as its only argument. You'll want to update `@selected` with the new value in your on change handler.

```hbs
<Form::Controls::Autocomplete
  @onChange={{this.handleChange}}
  @options={{this.options}}
  @selected={{this.selected}}
  as |autocomplete|
>
  <autocomplete.Option>
    {{autocomplete.option}}
  </autocomplete.Option>
</Form::Controls::Autocomplete>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;

  options = ['Blue', 'Red', 'Yellow'];

  @action
  handleChange(option) {
    this.selected = option;
  }
}
```

## Option Key

Optional.

The `@optionKey` argument is used when your `@options` take the shape of an array of objects. The `@optionKey` is used to determine two things internally:

1. The displayed value inside of the input of the autocomplete
2. Used as the key in the default filtering scenario where we filter `@options`. To properly filter the `@options` based on the user input from the textbox, we need to know how to compare the entered value to each object. The `@optionKey` tells us which key of the object to use for this filtering.

In the example below, we set `@optionKey='label'`. Our `@options` objects have a `label` key and we want the label of the selected option to be used for the selected value, as well as for filtering as the user types.

```hbs
<Form::Controls::Autocomplete
  @onChange={{this.handleChange}}
  @options={{this.options}}
  @optionKey='label'
  @selected={{this.selected}}
  as |autocomplete|
>
  <autocomplete.Option>
    {{autocomplete.option.label}}
  </autocomplete.Option>
</Form::Controls::Autocomplete>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;

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

  @action
  handleChange(option) {
    this.selected = option;
  }
}
```

## onFilter

Optional.

By default, when `@options` are an array of strings, the built-in filtering does simple `startsWith` filtering. When `@options` are an array of objects, the same filtering logic applies, but the key of each object is determined by the provided `@optionKey`. There may be cases where you need to write your own filtering logic completely that is more complex than the built-in `startsWith` filtering described. To do so, leverage `@onFilter` instead. This function should return an array of items that will then be used to populate the dropdown results.

```hbs
<Form::Controls::Autocomplete
  @onFilter={{this.handleFilter}}
  @onChange={{this.handleChange}}
  @options={{this.options}}
  @optionKey='label'
  @selected={{this.selected}}
  as |autocomplete|
>
  <autocomplete.Option>
    {{autocomplete.option}}
  </autocomplete.Option>
</Form::Controls::Autocomplete>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;

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

  @action
  handleChange(option) {
    this.selected = option;
  }

  @action
  handleFilter(value) {
    return this.options.filter((option) => option.label === value);
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the input.

```hbs
<Form::Controls::Autocomplete @isDisabled={{true}} />
```

## Read Only State

Set the `@isReadOnly` argument to put the input in the read only state.

```hbs
<Form::Controls::Autocomplete @isReadOnly={{true}} />
```

## Error State

Set the `@hasError` argument to apply an error box shadow to the `<input>`.

```hbs
<Form::Controls::Autocomplete @hasError={{true}} />
```
