//
//  RickandMortyService.swift
//  RickAndMorty
//
//  Created by Tolga Sayan on 20.04.2022.
//

import Foundation
import Alamofire

enum RickandMortyServiceEndPoint: String {
  case BASE_URL = "https://rickandmortyapi.com/api"
  case PATH = "/character"
  
  static func characterPath() -> String {
    return "\(BASE_URL.rawValue)\(PATH.rawValue)"
  }
}

protocol IRickandMortyService {
  var isPaginating: Bool {get
    
  }
  func fetchAllDatas(pagination: Bool, response: @escaping ([Result]?) -> ())
}

class RickandMortyService: IRickandMortyService {
  var isPaginating = false
  func fetchAllDatas(pagination: Bool = false,response: @escaping ([Result]?) -> ()) {
    
    if pagination {
      isPaginating = true
    }
    AF.request(RickandMortyServiceEndPoint.characterPath()).responseDecodable(of: RickandMorty.self) { model in
      guard let data = model.value
      else {
       response(nil)
        return
      }
      if pagination {
        self.isPaginating = false
      }
      response(data.results)
      print(data.results)
    }
      
    }
  }
  
  

