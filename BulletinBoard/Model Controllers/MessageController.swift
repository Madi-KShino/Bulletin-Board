//
//  MessageController.swift
//  BulletinBoard
//
//  Created by Madison Kaori Shino on 7/8/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation

class MessageController {
    
    //SHARED INSTANCE
    static let sharedInstance = MessageController()
    
    //SOURCE OF TRUTH
    var messages: [Message] = []
    
    //CRUD FUNCTIONS
    //CREATE
    func saveMessageRecord(_ text: String) {
        
        //INIT A MESSAGE
        let messageToSave = Message(text: text)
        let database = CloudKitController.sharedInstance.publicDatabase
        
        //CALL SAVE FUNC
        CloudKitController.sharedInstance.saveRecordToCloudKit(record: messageToSave.cloudKitRecord, database: database) { (success) in
            if success {
                print("Successfully saved message to CloudKit")
                self.messages.append(messageToSave)
            }
        }
    }
    
    //READ
    func fetchMessageRecords() {
        
        let database = CloudKitController.sharedInstance.publicDatabase
        CloudKitController.sharedInstance.fetchRecordsOf(type: Message.typeKey, database: database) { (records, error) in
            
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
        }
            
            //INIT MESSAGES FROM FOUNDRECORDS, CREATE NEW ARRAY FROM SUCCESS
            guard let foundRecords = records else { return }
            let messages = foundRecords.compactMap( {Message(record: $0)} )
            
            //SET SOURCE OF TRUTH
            self.messages = messages
        }
    }
}
