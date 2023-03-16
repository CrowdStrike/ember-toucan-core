Here are some ui states.

```hbs template
<div class='flex flex-col gap-y-5'>
  <Form::FileInputField
    @deleteLabel='Delete file'
    @label='Label'
    @trigger='Select Files'
    @files={{this.files}}
    @onChange={{this.handleChange}}
  />

  <Form::FileInputField
    @deleteLabel='Delete file'
    @label='Label'
    @hint='Hint text'
    @trigger='Select Files'
    @files={{this.files}}
    @onChange={{this.handleChange}}
  />

  <Form::FileInputField
    @deleteLabel='Delete file'
    @label='Label'
    @error='Here is an error'
    @trigger='Select Files'
    @files={{this.files}}
    @onChange={{this.handleChange}}
  />

  <Form::FileInputField
    @deleteLabel='Delete file'
    @label='Label'
    @isDisabled={{true}}
    @trigger='Select Files'
    @files={{this.files}}
    @onChange={{this.handleChange}}
  />

</div>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked files = [];

  @action
  handleChange(files) {
    // Note: files is an array of File objects (File[]) NOT a FileList
    // https://w3c.github.io/FileAPI/#filelist-section
    // FileList is getting replaced with Array
    this.files = files;
  }

}

function createFile(
  content = ['Some sample content'],
  options: Options = { name: '', type: '' }
) {
  const { name, type } = options;

  const file = new File(content, name, {
    type: type ?? 'text/plain',
  });

  return file;
}

type Options = {
  name: string,
  type?: string,
};
```
