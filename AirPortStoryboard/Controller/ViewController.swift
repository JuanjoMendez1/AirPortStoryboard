//
//  ViewController.swift
//  AirPortStoryboard
//
//  Created by Juan Jose Mendez Rojas on 26/10/23.
//

import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderKm: UISlider!
    @IBOutlet weak var kmValue: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        var selectedValue = Int(sender.value)
        kmValue.text = String(selectedValue)
        UserDefaults.standard.set(selectedValue, forKey: "radius")
    }
}

