//
//  RickAndMortyViewController.swift
//  RickAndMorty
//
//  Created by Tolga Sayan on 18.04.2022.
//

import UIKit
import SnapKit


protocol RickandMortyOutput {
  func changeLoading(isLoad: Bool)
  func saveData(values: [SpesificCharacterQuery.Data.Character.Result?])

}

final class RickAndMortyViewController: UIViewController {
  
  private let labelTitle: UILabel = UILabel()
  public var tableView: UITableView = UITableView()
  private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
  private let filterButton: UIButton = UIButton()
  var results: [SpesificCharacterQuery.Data.Character.Result?] = []
  var filtered: [SpesificCharacterQuery.Data.Character.Result?] = []
  lazy var viewModel = RickAndMortyViewModel()
  lazy var popUpView = PopupView()

  
    override func viewDidLoad() {
        super.viewDidLoad()
    configureView()
      tableView.register(RickandMortyTableViewCell.self, forCellReuseIdentifier: RickandMortyTableViewCell.Identifier.custom.rawValue)
        self.viewModel.fetchItems()
      viewModel.setDelegate(output: self)
    }
  
  private func drawDesign(){
    DispatchQueue.main.async { [self] in
      tableView.backgroundColor = .white
      view.backgroundColor = .white
      labelTitle.text = "Rick and Morty"
      labelTitle.font = .boldSystemFont(ofSize: 20)
      filterButton.setImage(UIImage(named: "filter"), for: .normal)
      filterButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
    }
    indicator.startAnimating()
  }
  
  @objc func buttonClicked() {
   showPopup()
  }
  
  private func configureView() {
    tableView.delegate = self
    tableView.dataSource = self
    labelTitle.textAlignment = .center
    tableView.separatorStyle = .none
    view.addSubview(labelTitle)
    view.addSubview(tableView)
    view.addSubview(indicator)
    view.addSubview(filterButton)
    makeTableView()
    makeLabel()
    makeIndicator()
    makeButton()
    drawDesign()
   }
  
  private func showPopup() {
    view.addSubview(popUpView)
  }
  
  private func filterRick( results: [SpesificCharacterQuery.Data.Character.Result?] ) -> [SpesificCharacterQuery.Data.Character.Result?] {
    return results.filter{ $0!.name!.contains("Rick") }
  }
}

extension RickAndMortyViewController: RickandMortyOutput {
  func changeLoading(isLoad: Bool) {
    DispatchQueue.main.async { [self] in
      isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
  }
  
  func saveData(values: [SpesificCharacterQuery.Data.Character.Result?]) {
    self.results = values
    tableView.reloadData()
  }
}
// MARK: TableView Delegate & DataSource && ScrollView Delegate
extension RickAndMortyViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return results.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: RickandMortyTableViewCell.Identifier.custom.rawValue, for: indexPath) as? RickandMortyTableViewCell else {
      return UITableViewCell()
    }
       cell.saveModel(model: self.results[indexPath.row])
       cell.isUserInteractionEnabled = false
     
   
    return cell
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let position = scrollView.contentOffset.y
    if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
      guard !viewModel.rickAndMortyService.isPaginating else {
        return
      }
      viewModel.rickAndMortyService.fetchAllDatas(pagination: true) { [weak self] result in
        DispatchQueue.main.async {
          self?.viewModel.rickAndMortyCharacters.append(contentsOf: result)
          self?.viewModel.rickAndMortyOutput?.saveData(values: self?.viewModel.rickAndMortyCharacters ?? [])
        }
        
      }
    }
  }
  
}

extension RickAndMortyViewController {
  private func makeTableView() {
    tableView.snp.makeConstraints { make in
      make.top.equalTo(labelTitle.snp.bottom).offset(10)
      make.bottom.equalToSuperview()
      make.left.equalTo(labelTitle).offset(-10)
      make.right.lessThanOrEqualTo(labelTitle)
    }

  }
  private func makeIndicator() {
    indicator.snp.makeConstraints { make in
      make.top.equalTo(labelTitle)
      make.left.equalTo(labelTitle).offset(20)
      make.height.equalTo(labelTitle)
      
    }
  }
  
  private func makeLabel() {
    labelTitle.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(50)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(-10)
      make.height.greaterThanOrEqualTo(20)
    }
  }
  
  private func makeButton() {
    filterButton.snp.makeConstraints { make in
      make.top.equalTo(labelTitle.snp.top)
      make.bottom.equalTo(labelTitle.snp.bottom)
      make.right.equalToSuperview().offset(-30)
      make.left.equalToSuperview().offset(view.bounds.midX + 140)
     
      make.width.equalTo(10)
      
    }
  }
}
