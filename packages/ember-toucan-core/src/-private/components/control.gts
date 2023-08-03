import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface ToucanFormControlComponentSignature {
  Element: HTMLDivElement;
  Args: {};
  Blocks: {
    default: [];
  };
}

const ToucanCoreControlComponent: TemplateOnlyComponent<ToucanFormControlComponentSignature> =
  <template>
    <div ...attributes>
      {{yield}}
    </div>
  </template>;

export default ToucanCoreControlComponent;
