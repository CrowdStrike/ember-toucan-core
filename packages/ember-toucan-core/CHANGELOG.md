# @crowdstrike/ember-toucan-core

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
