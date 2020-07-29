//
//  ThirdNextViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/7/23.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit

class NewValue: Codable {
    var name: String? = ""{
        didSet{
            print("name走了赋值方法:\(name)")
        }
    } // 名字
    var title:String? = ""  // 标题
    var age: Int? = 0 // 年龄
}

class ThirdNextViewController: ZRBaseController {
    var newModel = NewValue(){
        willSet{
            print("走了将要赋值方法 \(newModel.name)")
        }
        didSet{
            print("走了赋值方法 \(newModel.name)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newModel.name = "Hello World"
        self.view.backgroundColor = .systemPink
        // Do any additional setup after loading the view.
    }

}
