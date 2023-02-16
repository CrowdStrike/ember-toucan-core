import type ButtonComponent from './components/button';
import type FieldComponent from './components/form/field';

export default interface Registry {
  Button: typeof ButtonComponent;
  'Form::Field': typeof FieldComponent;
}
