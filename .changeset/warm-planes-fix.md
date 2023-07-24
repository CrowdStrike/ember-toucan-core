---
'@crowdstrike/ember-toucan-core': patch
---

Added `MultiselectField` component - it's the Multiselect control wrapped around a `Field`.

```hbs
<Form::Controls::Multiselect
  @contentClass='z-10'
  @hint='Select a color'
  @label='Label'
  @onChange={{this.onChange}}
  @options={{this.options}}
  @selected={{this.selected}}
>
  <:noResults>No results</:noResults>

  <!-- NOTE: The remove block is required and a Remove component's label is also required! -->
  <:remove as |remove|>
    <remove.Remove @label={{(concat 'Remove' ' ' remove.option)}} />
  </:remove>

  <:default as |multiselect|>
    <multiselect.Option>
      {{multiselect.option}}
    </multiselect.Option>
  </:default>
</Form::Controls::Multiselect>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked selected;

  options = ['Blue', 'Red', 'Yellow'];

  @action
  onChange(options) {
    this.selected = options;
  }
}
```
