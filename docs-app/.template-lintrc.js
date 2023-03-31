'use strict';

module.exports = {
  extends: 'recommended',

  overrides: [
    {
      files: ['**/*.gjs', '**/*.gts'],
      rules: {
        'no-implicit-this': { allow: ['DARK'] },
      },
    },
  ],
};
