//
//  CheckListVC.swift
//  CheckListApp
//
//  Created by user on 27.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CheckListVC: UITableViewController, AddItemVCDelegate {


    func addItemVCDidCancel(_ controller: ItemDetailV) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemVC(_ controller: ItemDetailV, didFinishAdding item: CheckListItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func addItemVC(_ controller: ItemDetailV, didFinishEditing item: CheckListItem) {
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    var items: [CheckListItem]
    

    
    required init?(coder aDecoder: NSCoder) {
        
        items = [CheckListItem]()
        
        let row0Item = CheckListItem()
        row0Item.text = "run"
        row0Item.checked = true
        items.append(row0Item)
        
        let row1Item = CheckListItem()
        row1Item.text = "eat"
        row1Item.checked = true
        items.append(row1Item)
        
        let row2Item = CheckListItem()
        row2Item.text = "sleep"
        row2Item.checked = false
        items.append(row2Item)
        
        let row3Item = CheckListItem()
        row3Item.text = "learn"
        row3Item.checked = false
        items.append(row3Item)
        
        let row4Item = CheckListItem()
        row4Item.text = "walk"
        row4Item.checked = false
        items.append(row4Item)

        super.init(coder: aDecoder)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
            configurwCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        
        
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configurwCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
//        let indexPaths = [indexPath]
//        tableView.deleteRows(at: indexPaths, with: .automatic)
        tableView.reloadData()
    }
    
    
    
    func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        let label = cell.viewWithTag(100) as! UILabel
        label.text = item.text
    }
    
    func configurwCheckmark(for cell: UITableViewCell, with item: CheckListItem) {
        
        let label = cell.viewWithTag(101) as! UILabel
        
        if item.checked {
            label.text = "✔︎"
        } else  {
            label.text = ""
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        let newRowIndex = items.count
        let item = CheckListItem()
        item.text = "NewRow \(newRowIndex + 1)"
        item.checked = false
        
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    

}

