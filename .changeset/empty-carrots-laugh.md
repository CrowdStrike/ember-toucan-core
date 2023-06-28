---
'@crowdstrike/ember-toucan-form': patch
---

The `ToucanForm` component now yields back `submit` and `reset` actions as the functionality was added to `ember-headless-form` [in this PR](https://github.com/CrowdStrike/ember-headless-form/pull/136).

**NOTE:** Calling `submit` directly is **not** required for most cases. The implementation only requires a button tag with the `type="submit"` attribute set.

```hbs
<ToucanForm as |form|>
  {{! This should be used for most cases }}
  <button type='submit'>Submit</button>
  <button {{on 'click' form.reset}} type='button'>Reset</button>
</ToucanForm>
```

However, if you have a more complex case with submission, you can use `form.submit`.

```hbs
<ToucanForm as |form|>
  <button {{on 'click' form.submit}} type='button'>Submit</button>
  <button {{on 'click' form.reset}} type='button'>Reset</button>
</ToucanForm>
```
