# @crowdstrike/ember-toucan-core

## 0.4.6

### Patch Changes

- [#645](https://github.com/CrowdStrike/ember-toucan-core/pull/645) [`227c6d5`](https://github.com/CrowdStrike/ember-toucan-core/commit/227c6d59ec5d94f265198cd25d2376f957d6fe73) Thanks [@ryan-nauman-cs](https://github.com/ryan-nauman-cs)! - fix(autocomplete): allow null type

## 0.4.5

### Patch Changes

- [#643](https://github.com/CrowdStrike/ember-toucan-core/pull/643) [`181a62c`](https://github.com/CrowdStrike/ember-toucan-core/commit/181a62c9661a0c51325a63fe4dd9ade71848be45) Thanks [@ryan-nauman-cs](https://github.com/ryan-nauman-cs)! - Fixed multiselect container click handler to properly focus the correct input element when multiple components are present

## 0.4.4

### Patch Changes

- [#561](https://github.com/CrowdStrike/ember-toucan-core/pull/561) [`f6c8b66`](https://github.com/CrowdStrike/ember-toucan-core/commit/f6c8b66aa5d2b18e7c6ede3293c512f7f1b68240) Thanks [@nicolechung](https://github.com/nicolechung)! - Added min-w-0 to the button component to enable truncation for components that use button.

  https://css-tricks.com/flexbox-truncated-text

## 0.4.3

### Patch Changes

- [#447](https://github.com/CrowdStrike/ember-toucan-core/pull/447) [`cb3db50`](https://github.com/CrowdStrike/ember-toucan-core/commit/cb3db50d73bcb6f166759480b2e5c542eb61e932) Thanks [@kmillns](https://github.com/kmillns)! - Update Textarea to ensure underlying <textarea> value stays in sync with both typing and @value changes

## 0.4.2

### Patch Changes

- [#308](https://github.com/CrowdStrike/ember-toucan-core/pull/308) [`e274211`](https://github.com/CrowdStrike/ember-toucan-core/commit/e27421184d4a4f0c238b6917e5656d701eb02c68) Thanks [@bartocc](https://github.com/bartocc)! - Updated incorrect assertion message with CheckboxField

## 0.4.1

### Patch Changes

- [#304](https://github.com/CrowdStrike/ember-toucan-core/pull/304) [`23df6cb`](https://github.com/CrowdStrike/ember-toucan-core/commit/23df6cbdd115f57cca26428bc514f6880439f8cc) Thanks [@davideferre](https://github.com/davideferre)! - Add event.preventDefault() when clicking on disabled button to prevent submitting a form

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

## 0.3.1

### Patch Changes

- [#230](https://github.com/CrowdStrike/ember-toucan-core/pull/230) [`d3b7d42`](https://github.com/CrowdStrike/ember-toucan-core/commit/d3b7d42d150cae765354cc8e3548e4255d3967db) Thanks [@joelamb](https://github.com/joelamb)! - horizontally centre disabled button label

- [#241](https://github.com/CrowdStrike/ember-toucan-core/pull/241) [`1eda28b`](https://github.com/CrowdStrike/ember-toucan-core/commit/1eda28b99b5eedf7611225f5c726c59cc29191e7) Thanks [@clintcs](https://github.com/clintcs)! - Improve documentation consistency.

- [#244](https://github.com/CrowdStrike/ember-toucan-core/pull/244) [`3312a38`](https://github.com/CrowdStrike/ember-toucan-core/commit/3312a3868d50adc826bd0f7b9799fba863bb8121) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Adds "Select all" functionality to the `Multiselect` via a new component argument. Provide `@selectAllText` to opt-in to the functionality.

## 0.3.0

### Minor Changes

- [#232](https://github.com/CrowdStrike/ember-toucan-core/pull/232) [`3d6c159`](https://github.com/CrowdStrike/ember-toucan-core/commit/3d6c159b9c2dfa16f9243339f958129395dd9d4a) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Updated all form elements to have the `w-full` class, making them full width by default. The width of the element is now determined by the container. To restrict the width of the element, use a wrapping tag with an appropriate class name applied.

- [#238](https://github.com/CrowdStrike/ember-toucan-core/pull/238) [`40465de`](https://github.com/CrowdStrike/ember-toucan-core/commit/40465de089a8e2af17670f2ef596183d7c4f65b0) Thanks [@clintcs](https://github.com/clintcs)! - Replace Multiselect's `:noResults` block with a `@noResultsText` argument.

- [#226](https://github.com/CrowdStrike/ember-toucan-core/pull/226) [`9ef84d2`](https://github.com/CrowdStrike/ember-toucan-core/commit/9ef84d2f2b668e8a439ff8cef3ceec235a1b7aed) Thanks [@clintcs](https://github.com/clintcs)! - Removed from Autocomplete support for `@options` as an array of objects.

- [#240](https://github.com/CrowdStrike/ember-toucan-core/pull/240) [`b59a575`](https://github.com/CrowdStrike/ember-toucan-core/commit/b59a5752bc8e5d6bdb028db7a17da7315d66e326) Thanks [@clintcs](https://github.com/clintcs)! - Make Autocomplete `@noResultsText` required.

### Patch Changes

- [#219](https://github.com/CrowdStrike/ember-toucan-core/pull/219) [`1669550`](https://github.com/CrowdStrike/ember-toucan-core/commit/16695506e740b9b0240a57b5faf3f3f14193e104) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Added an `Multiselect` component.

  It has a similar API to `Autocomplete`, but allows for selecting multiple options rather than only one.

  ```hbs
  <Form::Controls::Multiselect
    @contentClass='z-10'
    @noResultsText='No results'
    @onChange={{this.onChange}}
    @optionKey='label'
    @options={{this.options}}
    @selected={{this.selected}}
    placeholder='Colors'
  >
    <!-- NOTE: The chip block is required and a Remove component's label is also required! -->
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label={{(concat 'Remove' ' ' chip.option)}} />
      </chip.Chip>
    </:chip>

    <:default as |multiselect|>
      <multiselect.Option>
        {{multiselect.option.label}}
      </multiselect.Option>
    </:default>
  </Form::Controls::Multiselect>
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

- [#225](https://github.com/CrowdStrike/ember-toucan-core/pull/225) [`50b4f24`](https://github.com/CrowdStrike/ember-toucan-core/commit/50b4f24cd093a2db44b5782cb8239a7541791b1a) Thanks [@ynotdraw](https://github.com/ynotdraw)! - Added `MultiselectField` component - it's the Multiselect control wrapped around a `Field`.

  ```hbs
  <Form::Controls::Multiselect
    @contentClass='z-10'
    @hint='Select a color'
    @label='Label'
    @noResultsText='No results'
    @onChange={{this.onChange}}
    @options={{this.options}}
    @selected={{this.selected}}
  >
    <!-- NOTE: The chip block is required and a Remove component's `@label`` is also required! -->
    <:chip as |chip|>
      <chip.Chip>
        {{chip.option}}
        <chip.Remove @label={{(concat 'Remove' ' ' chip.option)}} />
      </chip.Chip>
    </:chip>

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
