import type ButtonComponent from './components/button';
import type CheckboxConrolComponent from './components/form/controls/checkbox';
import type TextareaControlComponent from './components/form/controls/textarea';
import type FieldComponent from './components/form/field';
import type TextareaFieldComponent from './components/form/textarea-field';

export default interface Registry {
  Button: typeof ButtonComponent;
  'Form::Field': typeof FieldComponent;
  'Form::TextareaField': typeof TextareaFieldComponent;
  'Form::Controls::Checkbox': typeof CheckboxConrolComponent;
  'Form::Controls::Textarea': typeof TextareaControlComponent;
}
