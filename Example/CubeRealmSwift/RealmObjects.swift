//
//  RealmObjects.swift
//  CubeRealmSwift_Example
//
//  Created by gg19910817 on 2020/5/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RealmSwift

/*
 Tips: Realm
 1. 所有定义的Object在第一次读取数据库的时候会全部加载，所以过多会导致性能问题。
 */

// 群组表
class Group: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    let users = List<GroupUser>()
    
    // 主键
    override static func primaryKey() -> String? {
        return "id"
    }
}

// 群组用户表 0:普通用户 1:管理员 2:群主
class GroupUser: Object {
    @objc dynamic var type = 0
    @objc dynamic var user: User?
    @objc dynamic var name: String?
    @objc dynamic var avatar: String?
}

// 用户表
class User: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var avatar: String?
    
    // 主键
    override static func primaryKey() -> String? {
        return "id"
    }
}

// 好友关系
class FriendShip: Object {
    @objc dynamic var user: User?
}

// 会话，包含 0:单聊 1:群聊
class Conversation: Object {
    @objc dynamic var type = 0
    var name: String? {
        return type == 0 ? receiver?.name : group?.name
    }
    @objc dynamic var receiver: User?
    @objc dynamic var group: Group?
    let messages = List<Message>()
}

// 消息，一条消息可能存在多个Elem
class Message: Object {
    @objc dynamic var sender: User?
    @objc dynamic var date: Date?
    let elems = List<MessageElem>()
}

// 消息的基本元素，例如文本，文件，图片，语音。
class MessageElem: Object {
    @objc dynamic var type = 0
    // 文本消息此处为文本，其他消息为Url
    @objc dynamic var content: String?
    /*
     Tips: Realm双向关联
     1. 建立Message和Elem的双向关联，比在这里定义一个message更有意义。
     2. 这里能获得所有elems中包含此Elem的Message，所以是一个数组。
     */
//    let messages = LinkingObjects(fromType: Message.self, property: "elems")
}
