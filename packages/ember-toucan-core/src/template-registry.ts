import type ButtonComponent from './components/button';
import type FormControlsCharacterCount from './components/form/controls/character-count';
import type CheckboxControlComponent from './components/form/controls/checkbox';
import type FormControlsFileInputComponent from './components/form/controls/file-input';
import type InputControlComponent from './components/form/controls/input';
import type RadioControlComponent from './components/form/controls/radio';
import type SelectControlComponent from './components/form/controls/select';
import type TextareaControlComponent from './components/form/controls/textarea';
import type FieldComponent from './components/form/field';
import type CheckboxFieldComponent from './components/form/fields/checkbox';
import type CheckboxGroupFieldComponent from './components/form/fields/checkbox-group';
import type FormFileInputFieldComponent from './components/form/fields/file-input';
import type InputFieldComponent from './components/form/fields/input';
import type RadioFieldComponent from './components/form/fields/radio';
import type RadioGroupFieldComponent from './components/form/fields/radio-group';
import type TextareaFieldComponent from './components/form/fields/textarea';
import type FormFileInputDeleteButtonComponent from './components/form/file-input/delete-button';
import type FormFileInputListComponent from './components/form/file-input/list';

export default interface Registry {
  Button: typeof ButtonComponent;
  'Form::Field': typeof FieldComponent;
  'Form::Fields::Checkbox': typeof CheckboxFieldComponent;
  'Form::Fields::CheckboxGroup': typeof CheckboxGroupFieldComponent;
  'Form::Fields::Input': typeof InputFieldComponent;
  'Form::Controls::Checkbox': typeof CheckboxControlComponent;
  'Form::Controls::FileInput': typeof FormControlsFileInputComponent;
  'Form::Controls::Input': typeof InputControlComponent;
  'Form::Controls::Radio': typeof RadioControlComponent;
  'Form::Controls::Select': typeof SelectControlComponent;
  'Form::Controls::Textarea': typeof TextareaControlComponent;
  'Form::FileInput::List': typeof FormFileInputListComponent;
  'Form::FileInput::DeleteButton': typeof FormFileInputDeleteButtonComponent;
  'Form::Fields::FileInput': typeof FormFileInputFieldComponent;
  'Form::Fields::Radio': typeof RadioFieldComponent;
  'Form::Fields::RadioGroup': typeof RadioGroupFieldComponent;
  'Form::Fields::Textarea': typeof TextareaFieldComponent;
  'Form::Controls::CharacterCount': typeof FormControlsCharacterCount;
}
