```hbs template
<Form::Fields::Select
  @label='Label'
  @hint='Type "blue" into the field'
  @error={{this.errorMessage}}
  @onChange={{this.handleChange}}
  @popoverClass="z-10"
  placeholder="Colors"
  as |select|
>
  {{#each this.colors as |color|}}
    <select.Option @label={{color.label}} @value={{color.name}} name="color" />
  {{/each}}
</Form::Fields::Select>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  colors = [
    {
      label: "Blue",
      name: "blue",
    },
    {
      label: "Green",
      name: "green",
    },
    {
      label: "Yellow",
      name: "yellow",
    },
    {
      label: "Orange",
      name: "orange",
    },
    {
      label: "Red",
      name: "red",
    },
    {
      label: "Purple",
      name: "purple",
    },
    {
      label: "Teal",
      name: "teal",
    },
  ];

  @action
  onChange(values: string[]) {
    console.log(values)
  }
}
```
