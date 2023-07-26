import templateOnlyComponent from '@ember/component/template-only';

export interface ToucanFormMultiselectChipComponent {
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

export default templateOnlyComponent<ToucanFormMultiselectChipComponent>();
