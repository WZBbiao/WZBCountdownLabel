//
//  WZBCountdownLabel.swift
//  WZBCountdownLabel-swift
//
//  Created by wzb on 2023/6/21.
//

import Foundation
import UIKit

typealias CountdownBeginBlock = (_ label: WZBCountdownLabel) -> Void
typealias CountdownSuccessBlock = (_ label: WZBCountdownLabel) -> Void

class WZBCountdownLabel: UIView {
    
    private static let shared = WZBCountdownLabel()
    
    /// 代理
    weak var delegate: WZBCountdownLabelDelegate?
    
    
    /// 开始播放
    /// - Parameters:
    ///   - number: 倒计时数字
    ///   - endTitle: 结束时的文本
    ///   - success: 成功回调
    static func play(with number: Int = 0, endTitle: String? = nil, success: CountdownSuccessBlock? = nil) {
        
    }
    
    /// 添加成功回调
    /// - Parameter successCallback: 成功回调
    static func add(successCallback: CountdownSuccessBlock) {
        
    }
    
    /// 添加开始播放时的回调
    /// - Parameter beginCallback: 开始播放回调
    static func add(beginCallback: CountdownBeginBlock) {
        
    }
    
    /// 添加开始播放回调和成功回调
    /// - Parameters:
    ///   - successCallback: 成功回调
    ///   - beginCallback: 开始播放回调
    static func add(successCallback: CountdownSuccessBlock, beginCallback: CountdownBeginBlock) {
        
    }
    
    /// 添加代理
    /// - Parameter delegate: 代理对象
    static func add(delegate: WZBCountdownLabelDelegate) {
        
    }
    
    
    /// 隐藏
    func hidden() {
        
    }
}

extension WZBCountdownLabel {
    enum WZBCountDownType {
        case number
        case string
    }
    

}

protocol WZBCountdownLabelDelegate: AnyObject {
    
    /// 倒计时开始时调用
    func countdownBegin(_ label: WZBCountdownLabel)
    
    /// 倒计时完成时调用
    func countdownSuccess(_ label: WZBCountdownLabel)
}

extension WZBCountdownLabelDelegate {
    
    /// 倒计时开始时调用
    func countdownBegin(_ label: WZBCountdownLabel) {}
    
    /// 倒计时完成时调用
    func countdownSuccess(_ label: WZBCountdownLabel) {}
}
