//
//  ContactsTableViewController.swift
//  UIAdaptivePresentation
//
//  Created by Egor Ukolov on 17.07.2024.
//

import UIKit

class ContactsTableViewController: UITableViewController, NewContactViewControllerDelegate {
    
    var contacts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContacts()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
           let newContactVC = navController.topViewController as? NewContactViewController {
            newContactVC.delegate = self
            newContactVC.modalPresentationStyle = .fullScreen
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveContacts()
        }
    }
    
    func saveContact(_ contact: String) {
        contacts.append(contact)
        tableView.reloadData()
        saveContacts()
    }
    
    // MARK: - User Defaults
    
    private func loadContacts() {
        let defaults = UserDefaults.standard
        if let savedContacts = defaults.stringArray(forKey: "contacts") {
            contacts = savedContacts
        }
    }
    
    private func saveContacts() {
        let defaults = UserDefaults.standard
        defaults.set(contacts, forKey: "contacts")
    }
}



