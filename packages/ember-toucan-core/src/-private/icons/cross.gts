import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface ToucanCoreCrossIconComponentSignature {
  Args: {};
  Blocks: {
    default: [];
  };
  Element: SVGElement;
}

const ToucanCoreCrossIconComponent: TemplateOnlyComponent<ToucanCoreCrossIconComponentSignature> =
  <template>
    <svg
      aria-hidden="true"
      height="16"
      width="16"
      viewBox="0 0 16 16"
      fill="currentColor"
      ...attributes
    >
      <path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="M8 8.707 13.293 14l.707-.707L8.707 8 14 2.707 13.293 2 8 7.293 2.707 2 2 2.707 7.293 8 2 13.293l.707.707L8 8.707Z"
      />
    </svg>
  </template>;

export default ToucanCoreCrossIconComponent;
