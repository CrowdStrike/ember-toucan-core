---
'@crowdstrike/ember-toucan-form': patch
---

Added `@isReadOnly` component argument support.

```hbs
<ToucanForm @data={{data}} as |form|>
  <form.Textarea
    @label='Comment'
    @name='comment'
    @isReadOnly={{true}}
    data-textarea
  />
  <form.Input
    @label='Input'
    @name='firstName'
    @isReadOnly={{true}}
    data-input
  />
  <form.Checkbox
    @label='Terms'
    @name='termsAndConditions'
    @isReadOnly={{true}}
    data-checkbox
  />

  <form.RadioGroup
    @label='Radios'
    @name='radio'
    @isReadOnly={{true}}
    as |group|
  >
    <group.RadioField @label='option-1' @value='option-1' data-radio-1 />
    <group.RadioField @label='option-2' @value='option-2' data-radio-2 />
  </form.RadioGroup>

  <form.CheckboxGroup
    @label='Checkboxes'
    @name='checkboxes'
    @isReadOnly={{true}}
    as |group|
  >
    <group.CheckboxField
      @label='Option 1'
      @value='option-1'
      data-checkbox-group-1
    />
    <group.CheckboxField
      @label='Option 2'
      @value='option-2'
      data-checkbox-group-2
    />
    <group.CheckboxField
      @label='Option 3'
      @value='option-3'
      data-checkbox-group-3
    />
  </form.CheckboxGroup>
</ToucanForm>
```

For CheckboxGroup and RadioGroup, the argument can be set on the root component, or on individual CheckboxFields / RadioFields directly.
