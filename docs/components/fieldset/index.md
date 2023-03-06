# Fieldset

Fieldset is a component to aid in creating form components that require an underlying `<fieldset>` and `<legend>`. It is similar to Field, in that it provides an opinionated shell for building other components such as checkbox groups and radio groups.

## Label

Provide a string to `@label` to render the text into the `<legend>` of the Fieldset. This is required.

```hbs
<Form::Fieldset @label='Label' />
```

## Hint

Provide a string to `@hint` to render the text into the Hint section of the Fieldset. This is optional.

```hbs
<Form::Fieldset @label='Label' @hint='Hint' />
```

## Error

Provide a string to `@error` to render the text into the Error section of the Fieldset. This is optional.

```hbs
<Form::Fieldset @label='Label' @error='Error' />
```

## Disabled State

Set the `@isDisabled` argument to disable the fieldset. When disabled, all form controls that are descendants of the fieldset, are disabled, meaning they are not editable and won't be submitted along with the form. Learn more via the [fieldset documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/fieldset#attributes).

```hbs
<Form::Fieldset @label='Label' @isDisabled={{true}}>
  <!-- This is now disabled as well -->
  <input />
</Form::Fieldset>
```

## Attributes and Modifiers

Consumers have direct access to the underlying [fieldset element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/fieldset), so all attributes are supported.

```hbs
<Form::Fieldset @label='Label' name='my-checkboxes' data-fieldset />
```

## Test Selectors

### Root Element

The wrapping element is a `<fieldset>` and attributes are spread directly on it as mentioned above. Due to that, one can target the fieldset with any data attribute.

```hbs
<Form::Fieldset @label='Label' data-fieldset />
```

### Label

Target the label element via `data-label`.

### Hint

Target the hint block via `data-hint`.

### Wrapping Content Container

The `yield` is wrapped in a div container that can be targeted with `data-control`.

### Error

Target the error block via `data-error`.

## All UI States

<div class="flex flex-col space-y-4" style="max-width: 14rem">
<Form::Fieldset @label='Label'>

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
</Form::Fieldset>

<Form::Fieldset @label='Label' @hint="With hint text">

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
</Form::Fieldset>

<Form::Fieldset @label='Label' @error="With error">

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
</Form::Fieldset>

<Form::Fieldset @label='Label' @hint="With hint text" @error="With error">

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
</Form::Fieldset>
</div>
