import { assert } from '@ember/debug';

export type AssertBlockOrArg = {
  blockExists: boolean;
  argName: string;
  arg?: string;
  isRequired?: boolean;
};

/**
 * @param {object} AssertBlockOrArg
 *
 **/
const assertBlockOrArgumentExists = ({
  blockExists,
  argName,
  arg,
  isRequired,
}: AssertBlockOrArg) => {
  if (isRequired) {
    assert(
      `You need either :${argName} or @${argName}`,
      Boolean(blockExists || arg)
    );
  }

  assert(
    `You can have :${argName} or @${argName}, but not both`,
    !(blockExists && arg)
  );

  if (blockExists || arg) {
    return true;
  }

  return false;
};

export default assertBlockOrArgumentExists;
