//
//  ViewController.swift
//  06-UITableView
//
//  Created by Mr.Z on 2017/6/26.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

import UIKit
// cellID
fileprivate let CellID = "Cell"

class ViewController: UIViewController {
    lazy var tv: UITableView! = { [unowned self] in
        let tab = UITableView()
        tab.delegate = self
        tab.dataSource = self
        
        // 设置底部多余的分割线(UIView())或者添加底部视图(如下)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        view.backgroundColor = UIColor.blue
        tab.tableFooterView = view
        
        // 设置头部
        // 设置底部多余的分割线(UIView())或者添加底部视图(如下)
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        header.backgroundColor = UIColor.green
        tab.tableHeaderView = header
        
        // 背景颜色
        tab.backgroundColor = UIColor.yellow
        
        // 消除底部划线
        // tab.separatorStyle = .none
        
        // 定义底部划线的约束
        tab.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        return tab
        }()
    var dataArr: [String]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "UITabView的用法"
        // 初始化
        self.setLocalData()
        setup()
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
        // navigationController?.navigationBar.isTranslucent = false
    }


}
extension ViewController {
    func setup(){
        tv.frame = self.view.bounds
        // 注册自定义的 cellID
        // tableView.register(Cell.self, forCellReuseIdentifier: CellID)
        // 注册默认的cell
        tv.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
        view.addSubview(tv)
    }
}
// MARK: - 数据
extension ViewController {
    func setLocalData() {
        for number in 1...5 {
            let text = String(format: "第 %d 个", arguments: [number])

            self.dataArr.append(text);
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        // 组数
        return 4
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 每组的数量
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 自定义
        // let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for:indexPath) as Cell
        // 默认
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for:indexPath) as UITableViewCell
        // cell标题
        cell.textLabel!.textColor = UIColor.black
        cell.textLabel!.text = self.dataArr[indexPath.row] + "坐标:" + String(indexPath.section) + String(indexPath.row)
        let sec = indexPath.section
        if sec == 1 {
            // 箭头
            cell.accessoryType = .disclosureIndicator
            // 选择是不会变化颜色
            cell.selectionStyle = .none
        } else if sec == 2 {
            print(sec,cell)
            cell.accessoryType = .detailDisclosureButton
        } else if sec == 3 {
            cell.accessoryType = .checkmark
        } else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 选择时颜色停留去除
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    // ui
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 行高
        return 60.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // 每组头部之间的间距
        return 10.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // 每组头部的间距
        return section == 0 ? 10.0 : 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 10))
        returnedView.backgroundColor = UIColor.red
        return returnedView
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 10))
            returnedView.backgroundColor = UIColor.red
            return returnedView
        }
        return nil
    }

}


