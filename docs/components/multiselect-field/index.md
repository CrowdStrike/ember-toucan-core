# Multiselect Field

Provides a Toucan-styled multiselect with filtering that builds on top of the Field component.

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the Label section of the Field.

### `@label`

```hbs
<Form::Controls::Multiselect
  @contentClass='z-10'
  @label='Label'
  @noResultsText='No results'
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

### `:label`

```hbs
<Form::Controls::Multiselect
  @contentClass='z-10'
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>

  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Controls::Multiselect>
```

## Chip Block

Required.

A `:chip` block is required and is used for rendering each selected option.
The block has the following block parameters:

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
<Form::Fields::Multiselect
  @contentClass='z-10'
  @label='Label'
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @options={{this.options}}
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
</Form::Fields::Multiselect>
```

An example with translations may be something like:

```hbs
<Form::Fields::Multiselect
  @contentClass='z-10'
  @label='Label'
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selected={{this.selected}}
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
</Form::Fields::Multiselect>
```

## No results text

Required.

`@noResultsText` is shown when there are no results after filtering.

```hbs
<Form::Fields::Multiselect
  @contentClass='z-10'
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selected={{this.selected}}
  placeholder='Colors'
>
  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Fields::Multiselect>
```

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section of the Field.

### @hint

```hbs
<Form::Controls::Multiselect
  @contentClass='z-10'
  @noResultsText='No results'
  @hint='Here is a hint'
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

### `:hint`

```hbs
<Form::Controls::Multiselect
  @contentClass='z-10'
  @label='Label'
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>

  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Controls::Multiselect>
```

## Error

Optional.

Provide a string or array of strings to `@error` to render the text into the Error section of the Field.

```hbs
<Form::Fields::Multiselect @label='Single error' @error='Error' />
```

```hbs
<Form::Fields::Multiselect
  @label='Label'
  @error={{(array 'Error 1' 'Error 2')}}
/>
```

## `@onChange`

Provide an `@onChange` callback to be notified when the user's selections have changed.
`@onChange` will receive the selected values as its only argument.

```hbs
<Form::Fields::Multiselect
  @label='Label'
  @onChange={{this.onChange}}
  @selected={{this.selected}}
  @options={{this.options}}
>
  <:default as |multiselect|>
    <multiselect.Option @value={{multiselect.value}}>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Fields::Multiselect>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class extends Component {
  @tracked selected;

  options = ['Blue', 'Red', 'Yellow'];

  @action
  handleChange(option) {
    this.selected = option;
  }
}
```

## Options

Required.

`@options` forms the content of this component.

```hbs
<Form::Fields::Multiselect @label='Label' @options={{this.options}}>
  <:default as |multiselect|>
    <!-- The content of each popover list item will be rendered here -->
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Fields::Multiselect>
```

## Selected

Optional.

The currently selected option.

```hbs
<Form::Fields::Multiselect
  @label='Label'
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Fields::Multiselect>
```

```js
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;
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
<Form::Fields::Multiselect
  @contentClass='z-10'
  @label='Label'
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
</Form::Fields::Multiselect>
```

## onFilter

Optional.

The built-in filtering does simple `String.prototype.startsWith` filtering.
Specify `onFilter` if you want to do something different.

```hbs
<Form::Fields::Multiselect
  @onChange={{this.handleChange}}
  @onFilter={{this.handleFilter}}
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Fields::Multiselect>
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
    return this.options.filter((option) => option === value);
  }
}
```

## Disabled State

Optional.

Set the `@isDisabled` argument to disable the input.

## Read Only State

Optional.

Set the `@isReadOnly` argument to put the input in the read only state.

## Attributes and Modifiers

Optional.

Consumers have direct access to the underlying [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input), so all attributes are supported.
Modifiers can also be added directly to the input.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`.
This test selector will be used as the value for the `data-root-field` attribute.
The Field can be targeted via:

```hbs
<Form::Fields::Multiselect @label='Label' @rootTestSelector='example' />
```

```js
assert.dom('[data-root-field="example"]');
// targeting this field's specific label
assert.dom('[data-root-field="example"] > [data-label]');
```

### Label

Target the label element via `data-label`.

### Hint

Target the hint block via `data-hint`.

### Error

Target the error block via `data-error`.

## UI States

### MultiselectField with `@label`

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @label='Label'
    @noResultsText='No results'
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>

### MultiselectField with `@label` and `@hint`

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @label='Label'
    @hint="Hint"
    @noResultsText='No results'
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>

### MultiselectField with `:label` and `:hint` blocks

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @noResultsText='No results'
  >
    <:label>Label <svg class="inline w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
    <:hint>Hint text <a href="https://www.crowdstrike.com/">link</a></:hint>
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>

### MultiselectField with `@label` and `@error`

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @label='Label'
    @error='With error text'
    @noResultsText='No results'
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>

### MultiselectField with `@label`, `@hint`, and `@error`

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @label='Label'
    @hint='With hint text'
    @error='With error text'
    @noResultsText='No results'
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>

### MultiselectField with `@label` and `@isDisabled`

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @label='Label'
    @isDisabled={{true}}
    @noResultsText='No results'
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>

### MultiselectField with `@label`, `@selected`, and `@isDisabled`

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @label='Label'
    @isDisabled={{true}}
    @noResultsText='No results'
    @options={{(array 'blue' 'red')}}
    @selected={{(array 'blue')}}
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>

### MultiselectField with multiple errors

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @label='Label'
    @error={{(array 'With error 1' 'With error 2' 'With error 3')}}
    @noResultsText='No results'
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>

### MultiselectField with `@isReadOnly`

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @label='Label'
    @isReadOnly={{true}}
    @noResultsText='No results'
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>

### MultiselectField with `@isReadOnly` and `@selected`

<div class='mb-4 w-64'>
  <Form::Fields::Multiselect
    @contentClass='z-10'
    @label='Label'
    @isReadOnly={{true}}
    @noResultsText='No results'
    @options={{(array 'blue' 'red')}}
    @selected={{(array 'blue')}}
  >
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label="Remove" />
      </chip.Chip>
    </:chip>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>
