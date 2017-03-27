//
//  DepencyContainers.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 22/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import Foundation
import Dip
import Dip_UI



// MARK: Dependency Container for Providers
func configureContainer(container rootContainer: DependencyContainer) {
    
    // Register some factory, Coredata Stack
    rootContainer.register(.singleton) { CoreDataStack() }
    
    rootContainer.register(.singleton){ DataManager(moc: (try! rootContainer
        .resolve() as CoreDataStack)
        .getContext()) as IDataManager}
    
    
    //Proxy Service
    rootContainer.register(.singleton) { ProxyService() as IProxyService}
    
    rootContainer.register(.singleton) { AirbnbService(proxy: try rootContainer
        .resolve() as IProxyService) as IAirbnbService }
    
    rootContainer.register(.singleton){ AirbnbListData(dataManager : try rootContainer.resolve() as IDataManager) as IAirbnbListData}
    
    rootContainer.register(.singleton){ DataFavorite(dataManager : try rootContainer.resolve() as IDataManager) as IDataFavorite}
    
    
    
    controllersModule.collaborate(with: rootContainer)
    
    DependencyContainer.uiContainers = [controllersModule]
    
}


//MARK: Controllers Injector
let controllersModule = DependencyContainer() { container in
    
    //MapController
    container.register() { HomeViewController() }
        .resolvingProperties({ (theContainer, vc) in
            
            vc.airbnbService = try! theContainer.resolve() as IAirbnbService
            vc.airData = try! theContainer.resolve() as IAirbnbListData
            
        })
    
    //DatailController
    container.register() { DetailViewController() }
        .resolvingProperties({ (theContainer, vc) in
            
            vc.airbnbService = try! theContainer.resolve() as IAirbnbService
            vc.airData = try! theContainer.resolve() as IAirbnbListData
            vc.favData = try! theContainer.resolve() as IDataFavorite
            
        })
    
    //MapViewController
    container.register() { MapViewController() }
        .resolvingProperties({ (theContainer, vc) in
            
            vc.airData = try! theContainer.resolve() as IAirbnbListData
            
        })
    
    //MapViewController
    container.register() { ProfileViewController() }
        .resolvingProperties({ (theContainer, vc) in
            
            vc.favoriteData = try! theContainer.resolve() as IDataFavorite
            
        })
}

extension HomeViewController: StoryboardInstantiatable {}
extension DetailViewController: StoryboardInstantiatable {}
extension MapViewController: StoryboardInstantiatable {}
extension ProfileViewController: StoryboardInstantiatable {}



