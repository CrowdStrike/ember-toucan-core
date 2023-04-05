/**
 * @param {boolean} blockExists
 * @param {string} arg
 *
 * @returns boolean
 **/
const hasEitherBlockOrArg = (blockExists: boolean, arg?: string) =>
  Boolean(blockExists || arg);

export default hasEitherBlockOrArg;
