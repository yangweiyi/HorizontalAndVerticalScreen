//
//  TearsView.swift
//  ZRFullTest
//
//  Created by ZR on 2020/7/31.
//  Copyright © 2020 wely. All rights reserved.
//

import UIKit



class TearsView: UIView {
    var backButtonBlock:(()->Void)?
    var fullScreenBlock:(()->Void)?

    lazy var backButton: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "nav_back_bacolor"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return backBtn
    }()

    lazy var tearsImageView: UIImageView = {
        let tearsView = UIImageView()
        tearsView.image = UIImage(named: "stars_tears")
        tearsView.isUserInteractionEnabled = true
        tearsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fullClickFunc)))
        tearsView.backgroundColor = .systemPink
        return tearsView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tearsImageView)
        self.addSubview(backButton)
        subviewConstrains()
    }

    fileprivate func subviewConstrains(){
        tearsImageView.snp.makeConstraints { (maker) in
            maker.left.right.bottom.top.equalToSuperview()
        }

        backButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(ScreenBounds.StatusH ?? 0 + 10)
            maker.left.equalTo(15)
            maker.height.equalTo(30)
            maker.width.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 返回
    @objc func backBtnClick(){
        backButtonBlock?()
    }
    // 横屏
    @objc func fullClickFunc(){
        fullScreenBlock?()
    }


}

