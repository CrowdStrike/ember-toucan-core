/**
 * Callback used for input change events.
 */
export type OnChangeCallback<T> = (value: T, e: Event | InputEvent) => void;

/**
 * Reusable type for handling error messages. At the moment, we support
 * either a single string or an array of strings.
 *
 * Normally used with the private `Error` component and consumed by
 * components for their `@error` component argument.
 */
export type ErrorMessage = string | Array<string>;
