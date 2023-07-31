# Autocomplete

Provides a Toucan-styled autocomplete with filtering.
If you are building forms, you may be interested in the [AutocompleteField](./autocomplete-field) component instead.

## No results text

Required.

`@noResultsText` is shown when there are no results after filtering. 

```hbs
<Form::Controls::Autocomplete
  @noResultsText='No results'
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

## Popover z-index

Optional.

A CSS class to add to this component's content container. Commonly used to specify a `z-index`.

```hbs
<Form::Controls::Autocomplete @contentClass='z-50' />
```

## Options

Optional.

`@options` forms the content of this component. 

```hbs
<Form::Controls::Autocomplete
  @noResultsText='No results'
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

Optional.

The currently selected option.

```hbs
<Form::Controls::Autocomplete
  @noResultsText='No results'
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

Optional.

Called when the user makes a selection. 
It is called with the selected option (derived from `@options`) as its only argument. 
You'll want to update `@selected` with the new value in your on change handler.

```hbs
<Form::Controls::Autocomplete
  @noResultsText='No results'
  @onChange={{this.onChange}}
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
  onChange(option) {
    this.selected = option;
  }
}
```

## onFilter

Optional.

By default, when `@options` are an array of strings, the built-in filtering does simple `String.prototype.startsWith` filtering. 
There may be cases where you need to write your own filtering logic completely that is more complex than the built-in `String.prototype.startsWith` filtering described. 
To do so, leverage `@onFilter` instead. This function should return an array of items that will then be used to populate the dropdown results.

```hbs
<Form::Controls::Autocomplete
  @noResultsText='No results'
  @onFilter={{this.onFilter}}
  @onChange={{this.onChange}}
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
  onChange(option) {
    this.selected = option;
  }

  @action
  onFilter(value) {
    return this.options.filter((option) => option === value);
  }
}
```

## Disabled State

Optional.

Set the `@isDisabled` argument to disable the input.

```hbs
<Form::Controls::Autocomplete @isDisabled={{true}} />
```

## Read Only State

Optional.

Set the `@isReadOnly` argument to put the input in the read only state.

```hbs
<Form::Controls::Autocomplete @isReadOnly={{true}} />
```

## Error State

Optional.

Set the `@hasError` argument to apply an error box shadow to the `<input>`.

```hbs
<Form::Controls::Autocomplete @hasError={{true}} />
```
