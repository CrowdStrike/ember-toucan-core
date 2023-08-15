# Multiselect

Provides a Toucan-styled multiselect with filtering.
If you are building forms, you may be interested in the [MultiselectField](./multiselect-field) component instead.

## Chip Block

Required.

A `:chip` block is required and is used for rendering each selected option.
The block returns the following:

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

The `Remove` component contains the removal `X` on each selected chip.
Clicking the button will remove the item from the selected options array.
When the multiselect is disabled or in the readonly state, the button will not be available.

A `@label` argument is **required** for accessibility reasons for the Remove component.

The `option` for that chip is yielded back to the consumer so that an appropriate message can be constructed for screenreaders.

```hbs
<Form::Controls::Multiselect
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @contentClass='z-10'
  @selected={{this.selected}}
  placeholder='Colors'
>
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
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @contentClass='z-10'
  @selected={{this.selected}}
  placeholder='Colors'
>
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

## No results text

Required.

`@noResultsText` is shown when there are no results after filtering.

```hbs
<Form::Controls::Multiselect
  @contentClass='z-10'
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selected={{this.selected}}
  placeholder='Colors'
>
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

## Popover z-index

Optional.

A CSS class to add to this component's content container. Commonly used to specify a `z-index`.

```hbs
<Form::Controls::Multiselect @contentClass='z-50' />
```

## Options

Optional.

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

Optional.

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

Optional.

Called when the user makes a selection. It is called with the entire array of selected options (derived from `@options`) as its only argument. You'll want to update `@selected` with the new value in your on change handler.

```hbs
<Form::Controls::Multiselect
  @onChange={{this.onChange}}
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
  onChange(option) {
    this.selected = option;
  }
}
```

## Select all

Optional.

"Select all" functionality can be opted into by providing the `@selectAllText` argument.

By providing this argument, a checkbox will be rendered at the top of the list to allow users a convenient way to select all visible options. When clicking this item, all `@options` are returned to the `@onChange` handler. The "Select all" checkbox has the following state rules:

- The checkbox only appears when filtering is not active.
- The checkbox will be checked when all options are selected.
- If no options are selected, the checkbox will be unchecked.
- If more than one option is selected, but not all of them, then the checkbox will be in the indeterminate state.
- When the checkbox is in the indeterminate state, clicking the checkbox re-selects all options.

```hbs
<Form::Controls::Multiselect
  @contentClass='z-10'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selectAllText='Select all'
  @selected={{this.selected}}
>
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

## onFilter

Optional.

The built-in filtering does simple `String.prototype.startsWith` filtering.
Specify `onFilter` if you want to do something different.

```hbs
<Form::Controls::Multiselect
  @noResultsText='No results'
  @onFilter={{this.onFilter}}
  @onChange={{this.onChange}}
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
<Form::Controls::Multiselect @isDisabled={{true}} />
```

## Read Only State

Optional.

Set the `@isReadOnly` argument to put the input in the read only state.

```hbs
<Form::Controls::Multiselect @isReadOnly={{true}} />
```

## Error State

Optional.

Set the `@hasError` argument to apply an error box shadow to the `<input>`.

```hbs
<Form::Controls::Multiselect @hasError={{true}} />
```

## Test Helpers

Test helpers for selecting common elements are available via `@crowdstrike/ember-toucan-core/test-support`.
