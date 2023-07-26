# Multiselect

Provides a Toucan-styled multiselect with filtering.
If you are building forms, you may be interested in the [MultiselectField](./multiselect-field) component instead.

## Popover z-index

A CSS class to add to this component's content container. Commonly used to specify a `z-index`.

```hbs
<Form::Controls::Multiselect @contentClass='z-50' />
```

## Chip Block

Required.

A `:chip` block is required and is used for rendering each selected option. The block returns the following:

- `index`: The index of the current chip
- `option`: The raw option value for the current chip
- `Chip`: The Chip component
- `Remove`: The Remove component

The `Chip` component allows for slight customization to the underlying chip.

```hbs
<:chip as |chip|>
  <chip.Chip class='max-w-[4rem]' data-chip>
    <CustomTruncationComponent>{{chip.option}}</CustomTruncationComponent>
    <chip.Remove @label={{(concat 'Remove' ' ' chip.option)}} />
  </chip.Chip>
</:chip>
```

The `Remove` component contains the removal `X` on each selected chip. Clicking the button will remove the item from the selected options array. When the multiselect is disabled or in the readonly state, the button will not be available.

A `@label` argument is **required** for accessibility reasons for the Remove component.

The `option` for that chip is yielded back to the consumer so that an appropriate message can be constructed for screenreaders.

```hbs
<Form::Controls::Multiselect
  @onChange={{this.onChange}}
  @options={{this.options}}
  @contentClass='z-10'
  @selected={{this.selected}}
  placeholder='Colors'
>
  <:noResults>No results</:noResults>

  <:chip as |chip|>
    <chip.Chip>
      {{chip.option}}
      <chip.Remove @label={{(concat 'Remove' ' ' chip.option)}} />
    </chip.Chip>
  </:chip>

  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Controls::Multiselect>
```

An example with translations may be something like:

```hbs
<Form::Controls::Multiselect
  @onChange={{this.onChange}}
  @options={{this.options}}
  @contentClass='z-10'
  @selected={{this.selected}}
  placeholder='Colors'
>
  <:noResults>No results</:noResults>

  <:chip as |chip|>
    <chip.Chip>
      {{chip.option}}
      <chip.Remove @label={{(t 'some-key' name=remove.option)}} />
    </chip.Chip>
  </:chip>

  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Controls::Multiselect>
```

## No Results Block

A `:noResults` block is required and exposed to allow consumers to specify text when there are no results after filtering the options. Since it is a named block, any content can be rendered inside; however, we recommend only putting text as the content.

```hbs
<Form::Controls::Multiselect
  @contentClass='z-10'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selected={{this.selected}}
  placeholder='Colors'
>
  <!-- NOTE: Only text should go here. Please do not render content! -->
  <:noResults>No results</:noResults>

  <:chip as |chip|>
    <chip.Chip>
      {{chip.option}}
      <chip.Remove @label={{(concat 'Remove' ' ' chip.option)}} />
    </chip.Chip>
  </:chip>

  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Controls::Multiselect>
```

## Options

`@options` forms the content of this component.

```hbs
<Form::Controls::Multiselect @options={{this.options}}>
  <:default as |multiselect|>
    <!-- The content of each popover list item will be rendered here -->
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Controls::Multiselect>
```

## Selected

The currently selected option.

```hbs
<Form::Controls::Multiselect
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
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

## onFilter

Optional.

The built-in filtering does simple `String.prototype.startsWith` filtering.
Specify `onFilter` if you want to do something different.

```hbs
<Form::Controls::Multiselect
  @onFilter={{this.handleFilter}}
  @onChange={{this.handleChange}}
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
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
  ].map(({ label }) => label);

  @action
  handleChange(option) {
    this.selected = option;
  }

  @action
  handleFilter(value) {
    return this.options.filter((option) => option === value);
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
