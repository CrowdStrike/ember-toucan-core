import { assert } from '@ember/debug';

export type AssertBlockOrArg = {
  blockExists: boolean;
  argName: string;
  arg?: string;
  required?: boolean;
};

/**
 * @param {object} AssertBlockOrArg
 *
 **/
const assertBlockExists = ({
  blockExists,
  argName,
  arg,
  required,
}: AssertBlockOrArg) => {
  if (required) {
    assert(
      `You need either :${argName} or @${argName}`,
      Boolean(blockExists || arg)
    );
  }

  assert(
    `You can have :${argName} or @${argName}, but not both`,
    !(blockExists && arg)
  );
};

export default assertBlockExists;
