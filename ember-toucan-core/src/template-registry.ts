import type ButtonComponent from './components/button';
import type FieldComponent from './components/form/field';
import type TextareaFieldComponent from './components/form/textarea-field';

export default interface Registry {
  Button: typeof ButtonComponent;
  'Form::Field': typeof FieldComponent;
  'Form::TextareaField': typeof TextareaFieldComponent;
}
