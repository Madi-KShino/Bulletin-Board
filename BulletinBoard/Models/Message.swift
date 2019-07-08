//
//  Message.swift
//  BulletinBoard
//
//  Created by Madison Kaori Shino on 7/8/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import CloudKit

//DECLARE & INITIALIZE CLASS OBJECT PROPERTIES
class Message {
    
    let text: String
    let timeStamp: Date
    
    //KEYS FOR CLOUD KIT STORAGE
    static let typeKey = "Message"
    private let textKey = "Text"
    private let timeStampKey = "Timestamp"
    
    //MESSAGE CLASS COMPUTED PROPERTY FOR CKRECORD
    var cloudKitRecord: CKRecord {
        
        let record = CKRecord(recordType: Message.typeKey)
        record.setValue(text, forKey: textKey)
        record.setValue(timeStamp, forKey: timeStampKey)
        
        return record
    }
    
    init(text: String, timeStamp: Date = Date()) {
        self.text = text
        self.timeStamp = timeStamp
    }
    
    //FAILABLE INITIALIZER TO PASS IN CKRECORD
    init?(record: CKRecord) {
        
        guard let text = record[textKey] as? String,
        let timeStamp = record[timeStampKey] as? Date
        else { return nil }
        
        self.text = text
        self.timeStamp = timeStamp
    }
}

