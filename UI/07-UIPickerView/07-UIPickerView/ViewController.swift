//
//  ViewController.swift
//  07-UIPickerView
//
//  Created by Mr.Z on 2017/6/28.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //选择器
    lazy var pickerView:UIPickerView! = {[unowned self] in
        let picker = UIPickerView()
        // 代理
        picker.dataSource = self
        picker.delegate = self
        
        self.view.addSubview(picker)
        return picker
        }()
    // 按钮
    lazy var btnView:UIButton! = {[unowned self] in
        let btn = UIButton()
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action:#selector(getPickerViewValue),for: .touchUpInside)
        return btn
        }()
    // 所以数据集合
    var dataArr: [[String: Any?]]!
    
    // 选择的一级联动索引
    var firstIndex = 0
    // 选择的二级联动索引
    var secondIndex = 0
    // 选择的三级联动索引
    var thirdIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setData()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController {
    func setup() {
        pickerView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 400)
        btnView.frame = CGRect(x: 0, y: pickerView.bounds.height, width: self.view.bounds.width, height: 40)
        self.view.addSubview(pickerView)
        self.view.addSubview(btnView)
    }
    func setData() {
        var arr: [[String: Any]] = []
        // 一级
        for item in 0...10 {
            arr.append([
                "value": item,
                "label": String(item)
            ])
            // 二,三级
            var _arr: [[String:Any]] = [] // 二级
            for _item in 0...10 {
                var __arr: [[String:Any]] = [] // 三级
                
                for __item in 0...10 {
                    
                    __arr.append([
                        "value": __item,
                        "label": String(item) + "_" + String(_item) + "_" + String(__item)
                    ])
                    
                }
                // 三级赋值给二级
                _arr.append([
                    "value": _item,
                    "label": String(item) + "_" + String(_item),
                    "children": __arr
                ])
            }
            // 二级赋值给一级
            arr[item]["children"] = _arr
        }
        self.dataArr = arr
        //[
        //    [
        //        "label": "浙江省",
        //        "value": "0",
        //        "children": [
        //            [
        //                "label": "温州市",
        //                "value": "0",
        //                "children": [
        //                    [
        //                        "value": "0",
        //                        "label": "苍南县"
        //                    ]
        //                ]
        //            ],
        //            [
        //                "label": "杭州市",
        //                "value": "1",
        //                "children": [
        //                    [
        //                        "value": "0",
        //                        "label": "拱墅区"
        //                    ]
        //                ]
        //            ]
        //        ]
        //    ]
        //]
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // 设置选择框的列数为3列
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        // 每个选择框的行宽
        return 100.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        // 每个选择框的行高
        return 40.0
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        // 每个选择框每行的显示副文本内容
        return nil
    }
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        if self.dataArr.count == 0{
            return 0
        }
        if component == 0 {
            return self.dataArr.count
        } else if component == 1 {
            let province = self.dataArr[firstIndex]
            return (province["children"]! as AnyObject).count
        } else {
            let province = self.dataArr[firstIndex]
            if let city = (province["children"]! as! [AnyObject])[secondIndex] as? [String: Any] {
                return (city["children"]! as AnyObject).count
            } else {
                return 0
            }
        }
    }
    
    // 设置选择框各选项的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.dataArr[row]["label"] as? String
        }else if component == 1 {
            let province = self.dataArr[firstIndex]
            let city = (province["children"]! as! [AnyObject])[row] as! [String: Any]
            return city["label"] as? String
        }else {
            let province = self.dataArr[firstIndex]
            let city = (province["children"]! as! [AnyObject])[secondIndex] as! [String: Any]
            return ((city["children"]! as! [AnyObject])[row] as AnyObject)["label"] as? String
        }
    }
    
    //选中项改变事件（将在滑动停止后触发）
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        //根据列、行索引判断需要改变数据的区域
        switch (component) {
        case 0:
            firstIndex = row;
            secondIndex = 0;
            thirdIndex = 0;
            pickerView.reloadComponent(1);
            pickerView.reloadComponent(2);
            pickerView.selectRow(0, inComponent: 1, animated: false);
            pickerView.selectRow(0, inComponent: 2, animated: false);
        case 1:
            secondIndex = row;
            thirdIndex = 0;
            pickerView.reloadComponent(2);
            pickerView.selectRow(0, inComponent: 2, animated: false);
        case 2:
            thirdIndex = row;
        default:
            break;
        }
    }
}
extension ViewController {
    func getPickerViewValue(){
        //获取选中的一级联动
        let firstArr = self.dataArr[firstIndex]
        let firstLabel = firstArr["label"] as! String
        
        //获取选中的二级联动
        let secondArr = (firstArr["children"] as! [AnyObject])[secondIndex] as! [String: Any]
        let secondLabel = secondArr["label"] as! String
        
        //获取选中的三级联动
        var thirdLabel = ""
        if (secondArr["children"] as AnyObject).count > 0 {
            thirdLabel = ((secondArr["children"] as! [AnyObject])[thirdIndex] as! [String: Any])["label"]! as! String
        }
        print(thirdLabel)
        //拼接输出消息
        let message = "您选择了：\(firstLabel) - \(secondLabel) - \(thirdLabel)"
        print(message)
        // 消息显示
        let alertController = UIAlertController(title: "您选择了", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            print("ok")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


