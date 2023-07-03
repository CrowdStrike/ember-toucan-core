# @crowdstrike/ember-toucan-form

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
