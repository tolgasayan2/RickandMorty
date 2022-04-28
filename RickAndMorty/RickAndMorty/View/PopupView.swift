//
//  PopupView.swift
//  RickAndMorty
//
//  Created by Tolga Sayan on 28.04.2022.
//

import UIKit
import SnapKit

class PopupView: UIView {
  
  lazy var isFilled: Bool = false
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.text = "Filter"
    return label
  }()
  
  private let nameOneLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 24)
    label.text = "Rick"
    return label
  }()
  
  private let nameTwoLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 24)
    label.text = "Morty"
    return label
  }()
  
  private let container: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    container.backgroundColor = .white
    container.layer.cornerRadius = 10
    return container
  }()
  
  private let lineView: UIView = {
    let lineView = UIView()
    lineView.translatesAutoresizingMaskIntoConstraints = false
    lineView.backgroundColor = .lightGray
    return lineView
  }()
  
  private let circleLbl: UILabel = {
    let circleLbl = UILabel()
    circleLbl.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    circleLbl.layer.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor
    circleLbl.translatesAutoresizingMaskIntoConstraints = false
    circleLbl.layer.cornerRadius = 12
    return circleLbl
  }()
  
  private let circle2Lbl: UILabel = {
    let circleLbl = UILabel()
    circleLbl.layer.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor
    circleLbl.translatesAutoresizingMaskIntoConstraints = false
    circleLbl.layer.cornerRadius = 12
    return circleLbl
  }()
  
  private let circleFilledlbl: UILabel = {
    let circleFilledlbl = UILabel()
    circleFilledlbl.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    circleFilledlbl.translatesAutoresizingMaskIntoConstraints = false
    circleFilledlbl.layer.cornerRadius = 8
    return circleFilledlbl
  }()
  
  private let checkboxFillLbl: UILabel = {
    let boxFillView = UILabel()
    return boxFillView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let tap = UITapGestureRecognizer(target: self, action: #selector(PopupView.tapFunction))
            circleLbl.isUserInteractionEnabled = true
            circleLbl.addGestureRecognizer(tap)
    self.backgroundColor = .placeholderText
    self.frame = UIScreen.main.bounds
    self.addSubview(container)
    container.addSubview(titleLabel)
    container.addSubview(nameOneLabel)
    container.addSubview(nameTwoLabel)
    container.addSubview(lineView)
    container.addSubview(circleLbl)
    container.addSubview(circle2Lbl)
    
 
    makeLineView()
    makeContainer()
    makeNameOnelabel()
    makeTitlelabel()
    makeNameTwolabel()
    makeCircleLbl()
    makeCircle2Lbl()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @IBAction func tapFunction(sender: UITapGestureRecognizer) {
    isFilled = true
    if isFilled {
      DispatchQueue.main.async { [self] in
        container.addSubview(circleFilledlbl)
        makeCircleFilled()
      }
      
    }
 
     }
  
  //MARK: Constraints with SnapKit
  private func makeTitlelabel() {
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(container.snp.top).offset(16)
      make.left.equalTo(container.snp.left).offset(16)
      make.width.equalTo(56)
      make.height.equalTo(28)
    }
  }
  
  private func makeNameOnelabel() {
    nameOneLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(24)
      make.left.equalTo(container.snp.left).offset(16)
      make.width.equalTo(46)
      make.height.equalTo(28)
    }
  }
  
  private func makeNameTwolabel() {
    nameTwoLabel.snp.makeConstraints { make in
      make.top.equalTo(nameOneLabel.snp.bottom).offset(16)
      make.left.equalTo(container.snp.left).offset(16)
      make.bottom.equalTo(container.snp.bottom).offset(-24)
      make.width.equalTo(63)
      make.height.equalTo(28)
    }
  }
  
  private func makeContainer() {
    container.snp.makeConstraints { make in
      make.left.equalTo(self.snp.left).offset(50)
      make.right.equalTo(self.snp.right).offset(-50)
      make.centerY.equalTo(self)
      make.width.equalTo(327)
      make.height.equalTo(164)
    }
  }
  
  private func makeLineView() {
    lineView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
      make.right.equalTo(container.snp.right)
      make.left.equalTo(container.snp.left)
      make.width.equalTo(container.snp.width)
      make.height.equalTo(1)
    }
  }
  
  private func makeCircleLbl() {
    circleLbl.snp.makeConstraints { make in
      make.top.equalTo(nameOneLabel.snp.top).offset(2)
      make.right.equalTo(container.snp.right).offset(-16)
      make.width.equalTo(24)
      make.height.equalTo(24)
      
    }
  }
  
  private func makeCircle2Lbl() {
    circle2Lbl.snp.makeConstraints { make in
      make.top.equalTo(nameTwoLabel.snp.top).offset(2)
      make.right.equalTo(container.snp.right).offset(-16)
      make.width.equalTo(24)
      make.height.equalTo(24)
      
    }
  }
  
  private func makeCircleFilled() {
    circleFilledlbl.snp.makeConstraints { make in
      make.top.equalTo(nameOneLabel.snp.top).offset(6)
      make.right.equalTo(container.snp.right).offset(-20)
      make.width.equalTo(16)
      make.height.equalTo(16)
    }
    
  }
}
