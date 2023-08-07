import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface ToucanFormLabelComponentSignature {
  Element: HTMLLabelElement;
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

const ToucanFormLabelComponent: TemplateOnlyComponent<ToucanFormLabelComponentSignature> =
  <template>
    <label
      class="type-md-tight block
        {{if @isDisabled 'text-disabled' 'text-body-and-labels'}}"
      ...attributes
    >
      {{yield}}
    </label>
  </template>;

export default ToucanFormLabelComponent;
