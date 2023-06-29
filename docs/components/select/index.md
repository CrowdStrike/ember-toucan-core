# Select 

Provides a Toucan-styled [select](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/select). 
If you are building forms, you may be interested in the SelectField component instead.

## `@options`

`@options` forms the content of this component.

To support a variety of data shapes, `@options` is typed as `unknown[]` and treated as though it were opaque.
`@options` is simply iterated over then passed back to you as a block parameter (`select.option`).

```hbs
<Form::Controls::Select @options={{array "Blue"}} as |select|>
  <select.Option as |select|>
    {{option}}
  </select.Option>
</Form::Controls::Select>
```

## `@onChange`

`@onChange` is called when the user makes a selection.
It is called with the selected option (derived from `@options`) as its only argument.

## `@selectedLabel`

Set the `@selectedLabel` argument to define what appears in the button that opens this component.
`@selectedLabel` overrides the `@placeholder` argument.

```hbs
<Form::Controls::Select @options={{array "Blue"}} as |select|>
  <select.Option 
    @isSelected={{if (eq select.option this.selectedOption) true false}} 
    @onChange={{this.onChange}}
  >
    {{option}}
  </select.Option>
</Form::Controls::Select>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selectedOption;

  @action
  onChange(option) {
    this.selectedOption = option;
  }
}
```

## `@placeholder`

Set the `@placeholder` argument to define what appears in the button that opens the popover.
`@placeholder` is overriden by `@selectedLabel` when `@selectedLabel` is truthy.

```hbs
<Form::Controls::Select @options={{array "Blue"}} as |select|>
  <select.Option 
    @isSelected={{if (eq select.option this.selectedOption) true false}} 
    @onChange={{this.onChange}}
  >
    {{select.option}}
  </select.Option>
</Form::Controls::Select>
```

## `@contentClass`

Set the `@contentClass` add a CSS class to this component's content container.
Commonly used to add a `z-index`.

```hbs
<Form::Controls::Select @contentClass="z-index" @options={{array "Blue"}} as |select|>
  <select.Option 
    @isSelected={{if (eq select.option this.selectedOption) true false}} 
    @onChange={{this.onChange}}
  >
    {{select.option}}
  </select.Option>
</Form::Controls::Select>
```

## `select.Option.@isSelected`

Set the `select.Option.@isSelected` argument to give an option a _selected_ visual treatment.

```hbs
<Form::Controls::Select @options={{array "Blue"}} as |select|>
  <select.Option 
    @isSelected={{if (eq select.option this.selectedOption) true false}} 
  >
    {{select.option}}
  </select.Option>
</Form::Controls::Select>
```

## `@isDisabled`

Set the `@isDisabled` argument to omit the component from form submissions and to prevent the user from making a selection.

```hbs
<Form::Controls::Input @isDisabled={{true}} />
```

## `@isReadOnly`

Set the `@isReadOnly` argument to prevent the user from making a selection.

```hbs
<Form::Controls::Input @isReadOnly={{true}} />
```

## `@hasError`

Set the `@hasError` argument to apply an error box shadow.
