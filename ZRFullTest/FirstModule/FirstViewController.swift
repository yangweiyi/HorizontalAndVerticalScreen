//
//  FirstViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit
import SnapKit

class FirstViewController: ZRBaseController {
    
    lazy var centerButton: UIButton = {
        let centerBtn = UIButton(type: .custom)
        centerBtn.setTitle("下一页面", for: .normal)
        centerBtn.setTitleColor(.systemPink, for: .normal)
        centerBtn.addTarget(self, action: #selector(nextViewControllerFunc), for: .touchUpInside)
        return centerBtn
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(centerButton)
        centerButton.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.height.equalTo(40)
            maker.width.equalTo(100)
        }
    }

    @objc func nextViewControllerFunc(){
        let firstVC = FirstNextVC()
        firstVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(firstVC, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

}
