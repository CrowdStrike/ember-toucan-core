# @crowdstrike/ember-toucan-core

## 0.2.2

### Patch Changes

- [#212](https://github.com/CrowdStrike/ember-toucan-core/pull/212) [`eb5b130`](https://github.com/CrowdStrike/ember-toucan-core/commit/eb5b130eeb3fd6f020b840a144953733d6309603) Thanks [@joelamb](https://github.com/joelamb)! - fixes flex-grow for disabled button

- [#208](https://github.com/CrowdStrike/ember-toucan-core/pull/208) [`e907310`](https://github.com/CrowdStrike/ember-toucan-core/commit/e907310cbc43e0b24e3563e5d5d6a96e8c9c7c93) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Adds error styling when the current character length is greater than maximum character length for the input and textarea components using the character counter.

## 0.2.1

### Patch Changes

- [#198](https://github.com/CrowdStrike/ember-toucan-core/pull/198) [`42da468`](https://github.com/CrowdStrike/ember-toucan-core/commit/42da468ce75a40bd5b1cde07fbf5ffe774637ed5) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Updated `<Form::Fields::FileInput` styling to match designs. This included updates to the disabled state as well as the list items.

- [#189](https://github.com/CrowdStrike/ember-toucan-core/pull/189) [`50547ad`](https://github.com/CrowdStrike/ember-toucan-core/commit/50547ad28f6c3ea05abe7e1e86cd31891e617e36) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Add a lock icon to readonly and disabled states for all form components.

- [#193](https://github.com/CrowdStrike/ember-toucan-core/pull/193) [`8d05e67`](https://github.com/CrowdStrike/ember-toucan-core/commit/8d05e677b8dd58aa4f372215bde406a15e9fa596) Thanks [@ynotdraw](https://github.com/ynotdraw)! - (internal) Updated repo to use [pnpm-sync-dependencies-meta-injected](https://github.com/NullVoxPopuli/pnpm-sync-dependencies-meta-injected) to make local development easier. To develop in the repo, run `pnpm start`.

- [#194](https://github.com/CrowdStrike/ember-toucan-core/pull/194) [`cf944f6`](https://github.com/CrowdStrike/ember-toucan-core/commit/cf944f6f31a9b95b0fd2fb89942a06866373448a) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Updates disabled styling for all form components to set the `text-disabled` class on the label and hint elements.

- [#190](https://github.com/CrowdStrike/ember-toucan-core/pull/190) [`f1b73cd`](https://github.com/CrowdStrike/ember-toucan-core/commit/f1b73cd89c3f34319026ac7ed98d2304942c7a5d) Thanks [@ynotdraw](https://github.com/ynotdraw)! - (internal) Updated `@ember/test-helpers` peer dependency range to `^2.8.1 || ^3.0.0`.

## 0.2.0

### Minor Changes

- [#178](https://github.com/CrowdStrike/ember-toucan-core/pull/178) [`c552a59`](https://github.com/CrowdStrike/ember-toucan-core/commit/c552a59ed54d902d394926f7f6951ca41552db4f) Thanks [@clintcs](https://github.com/clintcs)! - add @value support to Form::Controls::Checkbox

### Patch Changes

- [#177](https://github.com/CrowdStrike/ember-toucan-core/pull/177) [`17dcffa`](https://github.com/CrowdStrike/ember-toucan-core/commit/17dcffaad2eed80663c1e134a8454366d4fd2b8c) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Added `<form.FileInput>` support to `toucan-form`. Resolved a bug where the `accept` attribute was not being applied to the `toucan-core` file-input control. Resolved a bug where `ToucanFormFileInputFieldComponentSignature` was not being exported from the file-input field.

- [#183](https://github.com/CrowdStrike/ember-toucan-core/pull/183) [`cc495bd`](https://github.com/CrowdStrike/ember-toucan-core/commit/cc495bd012fc5da35b6a46ba09707a6673e0ed74) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Fixed a re-selection bug with Form::Controls::FileInput.

## 0.1.2

### Patch Changes

- [#115](https://github.com/CrowdStrike/ember-toucan-core/pull/115) [`6a08b45`](https://github.com/CrowdStrike/ember-toucan-core/commit/6a08b4501dce48408278f68d4883a20b9012c3a7) Thanks [@nicolechung](https://github.com/nicolechung)! - Added Character Count in InputField

  Added optional character count in the Input Field component, along with related base demo and tests.

- [#132](https://github.com/CrowdStrike/ember-toucan-core/pull/132) [`b4f6861`](https://github.com/CrowdStrike/ember-toucan-core/commit/b4f6861bc2384dc3144c5b5a6aef18bca48f2b15) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Added the `@isReadOnly` component argument to all form components. It will apply read only styling and the `readonly` attribute. This requires the latest release of [@crowdstrike/tailwind-toucan-base](https://github.com/CrowdStrike/tailwind-toucan-base/releases/tag/%40crowdstrike%2Ftailwind-toucan-base%403.5.0).

- [#157](https://github.com/CrowdStrike/ember-toucan-core/pull/157) [`6a502f7`](https://github.com/CrowdStrike/ember-toucan-core/commit/6a502f70912a1d62aa5f1deae2c50cc3e4aec0b3) Thanks [@nicolechung](https://github.com/nicolechung)! - Added: Character Count for Textarea Field

## 0.1.1

### Patch Changes

- [#140](https://github.com/CrowdStrike/ember-toucan-core/pull/140) [`c5e97ae`](https://github.com/CrowdStrike/ember-toucan-core/commit/c5e97aea3f6e47b06d6367b8b8b9787567697985) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Replaced placeholder icons with Toucan icons.

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

## 0.1.0

### Minor Changes

- [#110](https://github.com/CrowdStrike/ember-toucan-core/pull/110) [`26b324f`](https://github.com/CrowdStrike/ember-toucan-core/commit/26b324f79901fb6fffb96b2aeeade781776ada11) Thanks [@nicolechung](https://github.com/nicolechung)! - - Added label and hint named blocks to all the Field components.

  - Removed Fieldset.

- [#113](https://github.com/CrowdStrike/ember-toucan-core/pull/113) [`46f7fa0`](https://github.com/CrowdStrike/ember-toucan-core/commit/46f7fa0763c24b9bd5bb7cc75abe027c6827b362) Thanks [@ynotdraw](https://github.com/ynotdraw)! - The following components have been added and can be used with this release:

  - `Button`
  - `Form::Controls::Checkbox`
  - `Form::Controls::FileInput`
  - `Form::Controls::Input`
  - `Form::Controls::Radio`
  - `Form::Controls::Textarea`
  - `Form::Field`
  - `Form::Fieldset`
  - `Form::Fields::Checkbox`
  - `Form::Fields::CheckboxGroup`
  - `Form::Fields::Input`
  - `Form::Fields::FileInput`
  - `Form::Fields::Radio`
  - `Form::Fields::RadioGroup`
  - `Form::Fields::Textarea`
  - `Form::FileInput::List`
  - `Form::FileInput::DeleteButton`

### Patch Changes

- [#128](https://github.com/CrowdStrike/ember-toucan-core/pull/128) [`ae07d89`](https://github.com/CrowdStrike/ember-toucan-core/commit/ae07d891762ad2d65fbb7bef5a0dea0c2613a85a) Thanks [@simonihmig](https://github.com/simonihmig)! - Support `@isButtonGroup` mode for `<Button>`

  This is only to be used _internally_ to support buttons being used inside a `<ButtonGroup>`.

## 0.1.0-beta.0

### Minor Changes

- [#113](https://github.com/CrowdStrike/ember-toucan-core/pull/113) [`46f7fa0`](https://github.com/CrowdStrike/ember-toucan-core/commit/46f7fa0763c24b9bd5bb7cc75abe027c6827b362) Thanks [@ynotdraw](https://github.com/ynotdraw)! - The following components have been added and can be used with this release:

  - `Button`
  - `Form::Controls::Checkbox`
  - `Form::Controls::FileInput`
  - `Form::Controls::Input`
  - `Form::Controls::Radio`
  - `Form::Controls::Textarea`
  - `Form::Field`
  - `Form::Fieldset`
  - `Form::Fields::Checkbox`
  - `Form::Fields::CheckboxGroup`
  - `Form::Fields::Input`
  - `Form::Fields::FileInput`
  - `Form::Fields::Radio`
  - `Form::Fields::RadioGroup`
  - `Form::Fields::Textarea`
  - `Form::FileInput::List`
  - `Form::FileInput::DeleteButton`
