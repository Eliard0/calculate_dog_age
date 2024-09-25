//
//  ViewController.swift
//  calculateDogAge
//
//  Created by Eliardo Venancio on 25/09/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var iconDog: UIImageView = {
        let imageIconDog = UIImageView()
        imageIconDog.translatesAutoresizingMaskIntoConstraints = false
        imageIconDog.image = UIImage(named: "IconDog")
        imageIconDog.contentMode = .scaleAspectFit
        
        return imageIconDog
    }()
    
    private lazy var viewText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ola sabemos que os cachorros tem uma idade diferente da nossa entao vamos calcular a idade do nosso bichinho."
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var textInputDado: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Digite a idade."
        input.backgroundColor = .white
        input.borderStyle = .roundedRect
        input.layer.cornerRadius = 50
        
        return input
    }()
    
    private lazy var buttonCalculate: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calcular", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        
        setUpView()
        textInputDado.delegate = self

        buttonCalculate.addAction(UIAction(handler: { _ in
                self.validateInput()
            }), for: .touchUpInside)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.tintColor = .white

        
    }
    
    private func setUpView(){
        setHierarchy()
        setConstrants()
    }
    
    private func setHierarchy(){
        view.addSubview(iconDog)
        view.addSubview(viewText)
        view.addSubview(textInputDado)
        view.addSubview(buttonCalculate)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    private func setConstrants(){
        NSLayoutConstraint.activate([
            iconDog.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            iconDog.widthAnchor.constraint(equalToConstant: 320),
            iconDog.heightAnchor.constraint(equalToConstant: 200),
            iconDog.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    
        
        NSLayoutConstraint.activate([
            viewText.topAnchor.constraint(equalTo: iconDog.bottomAnchor, constant: 20),
            viewText.widthAnchor.constraint(equalTo: iconDog.widthAnchor),
            viewText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textInputDado.topAnchor.constraint(equalTo: viewText.bottomAnchor, constant: 10),
            textInputDado.widthAnchor.constraint(equalTo: iconDog.widthAnchor),
            textInputDado.heightAnchor.constraint(equalToConstant: 50),
            textInputDado.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonCalculate.topAnchor.constraint(equalTo: textInputDado.bottomAnchor, constant: 20),
            buttonCalculate.widthAnchor.constraint(equalToConstant: 150),
            buttonCalculate.heightAnchor.constraint(equalToConstant: 40),
            buttonCalculate.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func validateInput() {
           guard let text = textInputDado.text, !text.isEmpty else {
               showAlert(message: "O campo não pode estar vazio.")
               return
           }
           
           if let idadeDog = Int(text) {
               print(text)
               let navigator = ShowAge()
               navigator.idade = idadeDog * 2
               navigationController?.pushViewController(navigator, animated: true)
               
           } else {
               showAlert(message: "Por favor, digite apenas números.")
           }
       }
       
       private func showAlert(message: String) {
           let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
}

