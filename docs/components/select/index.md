# Select 

Provides a Toucan-styled select with filtering. 
If you are building forms, you may be interested in the SelectField component instead.

## `initialSelectedValues`

To set values to be selected upon initial render, provide `@initialSelectedValues`. 

```hbs
<Form::Controls::Select placeholder="Colors" @initialSelectedValues={{array "blue"}} data-select-1 as |select|>
  <select.Option @label="Blue" @value="blue" name="color" />
  <select.Option @label="Green" @value="green" name="color" />
</Form::Controls::Select>
```
