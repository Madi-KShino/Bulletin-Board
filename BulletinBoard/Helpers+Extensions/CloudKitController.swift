//
//  CloudKitController.swift
//  BulletinBoard
//
//  Created by Madison Kaori Shino on 7/8/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    
    //SINGLETON
    static let sharedInstance = CloudKitController()
    
    //DATABASE INSTANCES
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    //CRUD FUNCTIONS
    //CREATE RECORD PASSED IN
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        database.save(record) { (_, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            print(#function)
            completion(true)
        }
    }
    
    //READ
    func fetchRecordsOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        
        //CONDITIONS OF QUERY
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: type, predicate: predicate)
        
        //PERFORM QUERY
        database.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(nil, error)
            }
            
            if let records = records {
                completion(records, nil)
            }
        }
    }
}
