import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface ToucanCoreMultiselectChipComponentSignature {
  Args: {
    /**
     * The index of the chip based on the selected options.
     */
    index?: number;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

const ToucanCoreMultiselectChipComponent: TemplateOnlyComponent<ToucanCoreMultiselectChipComponentSignature> =
  <template>
    <div
      class="min-h-6 bg-normal-idle flex items-center gap-x-2.5 rounded-sm px-2 py-1"
      data-index={{@index}}
      data-multiselect-selected-option
      ...attributes
    >
      {{yield}}
    </div>
  </template>;

export default ToucanCoreMultiselectChipComponent;
