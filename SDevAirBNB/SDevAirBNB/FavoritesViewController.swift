//
//  FavoritesViewController.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 21/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource{

    
    var favoriteData : IDataFavorite!
    let placeHandler = PlacesManagement.sharedInstance
    var places : [FavoriteModel]!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - SetupUI
    
    func setupUI(){
    
        
        self.title = "Favorites"
        self.places = [FavoriteModel]()
        self.tableView.allowsMultipleSelectionDuringEditing = false
        self.tableView.tableFooterView = UIView(frame: .zero)
        

        
        favoriteData.retrieveAll { (objects, error) in
            if error != nil{
                self.showSingleAlertMessage(error: error, title: nil, message: nil, completion: { 
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                })
            }else if (objects?.count)! > 0{
            
                places = objects as! [FavoriteModel]
                self.tableView.reloadData()
            }
        }

    }

    //MARK: - Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return places.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier : String = "PlaceTableViewCell_"
        
        let cell: PlaceTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: identifier) as! PlaceTableViewCell
        let placeModel : FavoriteModel = places[indexPath.row]
        cell.configureCellWith(model: placeModel, airData: favoriteData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        detailVC.favorite = places[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let favoriteModel = places[indexPath.row]
            
            let favoritePredicate = NSPredicate(format: "favoriteId == %@", favoriteModel.favoriteId!)
            if let error = favoriteData.deleteObject(predicate: favoritePredicate){
                print(error)
            }
            places.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
            
        }
    }
}
