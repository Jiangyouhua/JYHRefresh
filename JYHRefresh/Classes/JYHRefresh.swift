//
//  JYHRefresh.swift
//  JYHComponents
//
//  Created by 姜友华 on 2021/9/16.
//

import UIKit

public struct JYHRefresh {
    // 位置：上中下；传入正数向上偏移，传入负数向下偏移。
    public enum Position {
        case top(CGFloat = 0)
        case middle(CGFloat = 0)
        case bottom(CGFloat = 0)
    }
    
    // 配置项：位置、文字颜色、背景颜色、字体大小、圆角、显示时长等。
    public enum Setting {
        case backView(UIView)
        case foreViews([UIView])
        case messageLabel(UILabel)
        case messagePosition(Position)
        case speed(Int)
    }
    
    var backView: UIView?
    var foreViews: [UIView]?
    var messageLabel: UILabel?
    var messagePosition: Position?
    var speed: Int?
    var observation: NSKeyValueObservation?
        
    static var setting = JYHRefresh()
    
    static func change(obj: inout JYHRefresh, settings: [Setting]){
        for setting in settings {
            switch setting {
            case let .backView(view):
                obj.backView = view
            case let .foreViews(views):
                obj.foreViews = views
            case let .messageLabel(label):
                obj.messageLabel = label
            case let .messagePosition(position):
                obj.messagePosition = position
            case let .speed(speed):
                obj.speed = speed
            }
        }
    }
    
    static func config(_ settings: Setting...){
        JYHRefresh.change(obj: &JYHRefresh.setting, settings: settings)
    }
}

public class JYHRefreshControl: UIRefreshControl {
    var refresh: JYHRefresh
    public init(_ settings: JYHRefresh.Setting...) {
         refresh = JYHRefresh(backView: JYHRefresh.setting.backView, foreViews: JYHRefresh.setting.foreViews, messageLabel: JYHRefresh.setting.messageLabel, messagePosition: JYHRefresh.setting.messagePosition, speed: JYHRefresh.setting.speed)
        JYHRefresh.change(obj: &refresh, settings: settings)
        
        super.init()
        guard let scrollView = self.superview as? UIScrollView else {
            print("It is not UIScrollView")
            return
        }
        print("It is UIScrollView")
        
        refresh.observation = scrollView.observe(\.contentOffset, options: [.new, .old]) { view, change in
            print("###",change.oldValue?.y ?? 0, change.newValue?.y ?? 0)
            let old = change.oldValue?.y ?? 0
            let new = change.newValue?.y ?? 0
            if old == 0.0 && new > 0.0 {
                self.dropToStart()
                return
            }
            if old > 0.0 && new == 0.0 {
                self.dropToEnd()
                return
            }
            self.dropInProgress(old: old, new: new)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dropToStart(){
        print(#function)
    }
    
    func dropInProgress(old: CGFloat, new: CGFloat){
        print(#function)
    }
    
    func dropToEnd(){
        print(#function)
    }
}
