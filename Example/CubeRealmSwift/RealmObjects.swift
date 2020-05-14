//
//  RealmObjects.swift
//  CubeRealmSwift_Example
//
//  Created by gg19910817 on 2020/5/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RealmSwift

// 群组表
class Group: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    let users = List<GroupUser>()
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
}

// 好友关系
class FriendShip: Object {
    @objc dynamic var user: User?
}

// 会话，包含 0:单聊 1:群聊 2:
class Conversation: Object {
    @objc dynamic var type = 0
    let messages = List<Message>()
}

// 消息，一条消息可能存在多个Elem
class Message: Object {
    @objc dynamic var sender: User?
    let elems = List<MessageElem>()
}

// 消息的基本元素，例如文本，文件（图片，语音）。
class MessageElem: Object {
    @objc dynamic var type = 0
    @objc dynamic var data: Data?
}
