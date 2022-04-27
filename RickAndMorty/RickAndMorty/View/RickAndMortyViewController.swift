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
  func saveData(values: [Result])
}

final class RickAndMortyViewController: UIViewController {
  private let labelTitle: UILabel = UILabel()
  private let tableView: UITableView = UITableView()
  private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
  private let filterButton: UIButton = UIButton()
  var results: [Result] = []
  lazy var viewModel = RickAndMortyViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
    configureView()
      tableView.register(RickandMortyTableViewCell.self, forCellReuseIdentifier: RickandMortyTableViewCell.Identifier.custom.rawValue)
      DispatchQueue.global().async {
        self.viewModel.fetchItems()
      }
   
      viewModel.setDelegate(output: self)
    }
  
  private func drawDesign(){
    DispatchQueue.main.async { [self] in
      tableView.backgroundColor = .white
      view.backgroundColor = .white
      labelTitle.text = "Rick and Morty"
      labelTitle.font = .boldSystemFont(ofSize: 20)
      filterButton.setImage(UIImage(named: "filter"), for: .normal)
    }
  
   
    indicator.startAnimating()
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

}

extension RickAndMortyViewController: RickandMortyOutput {
  func changeLoading(isLoad: Bool) {
    DispatchQueue.main.async { [self] in
      isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
  }
  
  func saveData(values: [Result]) {
    results = values
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
    cell.saveModel(model: results[indexPath.row])
    cell.isUserInteractionEnabled = false
    return cell
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let position = scrollView.contentOffset.y
    if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
      guard !viewModel.rickAndMortyService.isPaginating else {
        return
      }
      viewModel.rickAndMortyService.fetchAllDatas(pagination: true) { [weak self] response in
        switch response {
        case .some(let moreData):
          self?.viewModel.rickAndMortyCharacters.append(contentsOf: moreData)
          self?.viewModel.rickAndMortyOutput?.saveData(values: self?.viewModel.rickAndMortyCharacters ?? [])
          
        case .none:
          break
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
