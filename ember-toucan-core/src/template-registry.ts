import type ButtonComponent from './components/button';
import type CheckboxFieldComponent from './components/form/checkbox-field';
import type CheckboxGroupFieldComponent from './components/form/checkbox-group-field';
import type CheckboxControlComponent from './components/form/controls/checkbox';
import type FormControlsFileInputComponent from './components/form/controls/file-input';
import type InputControlComponent from './components/form/controls/input';
import type RadioControlComponent from './components/form/controls/radio';
import type TextareaControlComponent from './components/form/controls/textarea';
import type FieldComponent from './components/form/field';
import type FieldsetComponent from './components/form/fieldset';
import type FormFileInputDeleteButtonComponent from './components/form/file-input/delete-button';
import type FormFileInputFieldComponent from './components/form/file-input/field';
import type FormFileInputListComponent from './components/form/file-input/list';
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
  'Form::Controls::FileInput': typeof FormControlsFileInputComponent;
  'Form::Controls::Input': typeof InputControlComponent;
  'Form::Controls::Radio': typeof RadioControlComponent;
  'Form::Controls::Textarea': typeof TextareaControlComponent;
  'Form::FileInput::Field': typeof FormFileInputFieldComponent;
  'Form::FileInput::List': typeof FormFileInputListComponent;
  'Form::FileInput::DeleteButton': typeof FormFileInputDeleteButtonComponent;
  'Form::RadioField': typeof RadioFieldComponent;
  'Form::RadioGroupField': typeof RadioGroupFieldComponent;
  'Form::FileInputField': typeof FileInputFieldComponent;
  'Form::TextareaField': typeof TextareaFieldComponent;
}
