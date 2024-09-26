//
//  ShowAge.swift
//  calculateDogAge
//
//  Created by Eliardo Venancio on 25/09/24.
//

import Foundation
import UIKit

class ShowAge: UIViewController {
    var idade: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange

        setUpViewShowAge()
    }
    
    private lazy var backgroundImage: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = UIImage(named: "fundo_confete")
        background.contentMode = .scaleAspectFill
        
        return background
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "A idade dele(a) er:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var ageDogLabel: UILabel = {
        let label = UILabel()
        label.text = idade != nil ? "\(idade!) Anos" : "Idade não disponível"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setUpViewShowAge(){
        setHierarchyShowAge()
        setConstrantsShowAge()
    }
    
    private func setHierarchyShowAge(){
        view.addSubview(backgroundImage)
        view.addSubview(labelTitle)
        view.addSubview(ageDogLabel)
    }
    
    private func setConstrantsShowAge(){
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelTitle.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            ageDogLabel.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 5),
            ageDogLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
