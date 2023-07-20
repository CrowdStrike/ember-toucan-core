---
'@crowdstrike/ember-toucan-core': patch
---

Added an `Multiselect` component.

It has a similar API to `Autocomplete`, but allows for selecting multiple options rather than only one.

```hbs
<Form::Controls::Multiselect
  @onChange={{this.onChange}}
  @options={{this.options}}
  @contentClass='z-10'
  @selected={{this.selected}}
  @optionKey='label'
  placeholder='Colors'
>
  <:noResults>No results</:noResults>

  <!-- NOTE: The remove block is required and a Remove component's label is also required! -->
  <:remove as |remove|>
    <remove.Remove @label={{(concat 'Remove' ' ' remove.option.label)}} />
  </:remove>

  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option.label}}
    </multiselect.Option>
  </:default>
</Form::Controls::Multiselect>
```