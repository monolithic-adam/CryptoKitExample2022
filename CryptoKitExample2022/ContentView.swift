//
//  ContentView.swift
//  CryptoKitExample2022
//
//  Created by Adam Henry on 2022/08/16.
//

import SwiftUI

struct ContentView: View {
    @State var encryptableString: String = ""
    @State var encryptedString: String?
    @State var encryptedStringData: Data?
    @State var decryptedString: String?
    
    static let encryptKey = "encryptKey"
    static let keyStore = KeyChainCryptographerKeyStore()
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("String to Encode", text: $encryptableString)
                .padding()
                .border(.gray, width: 1)
            Text(encryptedString ?? "")
                .padding()
                .border(.gray, width: 1)
            Button("Encode") {
                guard encryptableString != "" else { return }
                encryptedStringData = try! Cryptographer(target: Self.encryptKey, keyStore: Self.keyStore).encrypt(encryptableString)
                encryptedString = String(decoding: encryptedStringData!, as: UTF8.self)
            }
            Text(decryptedString ?? "")
                .padding()
                .border(.gray, width: 1)
            Button("Decode") {
                guard let encryptedStringData = encryptedStringData else { return }
                decryptedString = try! Cryptographer(target: Self.encryptKey, keyStore: Self.keyStore).decrypt(encryptedStringData)
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
