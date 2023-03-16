```hbs template
<Form::FileInput::Field
  @deleteLabel='Delete file'
  @label='Label'
  @files={{this.files}}
  @hint='Hint text'
  @trigger='Select Files'
  @onChange={{this.handleChange}}
  @onDelete={{this.handleDelete}}
/>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked files = [
    createFile(['Here is a file'], { name: 'sample-file.txt' }),
  ];

  @action
  handleChange(files, event) {
    // https://w3c.github.io/FileAPI/#filelist-section
    // FileList is getting replaced with Array
    this.files = files;
  }

  @action
  handleDelete(currentFile, event) {
    this.files = this.files.filter((file) => currentFile !== file);
  }
}

function createFile(
  content = ['Some sample content'],
  options: Options = { name: '', type: '' }
) {
  const { name, type } = options;

  const file = new File(content, name, {
    type: type ? type : 'text/plain',
  });

  return file;
}

type Options = {
  name: string,
  type?: string,
};
```
