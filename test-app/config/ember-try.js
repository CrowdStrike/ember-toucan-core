'use strict';

const getChannelURL = require('ember-source-channel-url');
const { embroiderOptimized } = require('@embroider/test-setup');

module.exports = async function () {
  let releaseVersion = await getChannelURL('release');

  return {
    usePnpm: true,
    scenarios: [
      {
        name: 'ember-4.8',
        npm: {
          devDependencies: {
            'ember-source': '~4.8.0',
          },
        },
      },
      {
        name: 'ember-release',
        npm: {
          devDependencies: {
            'ember-source': await getChannelURL('release'),
          },
        },
      },
      {
        name: 'ember-beta',
        npm: {
          devDependencies: {
            'ember-source': await getChannelURL('beta'),
          },
        },
      },
      {
        name: 'ember-canary',
        npm: {
          devDependencies: {
            'ember-source': await getChannelURL('canary'),
          },
        },
      },
      // @todo Temporarily disabling embroider optimized tests due to https://github.com/CrowdStrike/ember-toucan-core/issues/210
      embroiderOptimized({
        name: 'ember-lts-4.8 + embroider-optimized',
        npm: {
          devDependencies: {
            'ember-source': '~4.8.0',
            // @todo remove this once we have a stable release that includes https://github.com/embroider-build/embroider/pull/1383, which should be https://github.com/embroider-build/embroider/pull/1408
            '@embroider/core': '2.1.2-unstable.c58f146',
            '@embroider/compat': '2.1.2-unstable.c58f146',
            '@embroider/webpack': '2.1.2-unstable.c58f146',
          },
        },
      }),
      embroiderOptimized({
        name: 'ember-release + embroider-optimized',
        npm: {
          devDependencies: {
            'ember-source': releaseVersion,
            // @todo remove this once we have a stable release that includes https://github.com/embroider-build/embroider/pull/1383, which should be https://github.com/embroider-build/embroider/pull/1408
            '@embroider/core': '2.1.2-unstable.c58f146',
            '@embroider/compat': '2.1.2-unstable.c58f146',
            '@embroider/webpack': '2.1.2-unstable.c58f146',
          },
        },
      }),
    ],
  };
};
