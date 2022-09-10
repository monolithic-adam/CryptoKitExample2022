//
//  Keychain.swift
//  CryptoKitExample2022
//
//  Created by Adam Henry on 2022/08/16.
//

import Foundation
import KeychainAccess
import CryptoKit

class KeyChainCryptographerKeyStore: CryptographerKeyStore {
    private let keychain = KeychainAccess.Keychain(service: Bundle.main.bundleIdentifier!)

    func createAndSaveKey(key: String) -> SymmetricKey {
        let saveKey = SymmetricKey(size: .bits256)
        let data = saveKey.withUnsafeBytes { Data(Array($0)) }
        keychain[data: key] = data
        return saveKey
    }

    func fetch(_ key: String) -> SymmetricKey? {
        let data = keychain[data: key]
        return data.flatMap { SymmetricKey(data: $0) }
    }
}
