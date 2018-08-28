//
//  AddItemVC.swift
//  CheckListApp
//
//  Created by user on 27.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

protocol AddItemVCDelegate: class {
    func addItemVCDidCancel(_ controller: ItemDetailV)
    func addItemVC(_ controller: ItemDetailV, didFinishAdding item: CheckListItem)
    func addItemVC(_ controller: ItemDetailV, didFinishEditing item: CheckListItem)
}

class ItemDetailV: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    var itemToEdit: CheckListItem?
    
    
    weak var delegate: AddItemVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        textField.delegate = self
        textField.becomeFirstResponder()
    }
    
    
    @IBAction func cancel() {
        delegate?.addItemVCDidCancel(self)
    }
    
    @IBAction func done() {
        if let itemToEdit = itemToEdit {
            itemToEdit.text = textField.text!
            delegate?.addItemVC(self, didFinishEditing: itemToEdit)
        } else {
            let item = CheckListItem()
            item.text = textField.text!
            item.checked = false
            delegate?.addItemVC(self, didFinishAdding: item)
        }

    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension ItemDetailV: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return false
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text else { return false }
        guard let stringRange = Range(range, in: oldText) else { return false }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
}
