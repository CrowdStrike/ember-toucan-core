import '@glint/environment-ember-loose';

import type ToucanCoreRegistry from '@crowdstrike/ember-toucan-core/registry';

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry extends ToucanCoreRegistry, /* other addon registries */ {
    // local entries
  }
}
