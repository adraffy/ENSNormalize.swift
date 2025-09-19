# ENSNormalize.swift
0-dependency [ENSIP-15](https://docs.ens.domains/ensip/15) in Swift

* Reference Implementation: [adraffy/ens-normalize.js](https://github.com/adraffy/ens-normalize.js)
	* Unicode: `17.0.0`
	* Spec Hash: [`4febc8f5d285cbf80d2320fb0c1777ac25e378eb72910c34ec963d0a4e319c84`](https://github.com/adraffy/ens-normalize.js/blob/main/derive/output/spec.json)
* ✅️ Passes **100%** [ENSIP-15 Validation Tests](https://github.com/adraffy/ens-normalize.js/blob/main/validate/tests.json)
* ✅️ Passes **100%** [Unicode Normalization Tests](https://github.com/adraffy/ens-normalize.js/blob/main/derive/output/nf-tests.json)

```java
import ENSNormalize
ENSIP15.shared // Main Library (global instance)
```

### Primary API [ENSIP15](./Sources/ENSNormalize/ENSIP15.swift)

```Swift
// String -> String
// throws on invalid names
try "RaFFY🚴‍♂️.eTh".ensNormalized() // "raffy🚴‍♂.eth"

// works like ensNormalized()
try "1⃣2⃣.eth".ensBeautified() // "1️⃣2️⃣.eth"
```

### Normalization Properties

* [Group](./Sources/ENSNormalize/Group.swift) — `.groups: [Group]`
* [EmojiSequence](./Sources/ENSNormalize/EmojiSequence.swift) — `.emojis: [EmojiSequence]`
* [Whole](./Sources/ENSNormalize/Whole.swift) — `.wholes: [Whole]`

### Error Handling

All errors are safe to print. [NormError](./Sources/ENSNormalize/NormError.swift) is the error enum.

### Unicode [Normalization Forms](./Sources/ENSNormalize/NF.swift)

```Swift
import ENSNormalize

// [Cp] -> [Cp]
ENSIP15.shared.nf.C([0x65, 0x300]) // [0xE8]
ENSIP15.shared.nf.D([0xE8])        // [0x65, 0x300]
```

## Publish Instructions

* [Sync and Compress](./compress/)
* `swift test`
* `swift build`
