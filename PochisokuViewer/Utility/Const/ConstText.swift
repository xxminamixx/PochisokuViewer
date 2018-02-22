//
//  ConstText.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/02/16.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit

//class ConstText: NSObject {
//
//}

struct ConstText {
    
    // MARK: URL
    
    // スクレイピングを開始するURL
    static let pochisokuURL = "https://pubg.jp"
    
    // MARK: XPath
    static let kanrenURLXPath = "//div[@id='st-magazine']/div/div/dl/a"
    static let kanrenTitleXPath = "//div[@id='st-magazine']/div/div/dl/dd/div/div/h3"
    static let kanrenImageXPath = "//div[@id='st-magazine']/div/div/dl/dt/img"
    
    // MARK: ダイアログ
    static let loadFailedTitle = "読み込みに失敗しました"
    static let loadFailedMessage = "通信環境をご確認の上再度お試しください"
    static let reload = "再取得"
    static let close = "とじる"
    
    // MARK: NavigationTitle
    static let homeTitle = "記事一覧"
    static let historyTitle = "閲覧履歴"
    
}
