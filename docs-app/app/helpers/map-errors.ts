import Helper from '@ember/component/helper';

type Positional = [rawErrors: { message: string }[]];

interface Signature {
  Args: {
    Positional: Positional;
  };
  Return: string[];
}

export default class AddHelper extends Helper<Signature> {
  public compute(positional: Positional): string[] {
    const [rawErrors] = positional;

    if (!rawErrors) return;

    return rawErrors.map((error) => error.message);
  }
}
