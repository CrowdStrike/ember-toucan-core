```hbs template
<Form::Field as |field|>
  <field.Label for={{field.id}}>Label</field.Label>
  <field.Hint id={{field.hintId}}>Extra information about the field</field.Hint>
  <field.Control>
    <input
      class='border bg-basement text-titles-and-attributes p-1 rounded-sm'
      id={{field.id}}
      aria-invalid='true'
      aria-describedby='{{field.hintId}} {{field.errorId}}'
      ...attributes
    />
  </field.Control>
  <field.Error id={{field.errorId}}>Error message</field.Error>
</Form::Field>
```

```js component
import Component from '@glimmer/component';

export default class extends Component {}
```
