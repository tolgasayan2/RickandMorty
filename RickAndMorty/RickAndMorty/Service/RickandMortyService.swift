//
//  RickandMortyService.swift
//  RickAndMorty
//
//  Created by Tolga Sayan on 20.04.2022.
//

import Foundation
import Apollo



protocol IRickandMortyService {
  var isPaginating: Bool {get
    
  }
  func fetchAllDatas(pagination: Bool, response: @escaping ([SpesificCharacterQuery.Data.Character.Result?]) -> ())
}

class RickandMortyService: IRickandMortyService {
  
  var isPaginating = false
  func fetchAllDatas(pagination: Bool = false,response: @escaping ([SpesificCharacterQuery.Data.Character.Result?]) -> ()) {
    if pagination {
      isPaginating = true
    }
    Network.shared.apollo.fetch(query: SpesificCharacterQuery()) { result in
      switch result {
      case .success(let model):
        response((model.data?.characters?.results)!)
        print(model.data?.characters?.results?.count)
      case .failure(let error):
        print("Error: \(error)")
      }
    }
    }
  }
  
  

