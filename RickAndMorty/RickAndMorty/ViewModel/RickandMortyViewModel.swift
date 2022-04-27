//
//  RickandMortyViewModel.swift
//  RickAndMorty
//
//  Created by Tolga Sayan on 20.04.2022.
//

import Foundation
import Apollo

protocol IRickandMortyViewModel {
  var rickAndMortyCharacters : [SpesificCharacterQuery.Data.Character.Result?] {get set}
  var rickAndMortyService: IRickandMortyService {get}
  var rickAndMortyOutput : RickandMortyOutput? {get}
  
  func fetchItems()
  func changeLoading()
  func setDelegate(output: RickandMortyOutput)
}

final class RickAndMortyViewModel: IRickandMortyViewModel {
  func setDelegate(output: RickandMortyOutput) {
    rickAndMortyOutput = output
  }
  
  var rickAndMortyOutput: RickandMortyOutput?
  
  
  var rickAndMortyCharacters: [SpesificCharacterQuery.Data.Character.Result?] = []
  var rickAndMortyService: IRickandMortyService
  private var isLoading = false
  init() {
    rickAndMortyService = RickandMortyService()
  }
  func fetchItems() {
    
    changeLoading()
    rickAndMortyService.fetchAllDatas(pagination: true) { [weak self] response in
      DispatchQueue.main.async {
        self?.changeLoading()
        self?.rickAndMortyCharacters = response
        self?.rickAndMortyOutput?.saveData(values: self?.rickAndMortyCharacters ?? [])
      }
     
    }
  }
  
  func changeLoading() {
    isLoading = !isLoading
    rickAndMortyOutput?.changeLoading(isLoad: isLoading)
  }

  
  
  
  
  
}
