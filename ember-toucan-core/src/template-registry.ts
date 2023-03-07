import type ButtonComponent from './components/button';
import type CheckboxFieldComponent from './components/form/checkbox-field';
import type CheckboxControlComponent from './components/form/controls/checkbox';
import type InputControlComponent from './components/form/controls/input';
import type RadioControlComponent from './components/form/controls/radio';
import type TextareaControlComponent from './components/form/controls/textarea';
import type FieldComponent from './components/form/field';
import type FieldsetComponent from './components/form/fieldset';
import type InputFieldComponent from './components/form/input-field';
import type TextareaFieldComponent from './components/form/textarea-field';

export default interface Registry {
  Button: typeof ButtonComponent;
  'Form::Field': typeof FieldComponent;
  'Form::Fieldset': typeof FieldsetComponent;
  'Form::CheckboxField': typeof CheckboxFieldComponent;
  'Form::InputField': typeof InputFieldComponent;
  'Form::Controls::Checkbox': typeof CheckboxControlComponent;
  'Form::Controls::Input': typeof InputControlComponent;
  'Form::Controls::Radio': typeof RadioControlComponent;
  'Form::Controls::Textarea': typeof TextareaControlComponent;
  'Form::TextareaField': typeof TextareaFieldComponent;
}
