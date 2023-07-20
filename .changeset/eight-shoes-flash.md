---
'@crowdstrike/ember-toucan-form': patch
---

Expose the `:secondary` block and Character Counter component from `<ToucanForm` input and textarea components.

```hbs
<ToucanForm @data={{data}} as |form|>
  <form.Input @name='input'>
    <:label>Label</:label>
    <:hint>Hint</:hint>
    <:secondary as |secondary|>
      <secondary.CharacterCount @max={{255}} />
    </:secondary>
  </form.Input>

  <form.Textarea @name='textarea'>
    <:label>Label</:label>
    <:hint>Hint</:hint>
    <:secondary as |secondary|>
      <secondary.CharacterCount @max={{255}} />
    </:secondary>
  </form.Textarea>
</ToucanForm>
```
