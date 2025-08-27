# ENSNormalize.swift
0-dependency [ENSIP-15](https://docs.ens.domains/ensip/15) in Swift

* Reference Implementation: [adraffy/ens-normalize.js](https://github.com/adraffy/ens-normalize.js)
	* Unicode: `16.0.0`
	* Spec Hash: [`4b3c5210a328d7097500b413bf075ec210bbac045cd804deae5d1ed771304825`](https://github.com/adraffy/ens-normalize.js/blob/main/derive/output/spec.json)
* ❌️ Passes **100%** [ENSIP-15 Validation Tests](https://github.com/adraffy/ens-normalize.js/blob/main/validate/tests.json)
* Passes **100%** [Unicode Normalization Tests](https://github.com/adraffy/ens-normalize.js/blob/main/derive/output/nf-tests.json)

```java
import ENSNormalize
ENSIP15.shared // Main Library (global instance)
```

### Primary API [ENSIP15](./Sources/ENSNormalize/ENSIP15.swift)

```swift
// String -> String
// throws on invalid names
try "RaFFY🚴‍♂️.eTh".ensNormalized() // "raffy🚴‍♂.eth"

// works like ensNormalized()
try "1⃣2⃣.eth".ensBeautified() // "1️⃣2️⃣.eth"
```

### Normalization Properties

* [Group](./Sources/ENSNormalize/Group.swift) — `ENSIP15.groups: [Group]`
* [EmojiSequence](./Sources/ENSNormalize/EmojiSequence.swift) — `ENSIP15.emojis: [EmojiSequence]`
* [Whole](./Sources/ENSNormalize/Whole.swift) — `ENSIP15.wholes: [Whole]`

### Error Handling

All errors are safe to print. [NormError](./Sources/ENSNormalize/NormError.swift) is the error enum.

### Unicode Normalization Forms [NF](./Sources/ENSNormalize/NF.swift)

```swift
import ENSNormalize

// [Cp] -> [Cp]
ENSIP15.shared.nf.C(0x65, 0x300); // [0xE8]
ENSIP15.shared.nf.D(0xE8);        // [0x65, 0x300]
```

## Publish Instructions

* [Sync and Compress](./compress/)
* `swift test`
* `swift build`
