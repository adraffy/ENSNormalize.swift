//
//  StringExt.swift
//  ENSNormalize
//
//  Created by raffy.eth on 8/23/25.
//

extension String {

    public func ensNormalized() throws -> String {
        return try ENSIP15.normalize(self)
    }

    public func ensBeautified() throws -> String {
        return try ENSIP15.beautify(self)
    }
    
}
