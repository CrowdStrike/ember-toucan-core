import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface ToucanCoreChevronIconComponentSignature {
  Args: {};
  Blocks: {
    default: [];
  };
  Element: SVGElement;
}

const ToucanCoreChevronIconComponent: TemplateOnlyComponent<ToucanCoreChevronIconComponentSignature> =
  <template>
    <svg
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="currentColor"
      ...attributes
    ><path
        d="M12 13.586 8.352 9.94a.5.5 0 0 0-.707.707L12 15l4.354-4.354a.498.498 0 0 0 0-.708.5.5 0 0 0-.707 0L12 13.586Z"
      /></svg>
  </template>;

export default ToucanCoreChevronIconComponent;
