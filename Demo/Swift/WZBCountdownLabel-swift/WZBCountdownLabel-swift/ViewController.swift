//
//  ViewController.swift
//  WZBCountdownLabel-swift
//
//  Created by wzb on 2023/6/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        /// 绑定代理，要在 play 方法之前
        WZBCountdownLabel.add(delegate: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /// 开始播放
        WZBCountdownLabel.play(with: 5, endTitle: "GO!") { label in
            print("block --- 开始播放： \(label)")
        } successCallback: { label in
            print("block --- 播放成功： \(label)")
        }
    }
}

extension ViewController: WZBCountdownLabelDelegate {
    func countdownBegin(_ label: WZBCountdownLabel) {
        print("delegate --- 开始播放： \(label)")
    }
    
    func countdownSuccess(_ label: WZBCountdownLabel) {
        print("block --- 播放成功： \(label)")
    }
}

