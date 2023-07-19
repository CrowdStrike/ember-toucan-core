# Multiselect

Provides a Toucan-styled multiselect with filtering.
If you are building forms, you may be interested in the [MultiselectField](./multiselect-field) component instead.

## Popover z-index

A CSS class to add to this component's content container. Commonly used to specify a `z-index`.

```hbs
<Form::Controls::Multiselect @contentClass='z-50' />
```

## Options

`@options` forms the content of this component. To support a variety of data shapes, `@options` is typed as `unknown[]` and treated as though it were opaque. `@options` is simply iterated over then passed back to you as a block parameter (`multiselect.option`).

```hbs
<Form::Controls::Multiselect
  @options={{this.options}}
  @selected={{this.selected}}
  as |multiselect|
>
  <multiselect.Option>
    <!-- The content of each popover list item will be rendered here -->
    {{multiselect.option}}
  </multiselect.Option>
</Form::Controls::Multiselect>
```

## Selected

The currently selected options. Can be either an array of objects or strings. If `@options` is an array of strings, provide an array of strings. If `@options` is an array of objects, use an array of objects. Works in combination with `@onChange`.

```hbs
<Form::Controls::Multiselect
  @options={{this.options}}
  @selected={{this.selected}}
  as |multiselect|
>
  <multiselect.Option>
    <!-- The content of each popover list item will be rendered here -->
    {{multiselect.option}}
  </multiselect.Option>
</Form::Controls::Multiselect>
```

```js
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;
}
```

## onChange

Called when the user makes a selection. It is called with the entire array of selected options (derived from `@options`) as its only argument. You'll want to update `@selected` with the new value in your on change handler.

```hbs
<Form::Controls::Multiselect
  @onChange={{this.handleChange}}
  @options={{this.options}}
  @selected={{this.selected}}
  as |multiselect|
>
  <multiselect.Option>
    {{multiselect.option}}
  </multiselect.Option>
</Form::Controls::Multiselect>
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

1. The displayed value inside of each selected chip of the multiselect
2. Used as the key in the default filtering scenario where we filter `@options`. To properly filter the `@options` based on the user input from the textbox, we need to know how to compare the entered value to each object. The `@optionKey` tells us which key of the object to use for this filtering.

In the example below, we set `@optionKey='label'`. Our `@options` objects have a `label` key and we want the label of the selected option to be used for the selected value, as well as for filtering as the user types.

```hbs
<Form::Controls::Multiselect
  @onChange={{this.handleChange}}
  @options={{this.options}}
  @optionKey='label'
  @selected={{this.selected}}
  as |multiselect|
>
  <multiselect.Option>
    {{multiselect.option.label}}
  </multiselect.Option>
</Form::Controls::Multiselect>
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

## Remove Button Labels

Toucan Core wants to provide accessible components, so a component argument of `@removeButtonLabelFunction` is exposed. This component argument is used to set the `aria-label` of each selected chip's remove button. This ensures screenreader users have all of the context they need when remove items from the selected list. The current option is returned to you so that you can format the string as you please. This comes in handy as well when dealing with translated strings.

```hbs
<Form::Controls::Multiselect
  @removeButtonLabelFunction={{this.removeButtonLabelFunction}}
/>
```

```js
removeButtonLabelFunction(option) {
  // Or if dealing with objects, this may be something like:
  // return `Remove ${option.label}`;
  return `Remove ${option}`;
}
```

## onFilter

Optional.

By default, when `@options` are an array of strings, the built-in filtering does simple `startsWith` filtering. When `@options` are an array of objects, the same filtering logic applies, but the key of each object is determined by the provided `@optionKey`. There may be cases where you need to write your own filtering logic completely that is more complex than the built-in `startsWith` filtering described. To do so, leverage `@onFilter` instead. This function should return an array of items that will then be used to populate the dropdown results.

```hbs
<Form::Controls::Multiselect
  @onFilter={{this.handleFilter}}
  @onChange={{this.handleChange}}
  @options={{this.options}}
  @optionKey='label'
  @selected={{this.selected}}
  as |multiselect|
>
  <multiselect.Option>
    {{multiselect.option}}
  </multiselect.Option>
</Form::Controls::Multiselect>
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
<Form::Controls::Multiselect @isDisabled={{true}} />
```

## Read Only State

Set the `@isReadOnly` argument to put the input in the read only state.

```hbs
<Form::Controls::Multiselect @isReadOnly={{true}} />
```

## Error State

Set the `@hasError` argument to apply an error box shadow to the `<input>`.

```hbs
<Form::Controls::Multiselect @hasError={{true}} />
```

## Test Selectors

### Container

`data-multiselect-container` is provided to target the wrapping div element for the entire component.

```js
assert.dom('[data-multiselect-container]').hasClass('bg-overlay');
```

### Selected Chips

Target selected chips via `data-multiselect-selected-option`.

```js
// Query how many selected chips there are
assert.dom('[data-multiselect-selected-option]').exists({ count: 2 });
```

### Select Chip Remove Button

Target a selected chip's remove button via `data-multiselect-remove-option`.

```js
// Query how many remove buttons there are
assert.dom('[data-multiselect-remove-option]').exists({ count: 3 });

// Click a particular remove button
let removeButtons = document.querySelectorAll(
  '[data-multiselect-remove-option]'
);
await click(removeButtons[1]);
```
