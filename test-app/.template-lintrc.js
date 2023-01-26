'use strict';

module.exports = {
  extends: 'recommended',

  overrides: [
    // Disabling this rule allows us to write tests like the following:
    //
    // let handleClick = () => {};
    // <Button @onClick={{handleClick}} />
    //
    // Instead of having to set the click handler on `this`.
    //
    // The error message this resolves is:
    // error  Ambiguous path 'handleClick' is not allowed. Use '@handleClick' if it is a named argument or 'this.handleClick' if it is a property on 'this'. If it is a helper or component that has no arguments, you must either convert it to an angle bracket invocation or manually add it to the 'no-implicit-this' rule configuration, e.g. 'no-implicit-this': { allow: ['handleClick'] }.  no-implicit-this
    //
    // We should be able to remove this once https://github.com/ember-template-lint/ember-template-lint/issues/2785 is completed
    {
      files: ['tests/**'],
      rules: {
        'no-implicit-this': false,
      },
    },
  ],
};
