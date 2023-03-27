```hbs template
<Form::Fieldset
  @label='Label'
  @hint='Extra information about the fieldset'
  @error='Error message'
>
  <:default><p class='text-body-and-labels text-xs m-0 italic'>~Fieldset
      components render here!~</p></:default>
  <:label>extra label info</:label>
  <:hint>extra hint info</:hint>
</Form::Fieldset>
```

```js component
import Component from '@glimmer/component';

export default class extends Component {}
```
