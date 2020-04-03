//
//  ListViewController.swift
//  ValuteChanges
//
//  Created by Egor on 01.04.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import Bond

class ListViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let viewModel = StartViewModel()
    let nib = UINib(nibName: "ValuteCell", bundle: nil)
    let identifier = "MyCell"
    let activityIndicator = UIActivityIndicatorView()
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        self.startAnim()
        self.configureSearchBar()
        //self.setupTableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(self.nib, forCellReuseIdentifier: self.identifier)
        
        self.viewModel.updateValutes(){
            self.tableView.reloadData()
            //self.searchBar.isHidden = false
            self.stopAnim()
        }
        
    }
    
    func setupTableView() {
        
    }
    
    func startAnim() {
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
    }
    
    func stopAnim() {
        self.activityIndicator.stopAnimating()
    }
}

// MARK: - TableViewExtensions
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searching {
            guard self.viewModel.numberOfSearchingValutes() != 0 else {return self.viewModel.numberOfValutes()}
            return self.viewModel.numberOfSearchingValutes()
        }
        return self.viewModel.numberOfValutes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.numberOfValutes() != 0 {
            if self.searching {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ValuteCell
                cell.viewModel = self.viewModel.searchingCellViewModel(index: indexPath.row)
                return cell
            }
            let cell = self.tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ValuteCell
            cell.viewModel = self.viewModel.cellViewModel(index: indexPath.row)
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
        self.viewModel.search(arg: searchText) {
            self.searching = true
            self.tableView.reloadData()
        }
        
    }
}
