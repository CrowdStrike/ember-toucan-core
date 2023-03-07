import type ButtonComponent from './components/button';
import type CheckboxFieldComponent from './components/form/checkbox-field';
import type CheckboxGroupFieldComponent from './components/form/checkbox-group-field';
import type CheckboxControlComponent from './components/form/controls/checkbox';
import type InputControlComponent from './components/form/controls/input';
import type RadioControlComponent from './components/form/controls/radio';
import type TextareaControlComponent from './components/form/controls/textarea';
import type FieldComponent from './components/form/field';
import type FieldsetComponent from './components/form/fieldset';
import type FileInputFieldComponent from './components/form/file-input-field';
import type InputFieldComponent from './components/form/input-field';
import type RadioFieldComponent from './components/form/radio-field';
import type RadioGroupFieldComponent from './components/form/radio-group-field';
import type TextareaFieldComponent from './components/form/textarea-field';

export default interface Registry {
  Button: typeof ButtonComponent;
  'Form::Field': typeof FieldComponent;
  'Form::Fieldset': typeof FieldsetComponent;
  'Form::CheckboxField': typeof CheckboxFieldComponent;
  'Form::CheckboxGroupField': typeof CheckboxGroupFieldComponent;
  'Form::InputField': typeof InputFieldComponent;
  'Form::Controls::Checkbox': typeof CheckboxControlComponent;
  'Form::Controls::Input': typeof InputControlComponent;
  'Form::Controls::Radio': typeof RadioControlComponent;
  'Form::Controls::Textarea': typeof TextareaControlComponent;
  'Form::RadioField': typeof RadioFieldComponent;
  'Form::RadioGroupField': typeof RadioGroupFieldComponent;
  'Form::FileInputField': typeof FileInputFieldComponent;
  'Form::TextareaField': typeof TextareaFieldComponent;
}
