//
//  ArticleEntity.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/02/16.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import RealmSwift

class ArticleEntity: Object {
    
    // 記事のフィルタリングに使う
    @objc dynamic var gameName: String!
    @objc dynamic var url: String!
    @objc dynamic var title: String!
    @objc dynamic var image: String!
    @objc dynamic var date: Date!
    @objc dynamic var isFavorite = false
    
    convenience init(_gameName: String, _url: String, _title: String, _image: String, _date: Date) {
        self.init()
        gameName = _gameName
        url = _url
        title = _title
        image = _image
        date = _date
    }

}
