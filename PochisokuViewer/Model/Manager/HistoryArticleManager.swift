//
//  HistoryArticleManager.swift
//  PochisokuViewer
//
//  Created by kyohei.minami on 2018/02/21.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit
import RealmSwift

class ArticleManager: Object {
    // 履歴保持用
    static var HistoryArticleList: Results<ArticleEntity>?
    // お気に入り保持用
    static var favoriteList: Results<ArticleEntity>?
}
