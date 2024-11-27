---
title: Native validation
order: 4
---

# Native validation

This demo shows how to implement native validation with ember-toucan-form, powered by [ember-headless-form](https://ember-headless-form.pages.dev/docs/validation/native).

## Default initial validation

By default, Toucan Form will set the `@validateOn` argument to `focusout`; however, this can be overriden by providing your own `@validateOn` component argument [supported by ember-headless-form](https://ember-headless-form.pages.dev/docs/validation/timing#validateon).

```hbs
<ToucanForm @validateOn='input' />
```

## Form data and TypeScript

The provided form `@data` argument must be properly typed if you are using TypeScript. Follow the ember-headless-form [typing of form data docs](https://ember-headless-form.pages.dev/docs/typescript#typing-of-form-data) for more information. Essentially your `@data` argument type must properly match the form fields used in your templates.

```ts
interface MyFormData {
  firstName?: string;
  lastName?: string;
}

const data: MyFormData = {};
```

```hbs
<ToucanForm @data={{data}} as |form|>
  <form.Input @label='First name' @name='firstName' />
  <form.Input @label='Last name' @name='lastName' />
</ToucanForm>
```

## Submit and Reset Actions

The component yields back `submit` and `reset` actions for more complex cases of submitting or resetting your form data.

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
