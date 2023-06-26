# File Input Field

Provides an underlying `<input type="file">` element building on top of the Field component.

## Accepts

Optional.

Used to specify the types of files allowed. [See related documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept).

## Label

Required.

Use either the `@label` component argument or the `:label` named block.

Provide a string to the `@label` component argument or content to the `:label` named block to render into the Label section of the Field.

### @label

```hbs
<Form::Fields::FileInput
  @deleteLabel='Delete file'
  @label='Label'
  @files={{this.files}}
  @trigger='Browse Files'
  @onChange={{this.handleChange}}
/>
```

### :label

```hbs
<Form::Fields::FileInput
  @deleteLabel='Delete file'
  @files={{this.files}}
  @hint='Hint text'
  @trigger='Browse Files'
  @onChange={{this.handleChange}}
>
  <:label>Here is a label <IconButton><Tooltip /><IconButton></:label>
</Form::Fields::FileInput>
```

## Delete Label

Required.

Provide a string to `@deleteLabel` to render the accessible text (screenread-only) into the delete button.

## Trigger

Required.

Provide trigger text for the FileInputField (aka `Select Files`) via `@trigger`.

## Hint

Optional.

Use either the `@hint` component argument or the `:hint` named block.

Provide a string to the `@hint` component argument or content to `:hint` named block to render into the Hint section of the Field.

### @hint

```hbs
<Form::Fields::FileInput
  @hint='Here is a hint'
  @deleteLabel='Delete file'
  @label='Label'
  @files={{this.files}}
  @trigger='Browse Files'
  @onChange={{this.handleChange}}
/>
```

### :hint

```hbs
<Form::Fields::FileInput
  @label='Label'
  @deleteLabel='Delete file'
  @files={{this.files}}
  @trigger='Browse Files'
  @onChange={{this.handleChange}}
>
  <:hint>Here is a hint <Link to='somewhere'>Link</Link></:hint>
</Form::Fields::FileInput>
```

## Error

Optional.

Provide a string to `@error` to render the text into the Error section of the Field.

## Files

Optional.

Provide an array of [File](https://developer.mozilla.org/en-US/docs/Web/API/File) objects to the File input via `@files`.

**Note:** To make things easier, the `@files` argument is an array. This makes it convenient to use existing Array methods like `find` and `filter`.

## Multiple

Optional.

If true, allows users to upload multiple files. If false, the `multiple` attribute is not added to the underlying input.

## Value and onChange

Optional

To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the list of files selected
2. the raw FileEvent

```hbs
<Form::Fields::FileInput
  @deleteLabel='Delete'
  @label='Label'
  @trigger='Select files'
  @files={{this.files}}
  @onChange={{this.handleChange}}
/>
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  // Note that a File object is different from a FileList!
  @tracked files: File[] = [];

  @action
  handleChange(files, event) {
    console.log({ files, event, eventFiles: event.target.files });
    this.files = files;
  }
}
```

## Disabled State

Set the `@isDisabled` argument to disable the `<input type="file">`.

## Read Only State

Set the `@isReadOnly` argument to put the input in the read only state.

## Attributes and Modifiers

Consumers have direct access to the underlying [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input), so all attributes are supported. Modifiers can also be added directly to the input as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
// in a test: assert.dom('[data-root-field="example"]');

<Form::Fields::FileInput
  @label='Label'
  @trigger='Browse Files'
  @rootTestSelector='example'
/>
// targeting this field's specific label in a test //
assert.dom('[data-root-field="example"] > [data-label]');
```

```js
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked files = [];

  @action
  handleChange(files, event) {
    console.log({ files, event });
    this.files = files;
  }
}
```

### Label

Target the label element via `data-label`.

### Hint

Target the hint block via `data-hint`.

### Error

Target the error block via `data-error`.

## Files

Target a file **name** in the file list via `data-file-name`.
Target a file **size** in the file list via `data-file-size`.

## List of files

Target the list of files via `data-files`.

## Trigger

Target the trigger text (i.e. "Select Files") via `data-trigger`.

## Delete button

Target the trash icon button via `data-delete-file`.

## UI States

## FileInputField with label

<div class='mb-4 w-64'>
  <Form::Fields::FileInput
    @deleteLabel='Delete file'
    @label='Label'
    @trigger='Browse Files'
  />
</div>

## FileInputField with label and hint

<div class='mb-4 w-64'>
  <Form::Fields::FileInput
    @deleteLabel='Delete file'
    @label='Label'
    @hint='Hint text'
    @trigger='Browse Files'
    />
</div>

## FileInputField with label and hint blocks

<div class='mb-4 w-64'>
  <Form::Fields::FileInput
    @deleteLabel='Delete file'
    @trigger='Browse Files'
  >
  <:label>Label <svg class="inline w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 3a9 9 0 11-6.364 2.636A8.972 8.972 0 0112 3zm0 4.7v5.2m0 3.39v.01" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path></svg></:label>
  <:hint>Hint text <a href="https://www.crowdstrike.com/">link</a></:hint>
  </Form::Fields::FileInput>
</div>

## FileInputField with label, hint and error

<div class='mb-4 w-64'>
  <Form::Fields::FileInput
    @deleteLabel='Delete file'
    @label='Label'
    @hint='Hint'
    @error='Here is an error'
    @trigger='Select Files'
  />
</div>

## FileInputField with label and isDisabled

<div class='mb-4 w-64'>
  <Form::Fields::FileInput
    @deleteLabel='Delete file'
    @label='Label'
    @isDisabled={{true}}
    @trigger='Browse Files'
    />
</div>

### FileInputField with isReadOnly

<div class='mb-4 w-64'>
  <Form::Fields::FileInput
    @deleteLabel='Delete file'
    @label='Label'
    @isReadOnly={{true}}
    @trigger='Browse Files'
  />
</div>
