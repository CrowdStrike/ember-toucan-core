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

    <:remove as |remove|>
      <remove.Remove @label={{(concat 'Remove' ' ' remove.option)}} />
    </:remove>

    <:default as |multiselect|>
      <multiselect.Option>{{multiselect.option}}</multiselect.Option>
    </:default>
  </form.Multiselect>
</ToucanForm>
```
