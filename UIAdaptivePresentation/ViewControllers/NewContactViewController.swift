//
//  ViewController.swift
//  UIAdaptivePresentation
//
//  Created by Egor Ukolov on 17.07.2024.
//

import UIKit

protocol NewContactViewControllerDelegate {
    func saveContact(_ contact: String)
}

class NewContactViewController: UIViewController {
    
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    var delegate: NewContactViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.isEnabled = false 
        
        firstNameTextField.addTarget(
            self,
            action: #selector(firstNameTextFieldDidChanged),
            for: .editingChanged)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        saveAndExit()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true
        )
    }

    
    @objc private func firstNameTextFieldDidChanged() {
        guard let firstName = firstNameTextField.text else { return }
        doneButton.isEnabled = !firstName.isEmpty
    }
    
    private func saveAndExit() {
        
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else { return }
        guard let lastName = lastNameTextField.text else { return }
        let userFullName = "\(firstName) \(lastName)"
        
        delegate.saveContact(userFullName)
        dismiss(animated: true)
        
    }

}

