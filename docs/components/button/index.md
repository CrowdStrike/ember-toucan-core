# Button

Buttons are clickable elements used primarily for actions. Button content expresses what action will occur when the user interacts with it.

## Variants

You can customize the appearance of the button with the `@variant` component argument.

<div class="flex gap-x-4">
  <Button @variant="primary">Primary</Button>
  <Button @variant="secondary">Secondary</Button>
  <Button @variant="destructive">Destructive</Button>
  <Button @variant="link">Link</Button>
  <Button @variant="quiet">Quiet</Button>
  <Button @variant="bare">Bare</Button>
</div>

## Handling Clicks

To handle click events use the `@onClick` component argument.

```hbs
<Button @onClick={{this.handleClick}}>Click Me</Button>
```

## Disabled State

`aria-disabled` is used over the `disabled` attribute so that screenreaders can still focus the element. To set the button as disabled, use `@isDisabled`.

```hbs
<Button @isDisabled={{true}}>Disabled</Button>
```

A disabled named block is provided so that users can optionally render additional content when the button is disabled.

```hbs
<Button @isDisabled={{true}}>
  <:disabled>
    <svg
      class='h-4 w-4'
      xmlns='http://www.w3.org/2000/svg'
      width='24'
      height='24'
      stroke='currentColor'
      viewBox='0 0 24 24'
    >
      <path
        d='M18.644 21h-13.2a.945.945 0 01-1-1v-7.2a.945.945 0 011-1h13.1a.945.945 0 011 1V20a.808.808 0 01-.225.725.966.966 0 01-.675.275zm-10.9-9.2V7.3a4.3 4.3 0 118.6 0v4.5m-4.3 3.7v2'
        fill='none'
        stroke-linecap='round'
        stroke-linejoin='round'
        stroke-width='2'
      />
    </svg>
  </:disabled>
  <:default>
    Disabled
  </:default>
</Button>
```

<div class="flex gap-x-4">
  {{#each (array "primary" "secondary" "destructive" "link" "quiet" "bare") as |variant|}}
    <Button @variant={{variant}} @isDisabled={{true}}>
      <:disabled>
        <svg
          class='h-4 w-4'
          xmlns='http://www.w3.org/2000/svg'
          width='24'
          height='24'
          stroke='currentColor'
          viewBox='0 0 24 24'
        >
          <path
            d="M18.644 21h-13.2a.945.945 0 01-1-1v-7.2a.945.945 0 011-1h13.1a.945.945 0 011 1V20a.808.808 0 01-.225.725.966.966 0 01-.675.275zm-10.9-9.2V7.3a4.3 4.3 0 118.6 0v4.5m-4.3 3.7v2"
            fill='none'
            stroke-linecap='round'
            stroke-linejoin='round'
            stroke-width='2'
          />
        </svg>
      </:disabled>
      <:default>
        {{variant}}
      </:default>
    </Button>
  {{/each}}
</div>

## Loading State

Button exposes an `@isLoading` component argument. The button content will be only visible to screenreaders.

```hbs
<Button @isLoading={{true}}>Loading…</Button>
```

A loading named block is also provided for providing custom loading content.

```hbs
<Button @isLoading={{true}}>
  <:loading>
    <svg
      class='h-4 w-4 animate-spin'
      xmlns='http://www.w3.org/2000/svg'
      width='24'
      height='24'
      stroke='currentColor'
      viewBox='0 0 24 24'
    >
      <path
        d='M5.95 5.7L7 6.75 8.05 7.8m8.4 8.4l.95.95.95.95m.2-12.4L17.5 6.75 16.45 7.8M6.35 12h-3.1m17.5 0h-2.6m-5.9 9v-3.1m0-14.9v3.1'
        fill='none'
        stroke-linecap='round'
        stroke-linejoin='round'
        stroke-width='2'
      />
    </svg>
  </:loading>
  <:default>
    Loading…
  </:default>
</Button>
```

<div class="flex gap-x-4">
  {{#each (array "primary" "secondary" "destructive" "link" "quiet" "bare") as |variant|}}
    <Button @variant={{variant}} @isLoading={{true}}>
      <:loading>
        <svg
          class='h-4 w-4 animate-spin'
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          stroke="currentColor"
          viewBox="0 0 24 24"
        >
          <path
            d="M5.95 5.7L7 6.75 8.05 7.8m8.4 8.4l.95.95.95.95m.2-12.4L17.5 6.75 16.45 7.8M6.35 12h-3.1m17.5 0h-2.6m-5.9 9v-3.1m0-14.9v3.1"
            fill="none"
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
          />
        </svg>
      </:loading>
      <:default>
        {{variant}}
      </:default>
    </Button>
  {{/each}}
</div>
