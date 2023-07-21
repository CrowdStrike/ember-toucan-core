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

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section of the Field.

### @hint

```hbs
<Form::Controls::Multiselect
  @contentClass='z-10'
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

## Remove Block

Required.

A `:remove` block is required and is used for the removal `X` on each selected chip. Clicking the button will remove the item from the selected options array. When the multiselect is disabled or in the readonly state, the button will not be available.

A `@label` argument is **required** for accessibility reasons for the Remove component.

The `option` for that chip is yielded back to the consumer so that an appropriate message can be constructed for screenreaders.

```hbs
<Form::Fields::Multiselect
  @contentClass='z-10'
  @label='Label'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:remove as |remove|>
    <remove.Remove @label={{(concat 'Remove' ' ' remove.option)}} />
  </:remove>

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
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:remove as |remove|>
    <remove.Remove @label={{(t 'some-key' name=remove.option)}} />
  </:remove>

  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Fields::Multiselect>
```

## No Results Block

Required.

A `:noResults` block is required and exposed to allow consumers to specify text when there are no results after filtering the options. Since it is a named block, any content can be rendered inside; however, we recommend only putting text as the content.

```hbs
<Form::Fields::Multiselect
  @contentClass='z-10'
  @onChange={{this.onChange}}
  @optionKey='label'
  @options={{this.options}}
  @selected={{this.selected}}
  placeholder='Colors'
>
  <!-- NOTE: Only text should go here. Please do not render content! -->
  <:noResults>No results</:noResults>

  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option.label}}
    </multiselect.Option>
  </:default>
</Form::Fields::Multiselect>
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

`@options` forms the content of this component. To support a variety of data shapes, `@options` is typed as `string[] | Record<string, unknown>[]`. `@options` is simply iterated over then passed back to you as a block parameter (`multiselect.option`).

```hbs
<Form::Fields::Multiselect @label='Label' @options={{this.options}}>
  <:default as |multiselect|>
    <!-- The content of each popover list item will be rendered here -->
    <multiselect.Option>
      {{multiselect.option.label}}
    </multiselect.Option>
  </:default>
</Form::Fields::Multiselect>
```

## Option Key

Optional.

The `@optionKey` argument is used when your `@options` take the shape of an array of objects. The `@optionKey` is used to determine two things internally:

1. The displayed value inside of each selected chip of the multiselect
2. Used as the key in the default filtering scenario where we filter `@options`. To properly filter the `@options` based on the user input from the textbox, we need to know how to compare the entered value to each object. The `@optionKey` tells us which key of the object to use for this filtering.

In the example below, we set `@optionKey='label'`. Our `@options` objects have a `label` key that we want displayed in each selected item chip. We also want our default filtering logic to use the `label` key.

```hbs
<Form::Fields::Multiselect
  @label='Label'
  @onChange={{this.handleChange}}
  @optionKey='label'
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:default as |multiselect|>
    <multiselect.Option @value={{multiselect.value}}>
      {{multiselect.option.label}}
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
}
```

## Selected

The currently selected options. Can be either an array of objects or strings. If `@options` is an array of strings, provide an array of strings. If `@options` is an array of objects, use an array of objects. Works in combination with `@onChange`.

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

## onFilter

Optional.

By default, when `@options` are an array of strings, the built-in filtering does simple `startsWith` filtering. When `@options` are an array of objects, the same filtering logic applies, but the key of each object is determined by the provided `@optionKey`. There may be cases where you need to write your own filtering logic completely that is more complex than the built-in `startsWith` filtering described. To do so, leverage `@onFilter` instead. This function should return an array of items that will then be used to populate the dropdown results.

```hbs
<Form::Fields::Multiselect
  @onChange={{this.handleChange}}
  @onFilter={{this.handleFilter}}
  @optionKey='label'
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
    return this.options.filter((option) => option.label === value);
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the input.

## Read Only State

Set the `@isReadOnly` argument to put the input in the read only state.

## Attributes and Modifiers

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
  >
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
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
  >
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
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
  >
    <:label>Label <svg class="inline w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
    <:hint>Hint text <a href="https://www.crowdstrike.com/">link</a></:hint>
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
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
  >
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
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
  >
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
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
  >
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
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
    @selected={{(array 'blue')}}
    @options={{(array 'blue' 'red')}}
  >
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
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
  >
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
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
  >
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
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
    @selected={{(array 'blue')}}
    @options={{(array 'blue' 'red')}}
  >
    <:noResults>No results</:noResults>
    <:remove as |remove|>
      <remove.Remove @label="Remove" />
    </:remove>
    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option}}
      </multiselect.Option>
    </:default>
  </Form::Fields::Multiselect>
</div>
