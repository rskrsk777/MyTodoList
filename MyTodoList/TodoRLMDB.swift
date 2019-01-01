//
//  TodoRLMDB.swift
//  MyTodoList
//
//  Created by ryosuke kubo on 2018/12/31.
//  Copyright © 2018 ryosuke kubo. All rights reserved.
//

import Realm
import RealmSwift

class TodoRLMDB: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var todoName = ""
    @objc dynamic var todoDate = Date()
    @objc dynamic var todoPriority = 1
    override static func primaryKey() -> String {
        return "id"
    }
    
}

