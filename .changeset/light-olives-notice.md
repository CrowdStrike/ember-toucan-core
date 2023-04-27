---
'@crowdstrike/ember-toucan-form': patch
---

Exposed named blocks from the underlying `toucan-core` components. This allows users to add custom content in `:hint` or `:label` named blocks. You can combine the arguments and named blocks as well! Below are some examples.

```hbs
<ToucanForm @data={{data}} as |form|>
  <form.Textarea @name='comment'>
    <:label>Label</:label>
    <:hint>Hint</:hint>
  </form.Textarea>
</ToucanForm>
```

```hbs
<ToucanForm @data={{data}} as |form|>
  <form.Textarea @label='Label' @name='comment'>
    <:hint>Hint</:hint>
  </form.Textarea>
</ToucanForm>
```

```hbs
<ToucanForm @data={{data}} as |form|>
  <form.Textarea @hint='Hint' @name='comment'>
    <:label>Label</:label>
  </form.Textarea>
</ToucanForm>
```

Or you can continue to use the arguments if you're only working with strings!

```hbs
<ToucanForm @data={{data}} as |form|>
  <form.Textarea @label='Label' @hint='Hint' @name='comment' />
</ToucanForm>
```
