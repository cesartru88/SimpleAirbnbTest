//
//  mainNavController.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 26/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class mainNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.navigationBar.barTintColor = UIColor(hexString6: "FB0C7C")
        self.navigationBar.tintColor = UIColor.white
        let font = UIFont(name: "Helvetica", size: 20.00)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,
                                                                        NSFontAttributeName: font!
        ]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
