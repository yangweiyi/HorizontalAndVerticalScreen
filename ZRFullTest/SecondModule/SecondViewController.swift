//
//  SecondViewController.swift
//  ZRFullTest
//
//  Created by ZR on 2020/6/3.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit
import ReplayKit

class SecondViewController: ZRBaseController {

    lazy var secondButton: UIButton = {
        let secondBtn = UIButton(type: .custom)
        secondBtn.setTitle("Second", for: .normal)
        secondBtn.setTitleColor(.systemPink, for: .normal)
        secondBtn.addTarget(self, action: #selector(nextViewControllerFunc), for: .touchUpInside)
        return secondBtn
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(secondButton)
        secondButton.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.height.equalTo(40)
            maker.width.equalTo(100)
        }
    }
    
    @objc func nextViewControllerFunc(){
        self.navigationController?.pushViewController(SecondNextVC(), animated: true)
    }

}


