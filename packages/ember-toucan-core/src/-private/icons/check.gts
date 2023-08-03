import type { TemplateOnlyComponent } from '@ember/component/template-only';

export interface ToucanCoreCheckIconComponentSignature {
  Args: {};
  Blocks: {
    default: [];
  };
  Element: SVGElement;
}

const ToucanCoreCheckIconComponent: TemplateOnlyComponent<ToucanCoreCheckIconComponentSignature> =
  <template>
    <svg
      width="16"
      height="16"
      viewBox="0 0 16 16"
      fill="currentColor"
      ...attributes
    ><path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="m2.5 9.125.707-.707 2.438 2.437L12.5 4l.707.707-7.562 7.562L2.5 9.125Z"
      /></svg>
  </template>;

export default ToucanCoreCheckIconComponent;
