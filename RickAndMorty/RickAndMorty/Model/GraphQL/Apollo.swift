//
//  Apollo.swift
//  RickAndMorty
//
//  Created by Tolga Sayan on 27.04.2022.
//

import Foundation
import Apollo

enum ApolloServiceEndPoint: String {
  case BASE_URL = "https://rickandmortyapi.com"
  case PATH = "/graphql"
  
  static func characterPath() -> String {
    return "\(BASE_URL.rawValue)\(PATH.rawValue)"
  }
}

class Network {
  static let shared = Network()
  lazy var apollo = ApolloClient(url: URL(string: ApolloServiceEndPoint.characterPath())!)
  
  private init() {}
}
