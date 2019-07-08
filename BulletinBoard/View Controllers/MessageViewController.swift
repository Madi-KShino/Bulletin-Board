//
//  MessageViewController.swift
//  BulletinBoard
//
//  Created by Madison Kaori Shino on 7/8/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    //OUTLETS
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //LIFECYCLE
    override func viewDidLoad() {
    
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        MessageController.sharedInstance.fetchMessageRecords()
    }
    
    //ACTIONS
    @IBAction func addButtonTapped(_ sender: Any) {
        
        guard let messageText = messageTextField.text, messageText != "" else { return }
        MessageController.sharedInstance.saveMessageRecord(messageText)
    }
}

//TABLE VIEW DATA
extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.sharedInstance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let message = MessageController.sharedInstance.messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.timeStamp.formatDate()
        
        return cell
    }
}
