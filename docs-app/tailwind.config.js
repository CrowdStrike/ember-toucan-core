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
        'form-read-only': 'inset 0 0 0 1px var(--disabled)',
      },
    },
  },
});

module.exports = config;
