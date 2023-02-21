import type ButtonComponent from './components/button';
import type CheckboxFieldComponent from './components/form/checkbox-field';
import type CheckboxConrolComponent from './components/form/controls/checkbox';
import type TextareaControlComponent from './components/form/controls/textarea';
import type InputControlComponent from './components/form/controls/input';
import type FieldComponent from './components/form/field';
import type FieldsetComponent from './components/form/fieldset';
import type TextareaFieldComponent from './components/form/textarea-field';
import type InputField from './components/form/input-field';

export default interface Registry {
  Button: typeof ButtonComponent;
  'Form::Field': typeof FieldComponent;
  'Form::Fieldset': typeof FieldsetComponent;
  'Form::CheckboxField': typeof CheckboxFieldComponent;
  'Form::InputField': typeof InputField;
  'Form::Controls::Input' typeof InputControlComponent;
  'Form::TextareaField': typeof TextareaFieldComponent;
  'Form::Controls::Checkbox': typeof CheckboxConrolComponent;
  'Form::Controls::Textarea': typeof TextareaControlComponent;
}
