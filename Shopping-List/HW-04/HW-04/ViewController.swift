//
//  ViewController.swift
//  HW-04
//
//  Created by selin eylül bilen on 3/11/21.
//

import UIKit

class ViewController: UIViewController {

    let db = database()
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemNum: UITextField!
    @IBAction func itemAdd(_ sender: UIButton) {
        let item = itemName.text!
        let num = itemNum.text!
        if (item == "" || num == ""){
            let alert = UIAlertController(title: "No Values", message: "Fields cannot be empty!!", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Got It!", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        //print(row)
        else{
            db.insertItem(item: item, num: num)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        db.Conn()
        // Do any additional setup after loading the view.
    }
    func assignbackground(){
        let background = UIImage(named: "a")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}

