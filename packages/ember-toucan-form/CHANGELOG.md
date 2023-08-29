# @crowdstrike/ember-toucan-form

## 0.4.0

### Minor Changes

- [#254](https://github.com/CrowdStrike/ember-toucan-core/pull/254) [`532ab89`](https://github.com/CrowdStrike/ember-toucan-core/commit/532ab8997917c9dc4beb3da93e19578ec73b3f09) Thanks [@clintcs](https://github.com/clintcs)! - Add Multiselect test helpers.

- [#253](https://github.com/CrowdStrike/ember-toucan-core/pull/253) [`c18922f`](https://github.com/CrowdStrike/ember-toucan-core/commit/c18922f97912b3189c45a572afcf89ce522d7365) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Both `Textarea` and `Input` Controls are now full width by default.

  The `Textarea` Control markup was adjusted to account for collision with the resize handle and focus/error shadows.

  The `Input` Control now has small padding along the x-axis.

- [#257](https://github.com/CrowdStrike/ember-toucan-core/pull/257) [`ce91639`](https://github.com/CrowdStrike/ember-toucan-core/commit/ce91639ffab71d3e5432ef22ca641d4eb4de4174) Thanks [@clintcs](https://github.com/clintcs)! - Remove Button's test helpers

### Patch Changes

- [#246](https://github.com/CrowdStrike/ember-toucan-core/pull/246) [`0e817b6`](https://github.com/CrowdStrike/ember-toucan-core/commit/0e817b6ca73c8225546e33fe7e02d44ed0afedfd) Thanks [@ynotdraw](https://github.com/ynotdraw)! - (internal) Updated both packages to use the `<template>` tag and `gts` file extension.

- [#248](https://github.com/CrowdStrike/ember-toucan-core/pull/248) [`52ded27`](https://github.com/CrowdStrike/ember-toucan-core/commit/52ded27bbefb35fee23ce937331f8b214b0d4c5f) Thanks [@clintcs](https://github.com/clintcs)! - add Autocomplete test helpers.

- Updated dependencies [[`532ab89`](https://github.com/CrowdStrike/ember-toucan-core/commit/532ab8997917c9dc4beb3da93e19578ec73b3f09), [`0e817b6`](https://github.com/CrowdStrike/ember-toucan-core/commit/0e817b6ca73c8225546e33fe7e02d44ed0afedfd), [`52ded27`](https://github.com/CrowdStrike/ember-toucan-core/commit/52ded27bbefb35fee23ce937331f8b214b0d4c5f), [`c18922f`](https://github.com/CrowdStrike/ember-toucan-core/commit/c18922f97912b3189c45a572afcf89ce522d7365), [`ce91639`](https://github.com/CrowdStrike/ember-toucan-core/commit/ce91639ffab71d3e5432ef22ca641d4eb4de4174)]:
  - @crowdstrike/ember-toucan-core@0.4.0

## 0.3.1

### Patch Changes

- [#241](https://github.com/CrowdStrike/ember-toucan-core/pull/241) [`1eda28b`](https://github.com/CrowdStrike/ember-toucan-core/commit/1eda28b99b5eedf7611225f5c726c59cc29191e7) Thanks [@clintcs](https://github.com/clintcs)! - Improve documentation consistency.

- [#244](https://github.com/CrowdStrike/ember-toucan-core/pull/244) [`3312a38`](https://github.com/CrowdStrike/ember-toucan-core/commit/3312a3868d50adc826bd0f7b9799fba863bb8121) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Adds "Select all" functionality to the `Multiselect` via a new component argument. Provide `@selectAllText` to opt-in to the functionality.

- Updated dependencies [[`d3b7d42`](https://github.com/CrowdStrike/ember-toucan-core/commit/d3b7d42d150cae765354cc8e3548e4255d3967db), [`1eda28b`](https://github.com/CrowdStrike/ember-toucan-core/commit/1eda28b99b5eedf7611225f5c726c59cc29191e7), [`3312a38`](https://github.com/CrowdStrike/ember-toucan-core/commit/3312a3868d50adc826bd0f7b9799fba863bb8121)]:
  - @crowdstrike/ember-toucan-core@0.3.1

## 0.3.0

### Minor Changes

- [#232](https://github.com/CrowdStrike/ember-toucan-core/pull/232) [`3d6c159`](https://github.com/CrowdStrike/ember-toucan-core/commit/3d6c159b9c2dfa16f9243339f958129395dd9d4a) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Updated all form elements to have the `w-full` class, making them full width by default. The width of the element is now determined by the container. To restrict the width of the element, use a wrapping tag with an appropriate class name applied.

- [#238](https://github.com/CrowdStrike/ember-toucan-core/pull/238) [`40465de`](https://github.com/CrowdStrike/ember-toucan-core/commit/40465de089a8e2af17670f2ef596183d7c4f65b0) Thanks [@clintcs](https://github.com/clintcs)! - Replace Multiselect's `:noResults` block with a `@noResultsText` argument.

- [#226](https://github.com/CrowdStrike/ember-toucan-core/pull/226) [`9ef84d2`](https://github.com/CrowdStrike/ember-toucan-core/commit/9ef84d2f2b668e8a439ff8cef3ceec235a1b7aed) Thanks [@clintcs](https://github.com/clintcs)! - Removed from Autocomplete support for `@options` as an array of objects.

- [#240](https://github.com/CrowdStrike/ember-toucan-core/pull/240) [`b59a575`](https://github.com/CrowdStrike/ember-toucan-core/commit/b59a5752bc8e5d6bdb028db7a17da7315d66e326) Thanks [@clintcs](https://github.com/clintcs)! - Make Autocomplete `@noResultsText` required.

### Patch Changes

- [#222](https://github.com/CrowdStrike/ember-toucan-core/pull/222) [`ff50f27`](https://github.com/CrowdStrike/ember-toucan-core/commit/ff50f274aad06257f05dd8ddbb39e76377edf755) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Expose the `:secondary` block and Character Counter component from `<ToucanForm` input and textarea components.

  ```hbs
  <ToucanForm @data={{data}} as |form|>
    <form.Input @name='input'>
      <:label>Label</:label>
      <:hint>Hint</:hint>
      <:secondary as |secondary|>
        <secondary.CharacterCount @max={{255}} />
      </:secondary>
    </form.Input>

    <form.Textarea @name='textarea'>
      <:label>Label</:label>
      <:hint>Hint</:hint>
      <:secondary as |secondary|>
        <secondary.CharacterCount @max={{255}} />
      </:secondary>
    </form.Textarea>
  </ToucanForm>
  ```

- [#227](https://github.com/CrowdStrike/ember-toucan-core/pull/227) [`c8a4eb1`](https://github.com/CrowdStrike/ember-toucan-core/commit/c8a4eb139298d2442b8f0df29c1c40bb2874d2cc) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Added `form.Multiselect` support.

  ```hbs
  <ToucanForm @data={{data}} as |form|>
    <form.Multiselect
      @hint='Hint'
      @label='Label'
      @name='selection'
      @noResultsText='No results'
      @options={{this.options}}
    >
      <:chip as |chip|>
        <chip.Chip>
          {{chip.option}}
          <chip.Remove @label={{(concat 'Remove' ' ' chip.option)}} />
        </chip.Chip>
      </:chip>

      <:default as |multiselect|>
        <multiselect.Option>{{multiselect.option}}</multiselect.Option>
      </:default>
    </form.Multiselect>
  </ToucanForm>
  ```

- [#200](https://github.com/CrowdStrike/ember-toucan-core/pull/200) [`91204aa`](https://github.com/CrowdStrike/ember-toucan-core/commit/91204aacd1dbec2b4102df0ed7c2c03556520a4d) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Added an `Autocomplete` component to both core and form packages.

  If you're using `toucan-core`, the control and field components are exposed:

  ```hbs
  <Form::Controls::Autocomplete
    @onChange={{this.onChange}}
    @options={{this.options}}
    @contentClass='z-10'
    @selected={{this.selected}}
    @noResultsText='No results'
    placeholder='Colors'
    as |autocomplete|
  >
    <autocomplete.Option>
      {{autocomplete.option.label}}
    </autocomplete.Option>
  </Form::Controls::Autocomplete>

  <Form::Fields::Autocomplete
    @contentClass='z-10'
    @error={{this.errorMessage}}
    @hint='Type "blue" into the field'
    @label='Label'
    @noResultsText='No results'
    @onChange={{this.onChange}}
    @options={{this.options}}
    @selected={{this.selected}}
    placeholder='Colors'
    as |autocomplete|
  >
    <autocomplete.Option>
      {{autocomplete.option.label}}
    </autocomplete.Option>
  </Form::Fields::Autocomplete>
  ```

  If you're using `toucan-form`, the component is exposed via:

  ```hbs
  <ToucanForm as |form|>
    <form.Autocomplete
      @label='Autocomplete'
      @name='autocomplete'
      @options={{options}}
      data-autocomplete
      as |autocomplete|
    >
      <autocomplete.Option data-option>
        {{autocomplete.option}}
      </autocomplete.Option>
    </form.Autocomplete>
  </ToucanForm>
  ```

  For more information on using these components, view [the docs](https://ember-toucan-core.pages.dev/docs/components/autocomplete).

- Updated dependencies [[`1669550`](https://github.com/CrowdStrike/ember-toucan-core/commit/16695506e740b9b0240a57b5faf3f3f14193e104), [`3d6c159`](https://github.com/CrowdStrike/ember-toucan-core/commit/3d6c159b9c2dfa16f9243339f958129395dd9d4a), [`40465de`](https://github.com/CrowdStrike/ember-toucan-core/commit/40465de089a8e2af17670f2ef596183d7c4f65b0), [`9ef84d2`](https://github.com/CrowdStrike/ember-toucan-core/commit/9ef84d2f2b668e8a439ff8cef3ceec235a1b7aed), [`b59a575`](https://github.com/CrowdStrike/ember-toucan-core/commit/b59a5752bc8e5d6bdb028db7a17da7315d66e326), [`91204aa`](https://github.com/CrowdStrike/ember-toucan-core/commit/91204aacd1dbec2b4102df0ed7c2c03556520a4d), [`50b4f24`](https://github.com/CrowdStrike/ember-toucan-core/commit/50b4f24cd093a2db44b5782cb8239a7541791b1a)]:
  - @crowdstrike/ember-toucan-core@0.3.0

## 0.2.1

### Patch Changes

- [#197](https://github.com/CrowdStrike/ember-toucan-core/pull/197) [`c1130c6`](https://github.com/CrowdStrike/ember-toucan-core/commit/c1130c638b97690836171b03338af40dd11974da) Thanks [@ynotdraw](https://github.com/ynotdraw)! - The `ToucanForm` component now yields back `submit` and `reset` actions as the functionality was added to `ember-headless-form` [in this PR](https://github.com/CrowdStrike/ember-headless-form/pull/136).

  **NOTE:** Calling `submit` directly is **not** required for most cases. The implementation only requires a button tag with the `type="submit"` attribute set.

  ```hbs
  <ToucanForm as |form|>
    {{! This should be used for most cases }}
    <button type='submit'>Submit</button>
    <button {{on 'click' form.reset}} type='button'>Reset</button>
  </ToucanForm>
  ```

  However, if you have a more complex case with submission, you can use `form.submit`.

  ```hbs
  <ToucanForm as |form|>
    <button {{on 'click' form.submit}} type='button'>Submit</button>
    <button {{on 'click' form.reset}} type='button'>Reset</button>
  </ToucanForm>
  ```

- [#189](https://github.com/CrowdStrike/ember-toucan-core/pull/189) [`50547ad`](https://github.com/CrowdStrike/ember-toucan-core/commit/50547ad28f6c3ea05abe7e1e86cd31891e617e36) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Add a lock icon to readonly and disabled states for all form components.

- [#193](https://github.com/CrowdStrike/ember-toucan-core/pull/193) [`8d05e67`](https://github.com/CrowdStrike/ember-toucan-core/commit/8d05e677b8dd58aa4f372215bde406a15e9fa596) Thanks [@ynotdraw](https://github.com/ynotdraw)! - (internal) Updated repo to use [pnpm-sync-dependencies-meta-injected](https://github.com/NullVoxPopuli/pnpm-sync-dependencies-meta-injected) to make local development easier. To develop in the repo, run `pnpm start`.

- [#194](https://github.com/CrowdStrike/ember-toucan-core/pull/194) [`cf944f6`](https://github.com/CrowdStrike/ember-toucan-core/commit/cf944f6f31a9b95b0fd2fb89942a06866373448a) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Updates disabled styling for all form components to set the `text-disabled` class on the label and hint elements.

- [#190](https://github.com/CrowdStrike/ember-toucan-core/pull/190) [`f1b73cd`](https://github.com/CrowdStrike/ember-toucan-core/commit/f1b73cd89c3f34319026ac7ed98d2304942c7a5d) Thanks [@ynotdraw](https://github.com/ynotdraw)! - (internal) Updated `@ember/test-helpers` peer dependency range to `^2.8.1 || ^3.0.0`.

- Updated dependencies [[`42da468`](https://github.com/CrowdStrike/ember-toucan-core/commit/42da468ce75a40bd5b1cde07fbf5ffe774637ed5), [`50547ad`](https://github.com/CrowdStrike/ember-toucan-core/commit/50547ad28f6c3ea05abe7e1e86cd31891e617e36), [`8d05e67`](https://github.com/CrowdStrike/ember-toucan-core/commit/8d05e677b8dd58aa4f372215bde406a15e9fa596), [`cf944f6`](https://github.com/CrowdStrike/ember-toucan-core/commit/cf944f6f31a9b95b0fd2fb89942a06866373448a), [`f1b73cd`](https://github.com/CrowdStrike/ember-toucan-core/commit/f1b73cd89c3f34319026ac7ed98d2304942c7a5d)]:
  - @crowdstrike/ember-toucan-core@0.2.1

## 0.2.0

### Minor Changes

- Updated dependencies [[`17dcffa`](https://github.com/CrowdStrike/ember-toucan-core/commit/17dcffaad2eed80663c1e134a8454366d4fd2b8c), [`c552a59`](https://github.com/CrowdStrike/ember-toucan-core/commit/c552a59ed54d902d394926f7f6951ca41552db4f), [`cc495bd`](https://github.com/CrowdStrike/ember-toucan-core/commit/cc495bd012fc5da35b6a46ba09707a6673e0ed74)]:
  - @crowdstrike/ember-toucan-core@0.2.0

### Patch Changes

- [#177](https://github.com/CrowdStrike/ember-toucan-core/pull/177) [`17dcffa`](https://github.com/CrowdStrike/ember-toucan-core/commit/17dcffaad2eed80663c1e134a8454366d4fd2b8c) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Added `<form.FileInput>` support to `toucan-form`. Resolved a bug where the `accept` attribute was not being applied to the `toucan-core` file-input control. Resolved a bug where `ToucanFormFileInputFieldComponentSignature` was not being exported from the file-input field.

## 0.1.2

### Patch Changes

- [#162](https://github.com/CrowdStrike/ember-toucan-core/pull/162) [`f241920`](https://github.com/CrowdStrike/ember-toucan-core/commit/f241920824325ceaf022295fef7c70158ab8e27c) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Updated to [version beta-3 of ember-headless-form](https://github.com/CrowdStrike/ember-headless-form/releases/tag/ember-headless-form%401.0.0-beta.3).

## 0.1.1

### Patch Changes

- [#156](https://github.com/CrowdStrike/ember-toucan-core/pull/156) [`20d433f`](https://github.com/CrowdStrike/ember-toucan-core/commit/20d433f330a4a6ee3a5d31acfc20f48ccc1bb950) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Exposed named blocks from the underlying `toucan-core` components. This allows users to add custom content in `:hint` or `:label` named blocks. You can combine the arguments and named blocks as well! Below are some examples.

  ```hbs
  <ToucanForm @data={{data}} as |form|>
    <form.Textarea @name='comment'>
      <:label>Label</:label>
      <:hint>Hint</:hint>
    </form.Textarea>
  </ToucanForm>
  ```

  ```hbs
  <ToucanForm @data={{data}} as |form|>
    <form.Textarea @label='Label' @name='comment'>
      <:hint>Hint</:hint>
    </form.Textarea>
  </ToucanForm>
  ```

  ```hbs
  <ToucanForm @data={{data}} as |form|>
    <form.Textarea @hint='Hint' @name='comment'>
      <:label>Label</:label>
    </form.Textarea>
  </ToucanForm>
  ```

  Or you can continue to use the arguments if you're only working with strings!

  ```hbs
  <ToucanForm @data={{data}} as |form|>
    <form.Textarea @label='Label' @hint='Hint' @name='comment' />
  </ToucanForm>
  ```

- [#145](https://github.com/CrowdStrike/ember-toucan-core/pull/145) [`752e6b1`](https://github.com/CrowdStrike/ember-toucan-core/commit/752e6b16d40d04f69ac3381cae4d6ee7ffd962fa) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Added `@isReadOnly` component argument support.

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

- Updated dependencies [[`6a08b45`](https://github.com/CrowdStrike/ember-toucan-core/commit/6a08b4501dce48408278f68d4883a20b9012c3a7), [`b4f6861`](https://github.com/CrowdStrike/ember-toucan-core/commit/b4f6861bc2384dc3144c5b5a6aef18bca48f2b15), [`6a502f7`](https://github.com/CrowdStrike/ember-toucan-core/commit/6a502f70912a1d62aa5f1deae2c50cc3e4aec0b3)]:
  - @crowdstrike/ember-toucan-core@0.1.2

## 0.1.0

### Minor Changes

- [#137](https://github.com/CrowdStrike/ember-toucan-core/pull/137) [`3e662e9`](https://github.com/CrowdStrike/ember-toucan-core/commit/3e662e95def2706c1c44b73c84a2d8eb664ea556) Thanks [@ynotdraw](https://github.com/ynotdraw)! - `@crowdstrike/ember-toucan-form` now exposes the following components to use when building forms:

  - [Textarea](https://github.com/CrowdStrike/ember-toucan-core/pull/129)
  - [Input](https://github.com/CrowdStrike/ember-toucan-core/pull/134)
  - [Checkbox](https://github.com/CrowdStrike/ember-toucan-core/pull/135)
  - [RadioGroup](https://github.com/CrowdStrike/ember-toucan-core/pull/136)
  - [CheckboxGroup](https://github.com/CrowdStrike/ember-toucan-core/pull/137)

  `@crowdstrike-ember-toucan-core` was updated to resolve TypeScript errors and regressions:

  - `CheckboxGroup` `@error` argument now [accepts an array of strings](https://github.com/CrowdStrike/ember-toucan-core/pull/137/files#diff-4944b98b6785745979290458ace369f4a4c4125a1b77e7b269421dfc51a820efR17)
  - `CheckboxGroup` had a regression with the root `data-*` attribute that has been [resolved](https://github.com/CrowdStrike/ember-toucan-core/pull/136/files#diff-be94a63c54dadd43884220fa6817230be44d6789f30da3ba28a716bbd941f3f4R5) by re-adding the component argument
  - `RadioGroup` had a regression with the root `data-*` attribute that has been [resolved](https://github.com/CrowdStrike/ember-toucan-core/pull/136/files#diff-1857c5ed8e778b21fbcd8a18a40754ab5c9d38bcd1ad521bdf4a0c03bf57a808R7)

### Patch Changes

- Updated dependencies [[`c5e97ae`](https://github.com/CrowdStrike/ember-toucan-core/commit/c5e97aea3f6e47b06d6367b8b8b9787567697985), [`3e662e9`](https://github.com/CrowdStrike/ember-toucan-core/commit/3e662e95def2706c1c44b73c84a2d8eb664ea556)]:
  - @crowdstrike/ember-toucan-core@0.1.1
