//
//  ConversationViewController.swift
//  CubeRealmSwift_Example
//
//  Created by gg19910817 on 2020/5/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RealmSwift

class ConversationViewController: UITableViewController {
    
    var dataSource: Results<Conversation>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        let realm = try! Realm()
        dataSource = realm.objects(Conversation.self)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! UITableViewCell

        let object = dataSource?[indexPath.row]
        cell.textLabel?.text = object?.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let object = dataSource?[indexPath.row]
        let vc = MessageViewController.init(conversation: object!)
        navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
