import '@glint/environment-ember-loose';
import '@glint/environment-ember-template-imports';

import type ToucanCoreRegistry from '@crowdstrike/ember-toucan-core/template-registry';

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry
    extends ToucanCoreRegistry /* other addon registries */ {
    // local entries
  }
}
