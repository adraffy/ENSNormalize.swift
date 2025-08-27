//
//  EmojiNode.swift
//  ENSNormalize
//
//  Created by raffy.eth on 8/24/25.
//

public struct EmojiNode: Sendable {

    let emoji: EmojiSequence?
    let map: [Cp: EmojiNode]?

    init(_ emoji: EmojiSequence?, _ map: [Cp: EmojiNode]?) {
        self.emoji = emoji
        self.map = map
    }

}

class EmojiNodeBuilder {

    var emoji: EmojiSequence?
    var map: [Cp: EmojiNodeBuilder]?

    func then(_ cp: Cp) -> EmojiNodeBuilder {
        if map == nil {
            map = [:]
        }
        if let node = map![cp] {
            return node
        }
        let node = EmojiNodeBuilder()
        map![cp] = node
        return node
    }

    func build() -> EmojiNode {
        return EmojiNode(
            emoji,
            map?.mapValues {
                $0.build()
            }
        )
    }

}
