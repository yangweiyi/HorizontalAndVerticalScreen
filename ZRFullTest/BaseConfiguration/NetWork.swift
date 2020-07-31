//
//  NetWork.swift
//  ZRMedical
//
//  Created by ZR on 2020/4/27.
//  Copyright © 2020 wely. All rights reserved.
//

import Foundation
import Alamofire

enum NetWorkReachabState {
    case notReachab // 无网络
    case unknow // 网络未知
    case ethernetOrWiFi // wifi
    case cellular // 流量
}

class NetWorkManagerState {
    static let shared = NetWorkManagerState()
    let netManger =  NetworkReachabilityManager()
    func statNetWorkReachablity(_ successState:@escaping ((NetWorkReachabState)->Void)){
        netManger?.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: { (state) in
            switch state{
            case .notReachable: successState(.notReachab)
            case .unknown: successState(.unknow)
            case .reachable(.ethernetOrWiFi): successState(.ethernetOrWiFi)
            case .reachable(.cellular): successState(.cellular)
            }
        })
    }
}




