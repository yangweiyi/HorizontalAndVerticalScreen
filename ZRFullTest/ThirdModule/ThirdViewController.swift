//
//  ThirdViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit

class ThirdViewController: ZRBaseController {

    lazy var centerButton: UIButton = {
        let centerBtn = UIButton(type: .custom)
        centerBtn.frame =  ZRRect(x: ScreenBounds.Width/2-50, y: ScreenBounds.Height/2-20, width: 100, hight: 40)
        centerBtn.setTitle("下一界面", for: .normal)
        centerBtn.setTitleColor(UIColor.red, for: .normal)
        centerBtn.addTarget(self, action: #selector(centerClickFunc), for: .touchUpInside)
        return centerBtn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(centerButton)
    }
    @objc func centerClickFunc(){
        self.navigationController?.pushViewController(ThirdNextViewController(), animated: true)
    }
    

    @objc func openClick(){
        print("网络变化!!!!!:\(ZRApp.interStarte)")
    }

}

extension ThirdViewController: UITableViewDelegate {

}

//extension ThirdViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // 选中后 展示1   不选中展示0
//        return 1
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//}

class HeadView: UIView {

}

