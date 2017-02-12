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
    var inputPointx: Float?
    var inputPointy: Float?
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var pointNumSlider: UISlider!
    @IBOutlet weak var knnlabel: UILabel!

    func hello(test name: String) {
        print(name);
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        myview.generateRandomPoints(Int(pointNumSlider.value));
    }

    
    @IBAction func kChanged(_ sender: Any) {
        knnlabel.text = "kNN : k = " + String(Int(stepper.value))
        myview.drawTappedPoint(x: inputPointx ?? -1, y: inputPointy ?? -1, k: Int(stepper.value))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self.view)
        inputPointx = Float(location?.x ?? -1)
        inputPointy = Float(location?.y ?? -1)
        myview.drawTappedPoint(x: inputPointx!, y: inputPointy!, k: Int(stepper.value))
        
        //print("TOUCHED")
        //print(location?.x, location?.y)
    }
    @IBAction func pointNumChanged(_ sender: Any) {
        
    }

    @IBAction func buildKdTree(_ sender: Any) {
        myview.buildKdTree()
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

