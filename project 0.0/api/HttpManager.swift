//
//  HttpManager.swift
//  project 0.0
//
//  Created by BA-link on 16/12/2021.
//  Copyright © 2021 BA-link. All rights reserved.
//

import Foundation

class HttpManager{
    
    //============================================
    static func fetchProductimage(_ urlString: String){
        
        if let url = URL(string: urlString){
            
            var request = URLRequest(url: url)
            
//            if let token = CoreDataManager.getToken(){
//                request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    //print("Response products string:\n \(dataString)")
                }
                
                //decode(data: data)
            }
            
            task.resume()
        }
    }
    //===========================================

}
