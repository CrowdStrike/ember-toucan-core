---
'@crowdstrike/ember-toucan-form': minor
'@crowdstrike/ember-toucan-core': patch
---

`@crowdstrike/ember-toucan-form` now exposes the following components to use when building forms:

- [Textarea](https://github.com/CrowdStrike/ember-toucan-core/pull/129)
- [Input](https://github.com/CrowdStrike/ember-toucan-core/pull/134)
- [Checkbox](https://github.com/CrowdStrike/ember-toucan-core/pull/135)
- [RadioGroup](https://github.com/CrowdStrike/ember-toucan-core/pull/136)
- [CheckboxGroup](https://github.com/CrowdStrike/ember-toucan-core/pull/137)

`@crowdstrike-ember-toucan-core` was updated to resolve TypeScript errors and regressions:

- `CheckboxGroup` `@error` argument now [accepts an array of strings](https://github.com/CrowdStrike/ember-toucan-core/pull/137/files#diff-4944b98b6785745979290458ace369f4a4c4125a1b77e7b269421dfc51a820efR17)
- `CheckboxGroup` had a regression with the root `data-*` attribute that has been [resolved](https://github.com/CrowdStrike/ember-toucan-core/pull/136/files#diff-be94a63c54dadd43884220fa6817230be44d6789f30da3ba28a716bbd941f3f4R5) by re-adding the component argument
- `RadioGroup` had a regression with the root `data-*` attribute that has been [resolved](https://github.com/CrowdStrike/ember-toucan-core/pull/136/files#diff-1857c5ed8e778b21fbcd8a18a40754ab5c9d38bcd1ad521bdf4a0c03bf57a808R7)
