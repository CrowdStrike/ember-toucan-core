// Add any types here that you need for local development only.
// These will *not* be published as part of your addon, so be careful that your published code does not rely on them!

import '@glint/environment-ember-loose';

import type ToucanCoreRegistry from '@crowdstrike/ember-toucan-core/template-registry';
import type HeadlessFormComponent from 'ember-headless-form/components/headless-form';

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry extends ToucanCoreRegistry {
    // Add any registry entries from other addons here that your addon itself uses (in non-strict mode templates)
    // See https://typed-ember.gitbook.io/glint/using-glint/ember/using-addons
    HeadlessForm: typeof HeadlessFormComponent;
  }
}
