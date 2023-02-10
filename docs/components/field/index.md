# Field

Field is a component to aid in creating form components. It provides a label, hint sections for things like help text, a control block, and an error section for rendering errors. It allows you to provide your own custom controls with a consistent form-element shell.

## Yielded Components

- `Label`: Renders a `<label>` element. Form element label text is normally rendered here.
- `Hint`: Renders a `<div>` element. Help text or supplemental information is normally rendered here.
- `Control`: Renders a control of your choosing, for example, you can provide `<input>`, `<textarea>`, etc.
- `Error`: Renders a `<div>` element. Error information is normally rendered here.

## Optionally Displaying Components

The yielded components from Field can be optionally rendered by using the `{{if}}` helper. For example, control when helper text or errors may be displayed.

```hbs
<Form::Field as |field|>
  <field.Label>{{@label}}</field.Label>

  {{#if @helperText}}
    <field.Hint>{{@helperText}}</field.Hint>
  {{/if}}

  <field.Control>
    <input class='border-critical bg-blue' ...attributes />
  </field.Control>

  {{#if @error}}
    <field.Error>{{@error}}</field.Error>
  {{/if}}
</Form::Field>
```

### Extending the Components

We have `...attributes` added to each sub component of the Field, so HTML attributes Ember modifiers can be added.

```hbs
<Form::Field as |field|>
  <field.Label class='mt-3' {{on 'hover' this.onLabelHover}}>First name</field.Label>
  {{! other components below ...}}
</Form::Field>
```

### Changing The Order Of The Components

You can change the order of elements, for example, swapping the Label and the hint block:

```hbs
<Form::Field as |field|>
  <field.Label>First name</field.Label>
  <field.Control>
    <input ...attributes />
  </field.Control>
  <field.Hint>Hint text below the input</field.Hint>
</Form::Field>
```
