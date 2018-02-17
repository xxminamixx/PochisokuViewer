//
//  NavigationControllerViewController.swift
//  PochisokuViewer
//
//  Created by kyohei.minami on 2018/02/18.
//  Copyright © 2018年 kyohei.minami. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = ConstColor.red
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
