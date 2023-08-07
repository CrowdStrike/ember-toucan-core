import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface ToucanFormHintComponentSignature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Sets disabled styling on the label.
     */
    isDisabled?: boolean;
  };
  Blocks: {
    default: [];
  };
}

const ToucanFormHintComponent: TemplateOnlyComponent<ToucanFormHintComponentSignature> =
  <template>
    <div
      class="type-xs-tight mt-0.5
        {{if @isDisabled 'text-disabled' 'text-body-and-labels'}}"
      ...attributes
    >{{yield}}</div>
  </template>;

export default ToucanFormHintComponent;
