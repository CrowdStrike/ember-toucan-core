---
'@crowdstrike/ember-toucan-core': patch
'@crowdstrike/ember-toucan-form': patch
---

Added an `Autocomplete` component to both core and form packages.

If you're using `toucan-core`, the control and field components are exposed:

```hbs
<Form::Controls::Autocomplete
  @onChange={{this.onChange}}
  @options={{this.options}}
  @contentClass='z-10'
  @selected={{this.selected}}
  @optionKey='label'
  @noResultsText='No results'
  placeholder='Colors'
  as |autocomplete|
>
  <autocomplete.Option>
    {{autocomplete.option.label}}
  </autocomplete.Option>
</Form::Controls::Autocomplete>

<Form::Fields::Autocomplete
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
  as |autocomplete|
>
  <autocomplete.Option>
    {{autocomplete.option.label}}
  </autocomplete.Option>
</Form::Fields::Autocomplete>
```

If you're using `toucan-form`, the component is exposed via:

```hbs
<ToucanForm as |form|>
  <form.Autocomplete
    @label='Autocomplete'
    @name='autocomplete'
    @options={{options}}
    data-autocomplete
    as |autocomplete|
  >
    <autocomplete.Option data-option>
      {{autocomplete.option}}
    </autocomplete.Option>
  </form.Autocomplete>
</ToucanForm>
```

For more information on using these components, view [the docs](https://ember-toucan-core.pages.dev/docs/components/autocomplete).
