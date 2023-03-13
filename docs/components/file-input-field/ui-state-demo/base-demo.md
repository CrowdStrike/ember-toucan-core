Here are some ui states.

```hbs template
<Form::FileInputField
  @label='Label'
  @hint='Hint text'
  @files={{this.files}}
  @onChange={{this.handleChange}}
>
  <:triggerText>
    Select files
  </:triggerText>
</Form::FileInputField>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked files = createFile(['Here is a file'], { name: 'sample-file.txt' });

  @action
  handleChange(event) {
    if (event.target.files) {
      // https://w3c.github.io/FileAPI/#filelist-section
      // FileList is getting replaced with Array
      this.files = [...event.target.files];
    }
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
