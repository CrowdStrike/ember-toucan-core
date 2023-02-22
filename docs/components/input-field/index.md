# Input field

Use the input field where you want to be able to have a standard field with a set position for
- label
- hint text
- error text

## Arguments

`error: string`
- Optional
- adds an `id` attribute to the underlying `field.Error` component. This is linked to the `aria-describedBy` in the input component.

`hint: string`
- Optional
- adds an `id` attribute to the underlying `field.Hint` component. This is linked ot the `aria-describedBy` in the input component.

`label: string`
- Required

`onChange: (value:string, e: Event | InputEvent) => void`
- Optional
- use with @value for controlled components

`isDisabled: boolean`
- Optional 

`rootTestSelector: string`
- Optional
- Use this to add a custom test selector, which is added as a value to `data-root-field`

`value: string`
- Optional
- use with @onChange for controlled components

## Attributes

You can pass HTML attributes with `...attributes`

<div class="mb-4">
  <Form::InputField
    @label="Label"
    @hint="extra information about the field"
    type="text"
    placeholder="Example text" 
  />
</div>

```hbs template
<Form::InputField
  @label="Label"
  @hint="extra information about the field"
  type="text"
  placeholder="Example text" 
/>
```


## Errors

Use `@error` to add an error message for the input field.

<div class="mb-4">
  <Form::InputField
    @label="Label"
    @hint="extra information about the field"
    type="text"
    @error="This field is required" 
  />
</div>

```hbs template
<Form::InputField
  @label="Label"
  @hint="extra information about the field"
  type="text"
  @error="This field is required" 
/>
```


## isDisabled

Use `@isDisabled` to disable the entire InputField.

<div class="mb-4">
  <Form::InputField
    @label="Label"
    @hint="extra information about the field"
    type="text"
    @isDisabled={{true}}
  />
</div>

```hbs template
<Form::InputField
  @label="Label"
  @hint="extra information about the field"
  type="text"
  @isDisabled={{true}}
/>
```

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
<Form::InputField @label='Label' @rootTestSelector='example' />
```

```js
assert.dom('[data-root-field="example"]');
// targeting this field's specific label
assert.dom('[data-root-field="example"] > [data-label]');
```

## UI States

### InputField with Label
<div class="mb-4 w-64">
  <Form::InputField
    @label="Label"
    type="text"
  />
</div>

### InputField with Label and hint
<div class="mb-4 w-64">
  <Form::InputField
    @label="Label"
    @hint="With hint text"
    type="text"
  />
</div>

### InputField with Label and error 

<div class="mb-4 w-64">
  <Form::InputField
    @label="Label"
    type="text"
    @error="With error text"
  />
</div>

### InputField with Label and isDisabled 

<div class="mb-4 w-64">
  <Form::InputField
    @label="Label"
    type="text"
    @isDisabled={{true}}
    value="I am a disabled input field"
  />
</div>



