//
//  Cryptographer.swift
//  CryptoKitExample2022
//
//  Created by Adam Henry on 2022/08/16.
//

import Foundation
import CryptoKit

class Cryptographer {
    let key: SymmetricKey
    
    init(target: String, keyStore: CryptographerKeyStore) {
        if let key = keyStore.fetch(target) {
            self.key = key
        } else {
            self.key = keyStore.createAndSaveKey(key: target)
        }
    }
    
    func encrypt(_ string: String) throws -> Data {
        let data = string.data(using: .utf8)!
        let encryptedBox = try ChaChaPoly.seal(data, using: key)
        return try ChaChaPoly.SealedBox(combined: encryptedBox.combined).combined
    }

    func decrypt(_ data: Data) throws -> String {
        let sealedBox = try ChaChaPoly.SealedBox(combined: data)
        let sealedBoxToOpen = try ChaChaPoly.SealedBox(combined: sealedBox.combined)
        let decryptedData = try ChaChaPoly.open(sealedBoxToOpen, using: key)
        return String(decoding: decryptedData, as: UTF8.self)
    }
}

protocol CryptographerKeyStore {
    func createAndSaveKey(key: String) -> SymmetricKey
    func fetch(_ key: String) -> SymmetricKey?
}
