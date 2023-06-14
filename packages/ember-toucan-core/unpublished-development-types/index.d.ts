// Add any types here that you need for local development only.
// These will *not* be published as part of your addon, so be careful that your published code does not rely on them!

import '@glint/environment-ember-loose';

import Helper from '@ember/component/helper';

import { ComponentLike } from '@glint/template';

import type ToucanCoreRegistry from '../src/template-registry';
import type TemplateRegistry from '@glint/environment-ember-loose/registry';
import type EmberVelcroRegistry from 'ember-velcro/template-registry';

// importing this directly from the published types (https://github.com/embroider-build/embroider/blob/main/packages/util/index.d.ts) does not work,
// see point 3 in Dan's comment here: https://github.com/typed-ember/glint/issues/518#issuecomment-1400306133
declare class EnsureSafeComponentHelper<
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  C extends string | ComponentLike<any>
> extends Helper<{
  Args: {
    Positional: [component: C];
  };
  Return: C extends keyof TemplateRegistry
    ? TemplateRegistry[C]
    : C extends string
    ? ComponentLike<unknown>
    : C;
}> {}

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry
    extends ToucanCoreRegistry,
      EmberVelcroRegistry {
    // local entries

    'ensure-safe-component': typeof EnsureSafeComponentHelper;
  }
}
