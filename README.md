# Toucan Core

<p align="center">
  <a href="https://www.crowdstrike.com">
    <img src="https://github.com/CrowdStrike/ember-toucan-core/blob/main/.github/cs-logo.png?raw=true" alt="CrowdStrike logo" width="300" />
  </a>
</p>

<h1 align="center">The Toucan Design System from CrowdStrike</h1>

<br>

![CI status](https://github.com/crowdstrike/ember-toucan-core/actions/workflows/ci.yml/badge.svg?branch=main)

<br />

Toucan provides a set of accessible and reusable components that make it easy to create visually consistent and efficient Ember applications. This repository is a monorepo publishing two packages:

- `ember-toucan-core`
- `ember-toucan-form`

The `core` package contains the Toucan-styled Ember components. The `form` package allows users to build forms using [`ember-headless-form`](https://github.com/CrowdStrike/ember-headless-form) with the `core` components.

### Compatibility

- Ember.js 4.8 or above
- Embroider or ember-auto-import v2
- [Glint](https://typed-ember.gitbook.io/glint)

## Installation

To use the presentational components in your Ember apps and addons, run one of the following.

```bash
pnpm add @crowdstrike/ember-toucan-core
# or
yarn add @crowdstrike/ember-toucan-core
# or
npm install @crowdstrike/ember-toucan-core
# or
ember install @crowdstrike/ember-toucan-core
```

If want to use our [`ember-headless-form`](https://github.com/CrowdStrike/ember-headless-form) abstraction that exposes the `core` form components, run one of the following.

```bash
pnpm add @crowdstrike/ember-toucan-form
# or
yarn add @crowdstrike/ember-toucan-form
# or
npm install @crowdstrike/ember-toucan-form
# or
ember install @crowdstrike/ember-toucan-form
```

## Usage

Visit our [documentation website](https://ember-toucan-core.pages.dev/).

## Contributing

See the [Contributing](CONTRIBUTING.md) guide for details.
