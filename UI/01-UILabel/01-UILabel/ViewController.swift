//
//  ViewController.swift
//  01-UILabel
//
//  Created by Mr.Z on 2017/5/13.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "label的用法"
        // 初始化
        self.setup()
    }

    override func loadView() {
        super.loadView()
        
        // 视图控制器背景颜色
        self.view.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // xy,计算从内容区域开始计算
        navigationController?.navigationBar.isTranslucent = false
    }
}
extension ViewController {
    public func setup() {
        // 实例化
        let label:UILabel = UILabel(frame: CGRect(x: 10.0, y: 100.0, width: self.view.frame.width - 20.0, height: 40.0))
        
        // 加到父视图
        self.view.addSubview(label)
        
        // 内容
        label.text = "学习label+学习label+学习label+学习label+学习label+学习label+学习label"
        
        
        // 字体属性设置
        label.textColor = UIColor.red
        label.textAlignment = .left
        label.font = UIFont(name: "Copperplate", size: 15.0)
        
        // 用于多行和多行文本->字符截断类型,设置文字过长时的显示格式，省略号
        label.lineBreakMode = .byTruncatingTail
        
        // 随宽度来自动适应字体大小，但要注意的是，这个属性不会让字体变大，只会缩小，所以开始的时候，可以设置字体fontSize大一点。
        label.adjustsFontSizeToFitWidth = true
        
        // 行数显示，默认为1行, 0表示多行显示
        label.numberOfLines = 0
        
        // 文本高亮
        label.isHighlighted = true
        label.highlightedTextColor = UIColor.blue
        
        // 阴影设置
        label.shadowColor = UIColor.brown
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        // layer层设置
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 1.0
        
        // 其他属性
        label.backgroundColor = UIColor.green
        label.isHidden = false
        
        
        
        
        
        // 富文本属性
        let label_rtf:UILabel = UILabel(frame: CGRect(x: 10.0, y: 300.0, width: self.view.frame.width - 20.0, height: 40.0))
        self.view.addSubview(label_rtf)
        
        label_rtf.backgroundColor = UIColor.yellow
        label_rtf.font = UIFont(name: "Thonburi", size: 12.0)
        
        // 定义富文本
        let attributeString = NSMutableAttributedString(string: "富文本的用法")
        // 从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 20.0)!, range: NSMakeRange(0, 5))
        // 设置字体颜色
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSMakeRange(0, 5))
        // 设置文字背景颜色
        attributeString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.green, range: NSMakeRange(0, 5))
        // 富文本内容显示
        label_rtf.attributedText = attributeString
        
        
        
        
        
        // 自适应高度
        // 计算字生符串的宽度，高度
        let string: String = "计算字生符串的宽度，高度,计算字生符串的宽度，高度,计算字生符串的宽度，高度,计算字生符串的宽度，高度。"
        let font: UIFont! = UIFont.systemFont(ofSize: 18)
        let attributes = [NSFontAttributeName:font!]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let autoSize = CGSize(width: self.view.frame.width, height: 999.9)
        let size: CGRect = string.boundingRect(with: autoSize, options: option, attributes: attributes, context: nil)
        print("size:\(size)")
        
        let label_resp = UILabel(frame: CGRect(x: 10.0, y: (label_rtf.frame.height + label_rtf.frame.minY + 10.0), width: (self.view.frame.width - 10.0 * 2), height: 20.0))
        self.view.addSubview(label_resp)
        label_resp.backgroundColor = UIColor.orange
        label_resp.font = UIFont.systemFont(ofSize: 12.0)
        label_resp.text = string
        label_resp.numberOfLines = 0
        label_resp.lineBreakMode = .byWordWrapping
        // 自适应高度
        var autoRect = label_resp.frame
        autoRect.size.height = size.height
        label_resp.frame = autoRect
        
        
        
        
    }

}

