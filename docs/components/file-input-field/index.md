# File Input Field

Provides an underlying `<input type="file">` element building on top of the Field component.

## Label

Required.
Provide a string to `@label` to render the text into the `<input type="file">` of the Field.

## Delete Label

Required.
Provide a string to `@deleteLabel` to render the accessible text (screenread-only) into the delete button.

## Trigger

Required.
Provide trigger text for the FileInputField (aka `Select Files`) via `@trigger`.

## Hint

Optional.
Provide a string to `@hint` to render the text into the Hint section of the Field.

## Error

Optional.
Provide a string to `@error` to render the text into the Error section of the Field.

## Files

Optional.
Provide an array of [File](https://developer.mozilla.org/en-US/docs/Web/API/File) objects to the File input via `@files`.

**Note:** To make things easier, the `@files` argument is an array. This makes it convenient to use existing Array methods like `find` and `filter`.

## Value and onChange

Optional
To tie into the input event, provide `@onChange`. `@onChange` will return two arguments:

1. the list of files selected
2. the raw FileEvent

```hbs
<Form::FileInputField
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

## Attributes and Modifiers

Consumers have direct access to the underlying [input element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input), so all attributes are supported. Modifiers can also be added directly to the input as shown in the demo.

## Test Selectors

### Root Element

Provide a custom selector via `@rootTestSelector`. This test selector will be used as the value for the `data-root-field` attribute. The Field can be targeted via:

```hbs
// in a test: assert.dom('[data-root-field="example"]');

<Form::FileInputField
  @label='Label'
  @trigger='Select Files'
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

## UI States

<div class='flex flex-col gap-y-5'>
  <Form::FileInputField
    @deleteLabel='Delete file'
    @label='Label'
    @trigger='Select Files'
  />

<Form::FileInputField
@deleteLabel='Delete file'
@label='Label'
@hint='Hint text'
@trigger='Select Files'
/>

<Form::FileInputField
@deleteLabel='Delete file'
@label='Label'
@error='Here is an error'
@trigger='Select Files'
/>

<Form::FileInputField
@deleteLabel='Delete file'
@label='Label'
@isDisabled={{true}}
@trigger='Select Files'
/>

</div>
