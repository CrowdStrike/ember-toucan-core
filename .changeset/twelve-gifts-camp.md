---
'@crowdstrike/ember-toucan-core': patch
'@crowdstrike/ember-toucan-form': patch
---

Added a `Combobox` component to both core and form packages.

If you're using `toucan-core`, the control and field components are exposed:

```hbs
<Form::Controls::Combobox
  @onChange={{this.onChange}}
  @options={{this.options}}
  @contentClass='z-10'
  @selected={{this.selected}}
  @optionKey='label'
  @noResultsText='No results'
  placeholder='Colors'
  as |combobox|
>
  <combobox.Option>
    {{combobox.option.label}}
  </combobox.Option>
</Form::Controls::Combobox>

<Form::Fields::Combobox
  @contentClass='z-10'
  @error={{this.errorMessage}}
  @hint='Type "blue" into the field'
  @label='Label'
  @noResultsText='No results'
  @onChange={{this.onChange}}
  @optionKey='label'
  @options={{this.options}}
  @selected={{this.selected}}
  placeholder='Colors'
  as |combobox|
>
  <combobox.Option>
    {{combobox.option.label}}
  </combobox.Option>
</Form::Fields::Combobox>
```

If you're using `toucan-form`, the component is exposed via:

```hbs
<ToucanForm as |form|>
  <form.Combobox
    @label='Combobox'
    @name='combobox'
    @options={{options}}
    data-combobox
    as |combobox|
  >
    <combobox.Option data-option>{{combobox.option}}</combobox.Option>
  </form.Combobox>
</ToucanForm>
```

For more information on using these components, view [the docs](https://ember-toucan-core.pages.dev/docs/components/combobox).
