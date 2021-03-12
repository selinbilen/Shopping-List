//
//  database.swift
//  HW-04
//
//  Created by selin eylül bilen on 3/11/21.
//

import Foundation
import SQLite

struct itemSt{
    var id:Int64 = 0
    var item:String = ""
    var num:String = ""
}

class database{
    var db:Connection!
    var itemTable = Table("grc")
    let id = Expression<Int64>("id")
    let item = Expression<String?>("item")
    let num = Expression<String>("num")
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    func Conn(){
        let dbPath = path + "/db.cs441"
        print("Full Path: \(dbPath)")
        db = try! Connection(dbPath)
        
        do{
            try db.scalar(itemTable.exists)
        }catch{
            try! db.run(itemTable.create{ t in
                t.column(id, primaryKey: true)
                t.column(item)
                t.column(num)
            })
        }
    }
    func insertItem(item: String, num: String) -> Int64{
        do{
            let insert = itemTable.insert(self.item <- item, self.num <- num)
            return try db.run(insert)
        }catch{
            return -1
        }
    }
    func itemList()->[itemSt]{
        var arr:[itemSt] = []
        let items = try! db.prepare(itemTable)
        for i in items{
            //print(i[item]!)
            let it = itemSt(id: i[id], item: i[item]!, num: i[num])
            arr.append(it)
        }
        return arr
    }
    func itemDelete(itemID:Int64) -> Int{
        let alice = itemTable.filter(id == itemID)
        return try! db.run(alice.delete())
    }
}
