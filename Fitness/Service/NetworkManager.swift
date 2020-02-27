//
//  NetworkManager.swift
//  Fitness
//
//  Created by Вячеслав on 26.02.2020.
//  Copyright © 2020 Вячеслав. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager{
    
    func fetchSchedule(completion: @escaping (ResponseSchedule?) -> Void){
        let req = AF.request(API_URL().fetchSchedule)
        let decoder = JSONDecoder()
        let cachedResponse = URLCache.shared.cachedResponse(for: req.request!)
        
        guard cachedResponse == nil else {
            guard let data = cachedResponse?.data else { return }
            do {
                let objects = try decoder.decode([Schedule].self, from: data)
                completion(ResponseSchedule(cells: objects))
            }catch let error {
                print(error)
                completion(nil)
            }
            return
        }
        
        req.responseData { (responseData) in
            if let error = responseData.error{
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = responseData.data else { return }
            let cachedURLResponse = CachedURLResponse(response: responseData.response!, data: responseData.data! as Data , userInfo: nil, storagePolicy: .allowed)
            URLCache.shared.storeCachedResponse(cachedURLResponse, for: responseData.request!)
            do {
                let objects = try decoder.decode([Schedule].self, from: data)
                completion(ResponseSchedule(cells: objects))
            }catch let error {
                print(error)
                completion(nil)
            }
        }
    }
}


struct API_URL{
    let fetchSchedule = "https://sample.fitnesskit-admin.ru/schedule/get_group_lessons_v2/1/"
}


