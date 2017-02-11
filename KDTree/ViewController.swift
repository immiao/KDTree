//
//  ViewController.swift
//  KDTree
//
//  Created by mac on 2/10/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    let myview = View(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 100))

    func hello(test name: String) {
        print(name);
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        myview.generateRandomPoints(Int(pointNumSlider.value));
        myview.setNeedsDisplay()
    }

    @IBOutlet weak var pointNumSlider: UISlider!
    @IBAction func pointNumChanged(_ sender: Any) {
        print(pointNumSlider.value);
    }
    
    @IBAction func asd(_ sender: Any) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(myview)
        print("Hello World")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

