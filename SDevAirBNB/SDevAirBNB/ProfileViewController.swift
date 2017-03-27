//
//  ProfileViewController.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 21/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    var favoriteData : IDataFavorite!

    
    //MARK: - VC Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProfilePicture()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Profile"
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Actions
    @IBAction func showFavorites(_ sender: Any) {
        
        if checkFavorites() == true{

            self.performSegue(withIdentifier: "segueFavorites", sender: nil)
            
        }else{
        
            self.showSingleAlertMessage(error: nil, title: "Message", message: "You don't have any favorites saved yet.", completion: nil)
            
        }
    
    }
    
    //MARK: - Methods
    
    func getProfilePicture(){
        
        let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name,email, picture.type(large)"])
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                print("Error: \(error)")
            }
            else
            {
                if let info:[String:AnyObject] = result as? [String : AnyObject],
                    let pic:[String:AnyObject] = info["picture"] as? [String : AnyObject],
                    let data:[String:AnyObject] = pic["data"] as? [String : AnyObject],
                    let pictureURL = data["url"] as? String{
                
                    
                    self.imgViewProfile.downloadedFrom(link: pictureURL, Callback: { (ready) in})
                    
                    if let name = info["name"] as? String{
                        self.lblName.text = name
                    }
                }
            }
        })
    }
    
    func checkFavorites() -> Bool{
    
        var hasFavorites = false
        favoriteData.retrieveAll { (objects, error) in
            if error != nil{
                self.showSingleAlertMessage(error: error, title: nil, message: nil, completion: nil)
            }else if (objects?.count)! > 0{

                hasFavorites = true
            }else if (objects?.count)! == 0{
                hasFavorites = false
            }
        }

        return hasFavorites
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "segueFavorites"  {
            
            if let favorites = segue.destination as? FavoritesViewController {
        
                favorites.favoriteData = self.favoriteData
                
            }
        }
    }


}
