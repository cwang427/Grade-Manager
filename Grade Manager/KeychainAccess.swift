//
//  KeychainAccess.swift
//  ProgressBook DCS
//
//  Created by Cassidy Wang on 11/18/15.
//  Copyright © 2015 Cassidy Wang. All rights reserved.
//
//  Adapted from Stack Overflow
//  http://stackoverflow.com/questions/25513106/trying-to-use-keychainitemwrapper-by-apple-translated-to-swift

import UIKit;
import Security;

let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword);
let kSecClassValue = NSString(format: kSecClass);
let kSecAttrServiceValue = NSString(format: kSecAttrService);
let kSecValueDataValue = NSString(format: kSecValueData);
let kSecMatchLimitValue = NSString(format: kSecMatchLimit);
let kSecReturnDataValue = NSString(format: kSecReturnData);
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne);
let kSecAttrAccountValue = NSString(format: kSecAttrAccount);

class KeychainAccess: NSObject {
    
    func setKeychain(identifier: String, value: String) {
        let dataFromString: NSData = value.dataUsingEncoding(NSUTF8StringEncoding)!;
        let keychainQuery = NSDictionary(
            objects: [kSecClassGenericPasswordValue, identifier, dataFromString],
            forKeys: [kSecClassValue, kSecAttrServiceValue, kSecValueDataValue]);
        SecItemDelete(keychainQuery as CFDictionaryRef);
        let _: OSStatus = SecItemAdd(keychainQuery as CFDictionaryRef, nil);
    }
    
    func getKeychain(identifier: String) -> NSString? {
        let keychainQuery = NSDictionary(
            objects: [kSecClassGenericPasswordValue, identifier, kCFBooleanTrue, kSecMatchLimitOneValue],
            forKeys: [kSecClassValue, kSecAttrServiceValue, kSecReturnDataValue, kSecMatchLimitValue]);
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var passcode: NSString?;
        if (status == errSecSuccess) {
            let retrievedData: NSData? = dataTypeRef as? NSData
            if let result = NSString(data: retrievedData!, encoding: NSUTF8StringEncoding) {
                passcode = result as String
            }
        }
        else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        return passcode;
    }
}