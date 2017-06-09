//
//  ShowMemesTableViewController.swift
//  FireMemes
//
//  Created by Jose Melendez on 6/7/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit
import MapKit

class ShowMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let test = UIButton()

    @IBOutlet weak var tableView: UITableView!
    
    //Loading Animation
    @IBOutlet weak var loadingAnimationView: LoadingAnimation!

    //MARK: - Internal Properties
    var locationManager = CLLocationManager()
    var myLocation: CLLocation?
    
    func fetch() {
        
        guard let myLocation = myLocation else { return }
        MemeController.shared.fetch(myLocation, radiusInMeters: 27358) // We can change radius
    }

    
    func refreshing() {
        tableView.reloadData()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location Services
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    
        tableView.reloadData()
        
        // Notification Center
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(refreshing), name: Keys.notification, object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    //viewWillApear
    override func viewWillAppear(_ animated: Bool) {
        
        //Hided navigation bar
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeController.shared.memes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memeFeed", for: indexPath) as? MemeTableViewCell else { return UITableViewCell() }

        let meme = MemeController.shared.memes[indexPath.row]
        
        // Loading Animation
        loadingAnimationView.isHidden = true
        cell.updateViews(meme: meme)
        
        
        return cell
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

//MARK: - Location manager delegate functions

extension ShowMemesTableViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            myLocation = location
            fetch()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error with locationManager: \(error.localizedDescription)")
    }
    
}

