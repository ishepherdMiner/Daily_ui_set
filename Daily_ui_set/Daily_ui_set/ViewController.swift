//
//  ViewController.swift
//  Daily_ui_set
//
//  Created by Jason on 07/12/2016.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    open let sections = 1
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ComConfig.shared.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: ComConfig.shared.moduleName)
        if let _ = cell {
            cell = UITableViewCell(style: .default, reuseIdentifier: ComConfig.shared.moduleName)
        }
        cell?.textLabel?.text = ComConfig.shared.dataList[indexPath.row]["name"]
        return cell!
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // http://stackoverflow.com/questions/24030814/swift-language-nsclassfromstring/32265287#32265287
        let vc = ContainerViewController()
        vc.title = (ComConfig.shared.dataList[indexPath.row]["name"])
        let vClsString = ComConfig.shared.moduleName + "." + (ComConfig.shared.dataList[indexPath.row]["view"])! as String
        let v = (NSClassFromString(vClsString) as? UIView.Type)?.init()
        vc.sView = v
        vc.orderId = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
