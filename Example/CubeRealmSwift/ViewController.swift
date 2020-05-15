//
//  ViewController.swift
//  CubeRealmSwift
//
//  Created by gg19910817 on 05/14/2020.
//  Copyright (c) 2020 gg19910817. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        mockUser()
//        mockGroup()
//        mockUserMessage()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func tapAction(tap: UITapGestureRecognizer) {
        let vc = ConversationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mockGroup() {
        // Get the default Realm
        let realm = try! Realm()
        
        let groups = List<Group>()
        for i in 1...1000 {
            let group = Group()
            group.id = String(10000 + i)
            group.name = "Group\(10000 + i)"
            let users = group.users
            for j in 1...8000 {
                let user: User? = realm.object(ofType: User.self, forPrimaryKey: String(1000000 + j))
                let groupUser = GroupUser()
                groupUser.user = user
                groupUser.avatar = "http://www.cs999.com/avatar/\(user!.id!)"
                groupUser.name = "GroupUserName"
                users.append(groupUser)
            }
            groups.append(group)
        }
        
        // Persist your data easily
        try! realm.write {
            realm.add(groups)
        }
    }
    
    func mockUser() {
        let users = List<User>()
        
        for i in 1...100000 {
            let user = User()
            user.id = String(1000000 + i)
            user.name = "user\(user.id!)"
            user.avatar = "http://www.cs999.com/avatar/\(user.id!)"
            users.append(user)
        }
        
        // Get the default Realm
        let realm = try! Realm()
        // Persist your data easily
        try! realm.write {
            realm.add(users)
        }
    }
    
    func mockUserMessage() {
        
        // Get the default Realm
        let realm = try! Realm()
        
        let list = List<Conversation>()
        
        for i in 1...10 {
            let conversation = Conversation()
            let user: User? = realm.object(ofType: User.self, forPrimaryKey: String(1000000 + 8000*i + i))
            conversation.receiver = user
            let messages = conversation.messages
            for j in 1...20000 {
                let message = Message()
                message.sender = user
                message.date = Date()
                let elems = message.elems
                for k in 1...3 {
                    let elem = MessageElem()
                    elem.type = k%3
                    if elem.type == 0 {
                        elem.content = "/Users/gg19910817/Library/Developer/CoreSimulator/Devices/50AEB5D7-785C-41C1-9198-66767DE93CEE/data/Containers/Data/Application/1076CA45-E5AC-4DDD-8240-0827A24DAF56"
                    }
                    if elem.type == 1 {
                        elem.content = "https://www.cs999.com/jpg.txt"
                    }
                    if elem.type == 2 {
                        elem.content = "https://www.cs999.com/jpg.jpg"
                    }
                    if elem.type == 3 {
                        elem.content = "https://www.cs999.com/amr.amr"
                    }
                    elems.append(elem)
                }
                messages.append(message)
            }
            list.append(conversation)
        }
        
        
        // Persist your data easily
        try! realm.write {
            realm.add(list)
        }
        
    }

}

