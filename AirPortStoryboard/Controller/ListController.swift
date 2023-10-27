//
//  ListController.swift
//  AirPortStoryboard
//
//  Created by Juan Jose Mendez Rojas on 27/10/23.
//

import UIKit
import CoreLocation

class celda: UITableViewCell{
    
    @IBOutlet weak var txtLon: UILabel!
    @IBOutlet weak var txtLat: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
}

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var tabla: UITableView!
    var locationManager = CLLocationManager()
    var radius = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        if let radioGuardado = UserDefaults.standard.string(forKey: "radius") {
            print("Radio guardado: \(radioGuardado)")
            radius = Int(radioGuardado) ?? 0
        } else {
            print("No se encontró ningún dato guardado.")
        }
        AirportSearchViewModel.shared.getAirport(lat: locationManager.location?.coordinate.latitude ?? 0, lon: locationManager.location?.coordinate.longitude ?? 0, radius: radius) { done in
            print(done)
            self.tabla.reloadData()
        } air: { air in
            
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AirportSearchViewModel.shared.airports?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! celda
        let info = AirportSearchViewModel.shared.airports?[indexPath.row]
        cell.txtTitle.text = info?.name ?? ""
        cell.txtLon.text = String(info?.longitude ?? 0.0)
        cell.txtLat.text = String(info?.latitude ?? 0.0)
        return cell
    }
    
}
