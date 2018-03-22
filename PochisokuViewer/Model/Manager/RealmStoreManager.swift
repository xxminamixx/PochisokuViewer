//
//  RealmStoreManager.swift
//  PochisokuViewer
//
//  Created by kyohei.minami on 2018/02/22.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import RealmSwift

class RealmStoreManager: Object {
    
    // MARK: ジェネリック関数
    
    /// RealmのObjectEntityを保存
    ///
    /// - Parameter object: Objectを継承したEntity
    static func addEntity<T: Object>(object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object)
        }
    }
    
    
    /// 指定したオブジェクトを削除
    ///
    /// - Parameter object: 任意のオブジェクト
    static func delete<T: Object>(object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }
    
    /// 指定したtypeのEntityListを返却する
    ///
    /// - Parameter type: Entityの型を指定する
    /// - Returns: 指定されたEntityListを返却する
    static func entityList<T: Object>(type: T.Type) -> Results<T> {
        let realm = try! Realm()
        return realm.objects(type.self)
    }
    
    
    /// 指定したtypeのEntityListの長さを返す
    ///
    /// - Parameter type: Entityの型を指定する
    /// - Returns: 指定されたEntityListの長さを返す
    static func countEntity<T: Object>(type: T.Type) -> Int {
        return entityList(type: type).count
    }
    
    /// 指定した型のEntityから任意のプロパティを指定してフィルタリングした配列を返却する
    ///
    /// - Parameters:
    ///   - type: Entityの型を指定する
    ///   - property: フィルタリングをしたいプロパティ名を指定する
    ///   - filter: フィルタリング条件を入力する(型がわからないのでAny型としている)
    /// - Returns: フィルタリングされたEntityが返却される
    static func filterEntityList<T: Object>(type: T.Type, property: String, filter: Any) -> Results<T> {
        return entityList(type: type).filter("%K == %@", property, String(describing: filter))
    }
    
    static func filterEntityList<T: Object>(type: T.Type, property: String, filter: Bool) -> Results<T> {
        return entityList(type: type).filter("%K == %d", property, filter)
    }
    
    /// クロージャに更新処理を渡す
    ///
    /// - Parameter closure: 更新処理
    static func save(closure: () -> Void) {
        let realm = try! Realm()
        try! realm.write {
            closure()
        }
    }
    
}
