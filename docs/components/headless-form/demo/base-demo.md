```hbs template
<HeadlessForm
  @data={{data}}
  @dataMode="mutable"
  {{! @glint-expect-error --  a type error is expected here, as this test intentionally has a type mismatch when data not being a changeset }}
  @validate={{validateChangeset}}
  @onSubmit={{submitHandler}}
  as |form|
>
  <form.Field @name="firstName" as |field|>
    <field.Label>First Name</field.Label>
    <field.Input data-test-first-name />
  </form.Field>
  <button type="submit" data-test-submit>Submit</button>
</HeadlessForm>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { Changeset } from 'ember-changeset';
import { validateChangeset } from 'ember-headless-form-changeset';
import type { ValidatorAction } from 'ember-changeset/types';

const validator: ValidatorAction = ({ key, newValue }) => {
    const errors: string[] = [];

    if (newValue == undefined) {
      errors.push(`${key} is required!`);
    } else if (typeof newValue !== 'string') {
      errors.push('Unexpected type');
    } else {
      if (newValue.charAt(0).toUpperCase() !== newValue.charAt(0)) {
        errors.push(`${key} must be upper case!`);
      }

      if (newValue.toLowerCase() === 'foo') {
        errors.push(`Foo is an invalid ${key}!`);
      }
    }

    return errors.length > 0 ? errors : true;
  };

export default class extends Component {
  data: TestFormData = { firstName: 'Foo', lastName: 'Smith' };
  changeset = Changeset(data, validator);

  @action
  validateChangeset() {

  }

  @action
  submitHandler() {
    console.log('submitted');
  }
}
```
