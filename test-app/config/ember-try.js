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
      embroiderOptimized({
        name: 'ember-lts-4.8 + embroider-optimized',
        npm: {
          dependencies: {
            '@embroider/compat': '3.1.4',
          },
          devDependencies: {
            'ember-source': '~4.8.0',
            '@embroider/core': '3.1.2',

            '@embroider/webpack': '3.1.2',
          },
        },
      }),
      embroiderOptimized({
        name: 'ember-release + embroider-optimized',
        npm: {
          dependencies: {
            '@embroider/compat': '3.1.4',
          },
          devDependencies: {
            'ember-source': releaseVersion,
            '@embroider/core': '3.1.2',
            '@embroider/webpack': '3.1.2',
          },
        },
      }),
    ],
  };
};
