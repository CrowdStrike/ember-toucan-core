# How To Contribute

- [Overview](#overview)
- [Clone the repo](#clone-the-repo)
- [Install dependencies](#install-dependencies)
- [Adding components](#adding-components)
- [Developing](#developing)
- [Tests](#tests)
- [Documentation](#documentation)
- [VS Code setup](#vscode-setup)
  - [Glint](#glint)
  - [VS Code recommended extensions](#vscode-recommended-extensions)

## Overview

The ember-toucan-core repo is an [Ember v2 addon](https://rfcs.emberjs.com/id/0507-embroider-v2-package-format/). It is setup as a monorepo with the following structure:

- `packages/ember-toucan-core` - the actual Ember addon containing the Toucan components
- `docs-app` - an Ember application used for the documentation site at [http://ember-toucan-core.pages.dev](http://ember-toucan-core.pages.dev)
- `docs` - contains Markdown files that are consumed by the docs-app
- `test-app` - the test app where tests are written

## Clone the repo

The first step in developing in the ember-toucan-core repo is to clone the repo.

```bash
git clone git@github.com:CrowdStrike/ember-toucan-core.git
```

## Install dependencies

ember-toucan-core uses [PNPM](https://pnpm.io) as its package manager.
If you're used to Yarn or NPM, PNPM has similar commands so you should be right at home!

```bash
cd ember-toucan-core
pnpm install # or `pnpm i`
```

## Adding components

When developing a new component, add it to the `packages/ember-toucan-core` directory.
A few things to remember:

1. Components are added under `packages/ember-toucan-core/src/components`
2. When adding a new component, it needs to be added to the template registry so Glint picks it up.
   To do that, add a line in `packages/ember-toucan-core/src/template-registry.ts`.

## Developing

To develop in this monorepo you can simply run:

- `pnpm start`

from the root directory.

This will:

- Build all of the `packages/*` and watch them for changes
- Build the docs app and the tests app and serve them
- Automatically sync changes from the `packages/*` to the served apps so
  that they are always up to date.

You can now visit:

- The docs app at http://localhost:4201/
- The tests app at http://localhost:4200/tests

If you don't need to run both apps you can save a little of your local
compute by running:

- `start:docs-app` and visiting http://localhost:4201/
- `start:test-app` and visiting http://localhost:4200/tests

These commands will still build and watch the `packages/*` and sync changes
to the running app. Don't run both `only` tasks together as this will cause
issues - if you want to run both apps simply use `pnpm start`.

## Tests

Tests are written in the `test-app` under `test-app/tests`.
We use Glint, so you will see the file extension is `.gts`.

To run the test-app:

```bash
cd test-app
pnpm start
```

Navigate to [http://localhost:4200/tests](http://localhost:4200/tests) to view your tests.

## Documentation

Documentation lives in both the `docs` and `docs-app` directories.
For most cases when adding components, you'll only need to add markdown files in `docs`.
The `docs-app` directory is the Ember app powering the documentation, so it's not as likely to be edited when adding new functionality to ember-toucan-core.

## VS Code setup

### Glint

⚠️ **NOTE**: To successfully use Glint in the test-app you'll need to follow the directions in the [Glint VS Code extension](https://marketplace.visualstudio.com/items?itemName=typed-ember.glint-vscode) instructions under "Setup".
If you skip this step, you will see a lot of red lines in your editor!

### VS Code recommended extensions

Upon cloning the repo and opening it in VS Code, you may be prompted to download the recommended extensions.
This is highly recommended!
We've hand picked extensions that assist in writing Glint-powered Ember code.
The following workspace settings are also recommended to get Prettier auto-save and ESLint working:

```json
  "files.trimTrailingWhitespace": true,
  "editor.tabSize": 2,
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  // This is used to tell Glint where to look for the Glint dependencies
  // In our case, we use glint in the test-app!
  "glint.libraryPath": "test-app",
  "[glimmer-js]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[glimmer-ts]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "prettier.documentSelectors": ["**/*.gjs", "**/*.gts"],
  "editor.formatOnSave": true
```
