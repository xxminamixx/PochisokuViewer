//
//  ArticleEntity.swift
//  PochisokuViewer
//
//  Created by 南　京兵 on 2018/02/16.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit

class ArticleEntity {
    
    let url: String
    let title: String
    let image: String
    
    init(_url: String, _title: String, _image: String) {
        url = _url
        title = _title
        image = _image
    }

}
