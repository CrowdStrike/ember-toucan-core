---
'@crowdstrike/ember-toucan-form': patch
---

Added `form.Multiselect` support.

```hbs
<ToucanForm @data={{data}} as |form|>
  <form.Multiselect
    @label='Label'
    @hint='Hint'
    @name='selection'
    @options={{this.options}}
  >
    <:noResults>No results</:noResults>

    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label={{(concat 'Remove' ' ' chip.option)}} />
      </chip.Chip>
    </:chip>

    <:default as |multiselect|>
      <multiselect.Option>{{multiselect.option}}</multiselect.Option>
    </:default>
  </form.Multiselect>
</ToucanForm>
```
