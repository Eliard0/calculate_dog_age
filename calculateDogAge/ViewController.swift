//
//  ViewController.swift
//  calculateDogAge
//
//  Created by Eliardo Venancio on 25/09/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    private var dogSize: String = ""
    
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
        //        input.placeholder = "Digite a idade."
        input.backgroundColor = .white
        input.borderStyle = .roundedRect
        input.layer.cornerRadius = 50
        
        input.attributedPlaceholder = NSAttributedString(
            string: "Digite a idade.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        
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
    
    private lazy var sizeDog: UIButton = {
        let buttonSizeDog = UIButton(type: .system)
        buttonSizeDog.setTitle("Selecione um tamanho", for: .normal)
        buttonSizeDog.translatesAutoresizingMaskIntoConstraints = false
        buttonSizeDog.backgroundColor = .white
        buttonSizeDog.setTitleColor(.black, for: .normal)
        buttonSizeDog.layer.cornerRadius = 10
        buttonSizeDog.titleLabel?.font = .boldSystemFont(ofSize: 17)
        
        return buttonSizeDog
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
        
        setUpView()
        textInputDado.delegate = self
        
        buttonCalculate.addAction(UIAction(handler: { _ in
            self.validateInput()
        }), for: .touchUpInside)
        
        sizeDog.addAction(UIAction(handler: { _ in
            self.showMenuSizeDog()
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
        view.addSubview(sizeDog)
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
            sizeDog.topAnchor.constraint(equalTo: viewText.bottomAnchor, constant: 10),
            sizeDog.widthAnchor.constraint(equalToConstant: 250),
            sizeDog.heightAnchor.constraint(equalToConstant: 40),
            sizeDog.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textInputDado.topAnchor.constraint(equalTo: sizeDog.bottomAnchor, constant: 10),
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
    
    private func showMenuSizeDog(){
        let menu = UIMenu(title: " ", children: [
            UIAction(title: "Pequeno") { _ in self.setSize("Pequeno") },
            UIAction(title: "Médio") { _ in self.setSize("Médio") },
            UIAction(title: "Grande") { _ in self.setSize("Grande") }
        ])
        
        sizeDog.menu = menu
        sizeDog.showsMenuAsPrimaryAction = true
        sizeDog.setTitle("Selecionar Tamanho", for: .normal)
    }
    
    private func setSize(_ size: String) {
        sizeDog.setTitle(size, for: .normal)
        dogSize = size
        print("Tamanho selecionado: \(size)")
    }
    
    private func validateInput() {
        guard !dogSize.isEmpty else {
            showAlert(message: "Selecione um tamanho.")
            return
        }
        
        guard let text = textInputDado.text, !text.isEmpty else {
            showAlert(message: "O campo idade não pode estar vazio.")
            return
        }
        
        if let ageDog = Int(text) {
            if ageDog < 0 {
                showAlert(message: "Informe um numero positivo")
            }else {
                calculateAge(ageDog, dogSize)
            }
        } else {
            showAlert(message: "Por favor, digite apenas números.")
        }
    }
    
    private func calculateAge(_ ageDog: Int, _ size: String){
        var humanAge = 0
        
        switch ageDog {
        case 0:
            humanAge = 0
            navigatorScreen(humanAge)
        case 1:
            humanAge = 15
            navigatorScreen(humanAge)
        case 2:
            humanAge = 24
            navigatorScreen(humanAge)
        default:
            if size.lowercased() == "pequeno" || size.lowercased() == "médio" {
                humanAge = 24 + (ageDog - 2) * 5
                navigatorScreen(humanAge)
            } else {
                humanAge = 24 + (ageDog - 2) * 6
                print("caiu aqui")
                navigatorScreen(humanAge)
            }
        }
        
    }
    
    private func navigatorScreen(_ age: Int){
        let navigator = ShowAge()
        navigator.idade = age
        navigationController?.pushViewController(navigator, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

