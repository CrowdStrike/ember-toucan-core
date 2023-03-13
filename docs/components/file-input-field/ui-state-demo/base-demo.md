Here are some ui states.

```hbs template
<div class="flex flex-col gap-y-5">
  <Form::FileInputField
    @label='Label'
    @files={{this.files}}
    @onChange={{this.handleChange}}
    @onDelete={{this.handleDelete}}
  >
    <:triggerText>
      Select files
    </:triggerText>
  </Form::FileInputField>

  <Form::FileInputField
    @label='Label'
    @hint='Hint text'
    @files={{this.files}}
    @onChange={{this.handleChange}}
    @onDelete={{this.handleDelete}}
  >
    <:triggerText>
      Select files
    </:triggerText>
  </Form::FileInputField>

  <Form::FileInputField
    @label='Label'
    @error='Here is an error'
    @files={{this.files}}
    @onChange={{this.handleChange}}
    @onDelete={{this.handleDelete}}
  >
    <:triggerText>
      Select files
    </:triggerText>
  </Form::FileInputField>

  <Form::FileInputField
    @label='Label'
    @isDisabled={{true}}
    @files={{this.files}}
    @onChange={{this.handleChange}}
    @onDelete={{this.handleDelete}}
  >
    <:triggerText>
      Select files
    </:triggerText>
  </Form::FileInputField>

</div>
```

```js component
import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class extends Component {
  @tracked files = [];

  @action
  handleChange(event) {
    if (event.target.files) {
      // https://w3c.github.io/FileAPI/#filelist-section
      // FileList is getting replaced with Array
      this.files = [...event.target.files];
    }
  }
  
  @action
  handleDelete(currentFile, event) {
    this.files = this.files.filter(file => currentFile !== file);
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
