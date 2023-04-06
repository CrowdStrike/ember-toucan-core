# Fieldset

Fieldset is a component to aid in creating form components that require an underlying `<fieldset>` and `<legend>`. It is similar to Field, in that it provides an opinionated shell for building other components such as checkbox groups and radio groups.

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render the text into the `<legend>` of the Fieldset.

### @label

```hbs
<Form::Fieldset @label='Label' />
```

### :label block

```hbs
<Form::Fieldset
  @error='Error message'
>
  {{!-- note that default block is required here --}}
  <:default><p class='text-body-and-labels text-xs m-0 italic'>~Fieldset
      components render here!~</p></:default>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
</Form::Fieldset>
```

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section.

### @hint

```hbs
<Form::Fieldset @label='Label' @hint='Hint' />
```

### :hint

```hbs
<Form::Fieldset @label='Label' @error='Error message'>
  {{! note that default block is required here }}
  <:default><p class='text-body-and-labels text-xs m-0 italic'>~Fieldset
      components render here!~</p></:default>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
</Form::Fieldset>
```

## Error

Optional.

Provide a string or array of strings to `@error` to render the text into the Error section of the Fieldset.

```hbs
<Form::Fieldset @label='Label' @error='Error' />
```

```hbs
<Form::Fieldset @label='Label' @error={{(array 'Error 1' 'Error 2')}} />
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

### Fieldset with label and default block

<Form::Fieldset @label='Label'>

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
</Form::Fieldset>

### Fieldset with label, hint and default block

<Form::Fieldset @label='Label' @hint="With hint text">

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
</Form::Fieldset>

### Fieldset with label block, hint block and default block

<Form::Fieldset>
<:default>

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
  </:default>
  <:label>Label <svg class="inline" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
  <:hint>With hint text <a href="https://www.crowdstrike.com/">link</a></:hint>
</Form::Fieldset>

### Fieldset with label and error and default block

<Form::Fieldset @label='Label' @error="With error">

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
</Form::Fieldset>

### Field with label, hint, error and default block

<Form::Fieldset @label='Label' @hint="With hint text" @error="With error">

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
</Form::Fieldset>

### Fieldset with label, hint, error array and default block

<Form::Fieldset @label='Label' @hint="With hint text" @error={{(array "With error 1" "With error 2" "With error 3")}}>

  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render here!~</p>
</Form::Fieldset>
</div>
