//
//  ViewController.swift
//  SuryaSoftTest
//
//  Created by Satyam Sehgal on 21/11/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class ContactViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    let viewModel = ContactListViewModel()
    let contactListService = FetchContactService()
    var dataSource = [ContactListCellModel]()
    var fetchedResultsController: NSFetchedResultsController<Contact>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setupFetchResultsController()
    }

    private func setupTableview() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
    }

    private func setupFetchResultsController() {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        let sort = NSSortDescriptor(key: "firstName", ascending: true)
        request.sortDescriptors = [sort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataUtil.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        }
        catch {
        }
    }

    @IBAction func submitButtonAction(_ sender: UIButton) {

        if viewModel.validateEmail(data: emailTextField.text) {
            guard let url = K.Url.feedURL else {
                return
            }
            let parameters : [String: String] = [KeyConstants.emailId : emailTextField.text ?? ""]
            contactListService.fetchContacts(url, params: parameters) { (result) in
                switch (result) {
                case .failure(let error):
                    print(error)

                case .success(let json):
                    let contactList = json[KeyConstants.items].arrayValue
                    for contact in contactList {
                        if let cellModel = ContactListCellModel.init(json: contact) {
                            self.dataSource.append(cellModel)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    self.saveContactsLocally()
                }
            }
            emailTextField.text = StringConstants.emptyString
            emailTextField.resignFirstResponder()
        } else {
            AppUtility.showAlert(message: StringConstants.emailErrorMessage , onController: self)
        }
    }

    func saveContactsLocally() {
        CoreDataUtil.insert(self.dataSource)
    }

}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: StringConstants.contactListCellIdentifier)
        if let cell = tableCell as? ContactListTableCell {
            cell.contact = fetchedResultsController?.object(at: indexPath)
        }
        return tableCell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
