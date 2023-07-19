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
  @removeButtonLabelFunction={{this.removeButtonLabelFunction}}
  @selected={{this.selected}}
  @optionKey='label'
  @noResultsText='No results'
  placeholder='Colors'
  as |multiselect|
>
  <multiselect.Option>
    {{multiselect.option.label}}
  </multiselect.Option>
</Form::Controls::Multiselect>
```
