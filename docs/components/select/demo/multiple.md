```hbs template
<h3 class="mt-0">
  Multiple select
</h3>

<form class="flex flex-col gap-4 w-96">
  <Form::Controls::Select 
    @isMultiple={{true}}
    @onChange={{this.onChange}} 
    @popoverClass="z-10"
    placeholder="Colors"
   as |select|
  >

    {{#each this.colors as |color|}}
      <select.Option @label={{color.label}} @value={{color.name}} name="color" />
    {{/each}}
  </Form::Controls::Select>

  <Form::Controls::Select 
    @initialSelectedValues={{array "green"}}
    @isMultiple={{true}}
    @isDisabled={{true}}
    @popoverClass="z-10"
    placeholder="Colors"
   as |select|
  >

    {{#each this.colors as |color|}}
      <select.Option @label={{color.label}} @value={{color.name}} name="color" />
    {{/each}}
  </Form::Controls::Select>
</form>

```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';

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
