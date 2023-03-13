# How To Contribute

- [Overview](#overview)
- [Clone the repo](#clone-the-repo)
- [Install dependencies](#install-dependencies)
- [Adding components](#adding-components)
- [Running the docs/test-app](#running-the-docstest-app)
- [Viewing changes in the docs/test-app](#viewing-changes-in-the-docstest-app)
- [Tests](#tests)
- [Documentation](#documentation)
- [VSCode setup](#vscode-setup)
  - [Glint](#glint)
  - [VSCode recommended extensions](#vscode-recommended-extensions)

## Overview

The ember-toucan-core repo is an [Ember v2 addon](https://rfcs.emberjs.com/id/0507-embroider-v2-package-format/). It is setup as a monorepo with the following structure:

- `ember-toucan-core` - the actual Ember addon containing the Toucan components
- `docs-app` - an Ember application used for the documentation site at http://ember-toucan-core.pages.dev
- `docs` - contains markdown files that are consumed by the `docs-app`
- `test-app` - the test app where tests are written

## Clone the repo

The first step in developing in the ember-toucan-core repo is to clone the repo.

```bash
git clone git@github.com:CrowdStrike/ember-toucan-core.git
```

## Install dependencies

ember-toucan-core uses [pnpm](https://pnpm.io) as a package manager. If you're used to yarn or npm, pnpm has the identical commands so you should be right at home!

```bash
cd ember-toucan-core
pnpm install
```

## Adding components

When developing a new component, add it to the `ember-toucan-core` directory. A few things to remember:

1. Components are added under `ember-toucan-core/src/components`
2. When adding a new component it needs to be added to the template registry so that Glint picks it up. To do that, add a line in `ember-toucan-core/src/template-registry.ts`.

## Running the docs/test-app

Prior to running the `docs-app` or `test-app` you'll need to install dependencies:

```bash
cd docs-app
pnpm i
pnpm start
```

```bash
cd test-app
pnpm i
pnpm start
```

## Viewing changes in the docs/test-app

[We're working on making this better](https://github.com/CrowdStrike/ember-toucan-core/issues/40), but for the time being you can use `pnpm link` to create a symlink between the addon and the apps. This will allow you to make a change in the addon and immediately see the change in the app rather than having to stop the app, rebuild, resync dependencies, etc.

```bash
# Create a symlink in the addon
cd ember-toucan-core
pnpm link .

# Link the docs-app
cd ../docs-app
pnpm link @crowdstrike/ember-toucan-core
pnpm i
```

Now the docs-app and addon are linked! Now you'll want to run the addon in watch mode so that it auto-rebuilds and run the docs-app separately.

```bash
# In one terminal
cd ember-toucan-core
pnpm start
# ember-toucan-core is now in watch mode and will rebuild automatically

# In a second terminal
cd docs-app
pnpm start
```

When making a change in `ember-toucan-core`, the `docs-app` should now auto-refresh and you should see your changes.

⚠️ **NOTE**: By linking, you will notice changes in each `package.json` and the `pnpm-lock.yaml` file. You **do not** want to check these changes in. Please discard them or ignore them when committing! ⚠️

## Tests

Tests are written in the `test-app` under `test-app/tests`. We use Glint, so you will see the file extension is `.gts`.

To run the `test-app`:

```bash
cd test-app
pnpm start
```

Like other Ember projects, navigate to localhost:4200/tests to view your tests.

## Documentation

Documentation lives in both the `docs` and `docs-app` directories. For most cases when adding compponents, you'll only need to add markdown files in `docs`. The `docs-app` directory is the Ember app powering the documentation, so it's not as likely to be edited when adding new functionality to ember-toucan-core.

## VSCode setup

### Glint

⚠️ **NOTE**: To successfully use Glint in the `test-app` you'll need to follow the directions [in the Glint VSCode extension](https://marketplace.visualstudio.com/items?itemName=typed-ember.glint-vscode) instructions under "Setup". If you do not do this step, you will see a lot of red lines in your editor! ⚠️

### VSCode recommended extensions

Upon cloning the repo and opening it in VSCode, you may be prompted to download the recommended extensions. This is highly recommended! We've hand picked extensions that assist in writing Glint-powered Ember code. The following workspace settings are also recommended to get prettier auto-save and ESlint working:

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
