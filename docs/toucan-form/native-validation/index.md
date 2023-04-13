---
title: Native validation
order: 3
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
