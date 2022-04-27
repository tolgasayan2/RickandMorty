//
//  RickandMortyTableViewCell.swift
//  RickAndMorty
//
//  Created by Tolga Sayan on 20.04.2022.
//

import UIKit
import AlamofireImage
import SnapKit

class RickandMortyTableViewCell: UITableViewCell {
  
  enum Identifier: String {
    case custom = "cell"
  }
  private let viewBox: UIView = UIView()
  private let nameLbl: UILabel = UILabel()
  private let locationLbl: UILabel = UILabel()
  private let customImage: UIImageView = UIImageView()
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell() {
    addSubview(viewBox)
    addSubview(nameLbl)
    addSubview(locationLbl)
    addSubview(customImage)
    nameLbl.font = .systemFont(ofSize: 15)
    locationLbl.font = .systemFont(ofSize: 15)
    locationLbl.numberOfLines = 0
    viewBox.backgroundColor = .white
    viewBox.layer.shadowColor = UIColor.gray.cgColor
    viewBox.layer.shouldRasterize = true
    viewBox.layer.shadowOffset = .zero
    viewBox.layer.shadowOpacity = 1
    viewBox.layer.shadowRadius = 10
    viewBox.layer.cornerRadius = 20
    customImage.layer.cornerRadius = 20
    customImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    customImage.clipsToBounds = true
    viewBox.clipsToBounds = true
    viewBox.translatesAutoresizingMaskIntoConstraints = false
    customImage.translatesAutoresizingMaskIntoConstraints = false
    
    
    viewBox.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.right.equalToSuperview().offset(-30)
      make.left.equalToSuperview().offset(30)
      make.bottom.equalToSuperview().offset(-20)
      make.size.equalTo(250)
      
    }
  
    customImage.snp.makeConstraints { make in
      make.top.equalTo(viewBox.snp.top)
      make.right.equalTo(viewBox.snp.right)
      make.left.equalTo(viewBox.snp.left)
      make.bottom.equalTo(viewBox.snp.bottom).offset(-75)
    }

    nameLbl.snp.makeConstraints { make in
      make.top.equalTo(170)
      make.right.equalToSuperview().offset(-20)
      make.left.equalToSuperview().offset(40)
      make.bottom.equalToSuperview().offset(-20)
      
    }
    
    locationLbl.snp.makeConstraints { make in
      make.top.equalTo(nameLbl.snp.bottom).offset(-50)
      make.right.left.equalTo(nameLbl)
      make.bottom.equalToSuperview().offset(-20)
    }
  }
  
  func saveModel(model: Result) {
    nameLbl.text = "Name: \(model.name ?? "")"
    locationLbl.text = "Location: \(model.location?.name ?? "")"
    customImage.af.setImage(withURL: URL(string: model.image ?? "https://picsum.photos/200/300") ?? URL(string: "https://picsum.photos/200/300")!)
  }
}
