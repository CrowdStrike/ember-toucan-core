```hbs template
<Form::Fields::FileInput
  @deleteLabel='Delete file'
  @label='Label'
  @files={{this.files}}
  @hint='Hint text'
  @trigger='Browse Files'
  @onChange={{this.handleChange}}
/>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked files = [
    createFile(['Here is a file'], { name: 'SomeonesUploadedFile.csv' }),
  ];

  @action
  handleChange(files, event) {
    // note: files is an array of File objects here (File[]) NOT a FileList
    // https://w3c.github.io/FileAPI/#filelist-section
    // FileList is getting replaced with Array
    this.files = files;
  }
}

function createFile(
  content = ['Some sample content'],
  options = { name: '', type: '' }
) {
  const { name, type } = options;

  const file = new File(content, name, {
    type: type ?? 'text/plain',
  });

  return file;
}
```
