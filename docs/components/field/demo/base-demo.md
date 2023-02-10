```hbs template
<Form::Field as |field|>
  <field.Label>First name</field.Label>
  <field.Hint>What should we call you?</field.Hint>
  <field.Control>
    <input
      class='border bg-basement text-titles-and-attributes'
      ...attributes
    />
  </field.Control>
  <field.Error>error</field.Error>
</Form::Field>
```

```js component
import Component from '@glimmer/component';

export default class extends Component {}
```
