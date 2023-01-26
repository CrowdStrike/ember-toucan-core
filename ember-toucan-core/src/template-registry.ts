import type ButtonComponent from './components/button';

export default interface Registry {
  Button: typeof ButtonComponent;
}
