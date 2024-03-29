'use strict';

module.exports = {
  plugins: ['prettier-plugin-ember-template-tag'],
  singleQuote: true,
  templateSingleQuote: false,

  overrides: [
    {
      files: '*.{js,ts}',
      options: {
        singleQuote: true,
      },
    },
    {
      files: '*.hbs',
      options: {
        singleQuote: false,
      },
    },
    // this was required to make the VSCode + Prettier work correctly with <template>, see https://github.com/gitKrystan/prettier-plugin-ember-template-tag/issues/38
    // we should roll this back once that issue has been fixed!
    {
      files: '*.gjs',
      options: {
        parser: 'ember-template-tag',
      },
    },
    {
      files: '*.gts',
      options: {
        parser: 'ember-template-tag',
      },
    },
  ],
};
