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
    
    enum GameTitle: String {
        case pubg =  "pubg"
        case fortnite = "fortnite"
    }
    
    // 履歴保持用
    static var HistoryArticleList: Results<ArticleEntity>?
    // お気に入り保持用
    static var favoriteList: Results<ArticleEntity>?
    
    /// 指定したゲームタイトルの履歴配列を返却する
    ///
    /// - Parameter gameTitle: ゲーム名のenum
    /// - Returns: 指定したゲーム履歴の配列
    static func historyList(gameTitle: GameTitle) -> Results<ArticleEntity>? {
        let histroyList = HistoryArticleList?.filter("gameName = %@", gameTitle.rawValue)
        return histroyList
    }
    
    /// 履歴記事の個数を返す
    ///
    /// - Returns: 記事の履歴の数
    static func historyListCount(gameTitle: GameTitle) -> Int {
        return (historyList(gameTitle: gameTitle)?.count) ?? 0
    }
}
