//
//  ThirdNextViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/7/23.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit
import SnapKit

class ThirdNextViewController: ZRBaseController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        print("每次都会走的方法")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
