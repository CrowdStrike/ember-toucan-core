import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface ToucanCoreLockIconComponentSignature {
  Args: {};
  Blocks: {
    default: [];
  };
  Element: SVGElement;
}

const ToucanCoreLockIconComponent: TemplateOnlyComponent<ToucanCoreLockIconComponentSignature> =
  <template>
    <svg
      width="12"
      height="12"
      viewBox="0 0 12 12"
      fill="currentColor"
      aria-hidden="true"
      class="text-disabled"
      data-lock-icon
      ...attributes
    >
      <g>
        <path d="M5.5 6v3h1V6h-1Z" />
        <path
          fill-rule="evenodd"
          clip-rule="evenodd"
          d="M3 3.5V3a3 3 0 0 1 6 0v.5h.5A1.5 1.5 0 0 1 11 5v5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 1 10V5a1.5 1.5 0 0 1 1.5-1.5H3ZM4 3a2 2 0 1 1 4 0v.5H4V3ZM2 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v5a.5.5 0 0 1-.5.5h-7A.5.5 0 0 1 2 10V5Z"
        />
      </g>
    </svg>
  </template>;

export default ToucanCoreLockIconComponent;
