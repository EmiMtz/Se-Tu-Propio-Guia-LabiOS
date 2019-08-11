//
//  PlacesDetailViewController.swift
//  Sé tu propio guía
//
//  Created by Tania Rossainz on 8/9/19.
//  Copyright © 2019 Emiliano Martínez. All rights reserved.
//

import UIKit

class PlacesDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    // MARK: - Properties

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: PlaceDetailHeaderView!
    
    
    
    
    
    var place: Place = Place()
    
    // MARK:- View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        // Configure the header view
        headerView.nameLabel.text = place.name
        headerView.typeLabel.text = place.type
        headerView.headerImageView.image = UIImage(named: place.image)
        
        // Configure the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // Customization of the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.hidesBarsOnSwipe = false
        
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- UITableViewDataSource Protocol
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceDetailconTextCell.self), for: indexPath) as! PlaceDetailconTextCell
            cell.iconImageView.image = UIImage(named: "phone")
            cell.shortTextLabel.text = place.phone
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceDetailconTextCell.self), for: indexPath) as! PlaceDetailconTextCell
            cell.iconImageView.image = UIImage(named: "map")
            cell.shortTextLabel.text = place.location
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceDetailTextCell.self), for: indexPath) as! PlaceDetailTextCell
            cell.descriptionLabel.text = place.description
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceDetailSeparatorCell.self), for: indexPath) as! PlaceDetailSeparatorCell
            cell.titleLabel.text = "COMO LLEGAR"
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceDetailMapCell.self), for: indexPath) as! PlaceDetailMapCell
            cell.configure(location: place.location)
            
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceDetailSeparatorARCell.self), for: indexPath) as! PlaceDetailSeparatorARCell
            cell.titleLabelAR.text = "EXPLORA CON TU CÁMARA"
            
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlaceDetailARCell.self), for: indexPath) as! PlaceDetailARCell
//            cell.camaraImage.image = UIImage(named: "camaraAR")
//            cell.camaraAR = UIImage(named: "camaraAR")
            cell.camaraAR.image = UIImage(named: "cameraAR")
            
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    // MARK:- Status Bar Customization
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapaKitViewController
            destinationController.place = place
        }
        
        if segue.identifier == "showARKit" {
            let destinationARK = segue.destination as! ViewController
            destinationARK.place = place
        }
        
    }
    
}

