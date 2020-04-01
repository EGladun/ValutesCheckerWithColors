//
//  ListViewController.swift
//  ValuteChanges
//
//  Created by Egor on 01.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var valutesArray: [Valute] = []
    let parser = Parser()
    let nib = UINib(nibName: "ValuteCell", bundle: nil)
    let identifier = "MyCell"
    var searching = false
    var searchValute: [Valute] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        
        
        self.configureSearchBar()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(self.nib, forCellReuseIdentifier: self.identifier)
        self.tableView.reloadData()
        
        self.parser.doRequest {
            self.valutesArray = self.parser.valutesArray
            self.searchBar.isHidden = false
            self.tableView.reloadData()
        }
        
    }
    
    
}

// MARK: - TableViewExtensions
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searching {
            return self.searchValute.count
        }
        return self.valutesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.valutesArray.count != 0 {
            
            if self.searching {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ValuteCell
                cell.codeLabel.text = self.searchValute[indexPath.row].charCode!
                cell.valueLabel.text = String(self.searchValute[indexPath.row].value!)
                cell.previousLabel.text = String(self.searchValute[indexPath.row].previous!)
                let change = self.searchValute[indexPath.row].value! - self.searchValute[indexPath.row].previous!
                if change >= 0 {
                    cell.backgroundColor = .green
                } else {
                    cell.backgroundColor = .red
                }
                cell.changeLabel.text = String(change)
                return cell
            }
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ValuteCell
            cell.codeLabel.text = self.valutesArray[indexPath.row].charCode!
            cell.valueLabel.text = String(self.valutesArray[indexPath.row].value!)
            cell.previousLabel.text = String(self.valutesArray[indexPath.row].previous!)
            let change = self.valutesArray[indexPath.row].value! - self.valutesArray[indexPath.row].previous!
            if change >= 0 {
                cell.backgroundColor = .green
            } else {
                cell.backgroundColor = .red
            }
            cell.changeLabel.text = String(change)
            return cell
            
        }
        return UITableViewCell()
    }
    
    
}


// MARK: - SearchBarExtensions
extension ListViewController: UISearchBarDelegate {
    
    func configureSearchBar(){
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.searchBar.placeholder = "Enter text..."
    }
    
    //Hide keybord when cancelButton tapped
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let searchBar = self.searchBar {
            searchBar.endEditing(true)
            self.searching = false
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchBar = self.searchBar {
            searchBar.endEditing(true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("checking")
        self.searchValute = self.valutesArray.filter({($0.charCode?.lowercased().prefix(searchText.count).elementsEqual(searchText.lowercased()))! })
        self.searching = true
        self.tableView.reloadData()
    }
}
