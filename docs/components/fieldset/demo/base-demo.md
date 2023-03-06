```hbs template
<Form::Fieldset
  @label='Label'
  @hint='Extra information about the fieldset'
  @error='Error message'
>
  <p class='text-body-and-labels text-xs m-0 italic'>~Fieldset components render
    here!~</p>
</Form::Fieldset>
```

```js component
import Component from '@glimmer/component';

export default class extends Component {}
```
