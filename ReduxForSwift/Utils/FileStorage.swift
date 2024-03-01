//
//  FileStorage.swift
//  
//


import Foundation

@propertyWrapper
struct FileStorage<T: Codable> {
    var value: T?
    
    let directory: FileManager.SearchPathDirectory
    let fileName: String
    
    init(directory: FileManager.SearchPathDirectory, fileName: String) {
        value = try? FileHelper.loadJSON(from: directory, fileName: fileName)
        self.directory = directory
        self.fileName = fileName
    }
    
    var wrappedValue: T? {
        set {
            value = newValue
            if let value = newValue {
                try? FileHelper.writeJSON(value, to: directory, fileName: fileName)
            } else {
                try? FileHelper.delete(from: directory, fileName: fileName)
            }
        }
        
        get { value }
    }
    
}


@propertyWrapper
struct UserDefaultsStorage<T: Codable> {
    var value: T?
    let keyName: String

    init(keyName: String) {
        self.keyName = keyName
        self.value = UserDefaults.standard.object(forKey: keyName) as? T
    }
    
    var wrappedValue: T? {
        set {
            value = newValue
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: keyName)
            } else {
                UserDefaults.standard.removeObject(forKey: keyName)
            }
            UserDefaults.standard.synchronize()
        }
        
        get { value }
    }
    
}
