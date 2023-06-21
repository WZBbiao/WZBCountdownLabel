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

class WZBCountdownLabel: UILabel {
    
    private static let shared = WZBCountdownLabel()
    
    /// 是否正在执行动画
    private var isAnimationing = false
    private var beginCallback: CountdownSuccessBlock?
    private var successCallback: CountdownSuccessBlock?
    private var number = 3
    private var endTitle: String?
    /// 代理
    weak var delegate: WZBCountdownLabelDelegate?
    
    
    /// 开始播放
    /// - Parameters:
    ///   - number: 倒计时数字
    ///   - endTitle: 结束时的文本
    ///   - beginCallback: 开始回调
    ///   - successCallback: 成功回调
    static func play(with number: Int = 0,
                     endTitle: String? = nil,
                     beginCallback: CountdownSuccessBlock? = nil,
                     successCallback: CountdownSuccessBlock? = nil) {
        guard !shared.isAnimationing else {
            return
        }
        
        let label = shared
        label.isHidden = false
        label.number = 3
        
        if number > 0  {
            label.number = number
        }
        
        if let endTitle {
            label.endTitle = endTitle
        }
        
        if let beginCallback {
            add(beginCallback: beginCallback)
        }
        
        if let successCallback {
            add(successCallback: successCallback)
        }
        
        label.setupLabelBase()
        
        label.scaleAction()
    }
    
    /// 添加成功回调
    /// - Parameter successCallback: 成功回调
    static func add(successCallback: @escaping CountdownSuccessBlock) {
        shared.successCallback = successCallback
    }
    
    /// 添加开始播放时的回调
    /// - Parameter beginCallback: 开始播放回调
    static func add(beginCallback: @escaping CountdownBeginBlock) {
        shared.beginCallback = beginCallback
    }
    
    /// 添加开始播放回调和成功回调
    /// - Parameters:
    ///   - successCallback: 成功回调
    ///   - beginCallback: 开始播放回调
    static func add(successCallback: @escaping CountdownSuccessBlock,
                    beginCallback:  @escaping CountdownBeginBlock) {
        shared.successCallback = successCallback
        shared.beginCallback = beginCallback
    }
    
    /// 添加代理
    /// - Parameter delegate: 代理对象
    static func add(delegate: WZBCountdownLabelDelegate) {
        shared.delegate = delegate
    }
    
    
    /// 隐藏
    func hidden() {
        transform = .identity
        isHidden = true
    }
}

extension WZBCountdownLabel {
    private func setupLabelBase() {
        frame = UIScreen.main.bounds
        transform = CGAffineTransform(scaleX: 10, y: 10)
        alpha = 0
        text = "\(number)"
        textColor = .red
        font = .systemFont(ofSize: 20)
        textAlignment = .center
        
        rootView?.addSubview(self)
    }
    
    private func scaleAction() {
        // 如果不在动画才走开始的代理和 block
        if !isAnimationing {
            beginCallback?(self)
            delegate?.countdownBegin(self)
        }
        
        if number >= (endTitle == nil ? 1 : 0) {
            isAnimationing = true
            text = number == 0 ? endTitle : "\(number)"
            
            UIView.animate(withDuration: 1) {
                self.transform = .identity
                self.alpha = 1
            } completion: { isFinished in
                if isFinished {
                    self.number -= 1
                    self.alpha = 0
                    self.transform = CGAffineTransform(scaleX: 10, y: 10)
                    self.scaleAction()
                }
            }
        } else {
            delegate?.countdownSuccess(self)
            successCallback?(self)
            
            hidden()
        }
    }
    
    private var rootView: UIView? {
        getVisibleViewController(from: UIApplication.shared.keyWindow?.rootViewController)?.view
    }
    
    private func getVisibleViewController(from vc: UIViewController?) -> UIViewController? {
        if let vc = vc as? UINavigationController {
            return getVisibleViewController(from: vc)
        }
        
        if let vc = vc as? UITabBarController {
            return getVisibleViewController(from: vc)
        }
        
        if let vc = vc?.presentedViewController {
            return getVisibleViewController(from: vc)
        }
        
        return vc
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
