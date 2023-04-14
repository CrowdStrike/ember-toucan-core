import type Component from '@glimmer/component';
import type { ComponentSignatureBlocks } from '@glint/template/-private/signature';
import type { HeadlessForm } from 'ember-headless-form';

export type UserData = object;

// Glint utilities

export type SignatureOf<C> = C extends typeof Component<infer S> ? S : never;

export type GetBlockParams<
  C,
  BLOCK extends string
> = BLOCK extends keyof ComponentSignatureBlocks<SignatureOf<C>>
  ? ComponentSignatureBlocks<SignatureOf<C>>[BLOCK]
  : never;

// ember-headless-form utilities

export type HeadlessFormBlock<DATA extends UserData> = GetBlockParams<
  typeof HeadlessForm<DATA, unknown>,
  'default'
>['Params']['Positional'][0];
