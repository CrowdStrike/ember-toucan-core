'use strict';

const path = require('path');
const { tailwindConfig } = require('@crowdstrike/ember-oss-docs/tailwind');

const config = tailwindConfig(__dirname, {
  content: [path.join(__dirname, '../docs/**/*.md')],

  // Temporary for testing for a preview URL.
  // DO NOT MERGE!
  theme: {
    extend: {
      boxShadow: {
        'form-error-focus':
          'inset 0 0 0 2px var(--critical), 0 0 0 2px var(--surface-base), 0 0 0 4px var(--focus)',
      },
    },
  },
});

module.exports = config;
