//
//  ViewController.swift
//  Quick
//
//  Created by Meniny on 2018-05-20.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import Pow

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = #colorLiteral(red: 0.82, green:0.84, blue:0.86, alpha:1.00)
    }

    var index = 0
    
    func show() {
        let t = "Title"
        let m = "Thank you! You are welcome!"
        let i = #imageLiteral(resourceName: "avatar")
        let btns = ["Done", "Yes", "Cancel"]
        let ic = #imageLiteral(resourceName: "ic_info_outline")
        
        switch index {
        case 0:
            Pow.toast(title: t, message: m, icon: i)
        case 1:
            Pow.notification(title: t, message: m, icon: i)
        case 2:
            Pow.note(message: m, icon: i)
        case 3:
            Pow.alert(title: t, message: m, icon: i, buttons: btns)
        case 4:
            Pow.popup(title: t, message: m, icon: i, button: btns.first!)
        case 5:
            Pow.float(title: t, message: m, icon: i)
        case 6:
            Pow.form(title: "Signup", message: "Please signup.", icon: #imageLiteral(resourceName: "avatar"), fields: [
                Pow.Form.init("Username", image: ic),
                Pow.Form.init("Password", image: ic, password: true)
                ], button: "Signup", action: { inputs in return true })
        case 7:
            Pow.loading(message: m, duration: 5)
        case 8:
            let v = UIView.init()
            Pow.custom(view: v, position: .bottom, width: .ratio(value: 0.9), height: .constant(value: 200), background: #colorLiteral(red: 0.10, green:0.62, blue:0.90, alpha:1.00))
        default:
            index = 0
            show()
            break
        }
        index += 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

