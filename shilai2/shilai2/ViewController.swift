//
//  ViewController.swift
//  shilai2
//
//  Created by 杨冰 on 15/5/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("111")
        print("222")
        print("333")
        // Do any additional setup after loading the view.
        self.view.addSubview(saveView())
    }
    
    func saveView() -> UIView{
        var label = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        label.text = "1123"
        label.textColor = UIColor(red: 100, green: 100, blue: 100, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 19)
        print("保存界面")
        return label
    
    }


}

