# Native validation

For native validation, refer to the ember-headless-form [docs](https://ember-headless-form.pages.dev/docs/validation/native).

This demo shows how to implement native validation with ember-headless-form and ember-toucan-core.

Note: `ember-toucan-core` accepts an array of strings, but the `field.rawErrors` from `ember-headless-form` returns an array of objects. To handle this, write a `mapErrors` helper like in the demo below.
