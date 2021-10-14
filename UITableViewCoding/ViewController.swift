//
//  ViewController.swift
//  UITableViewCoding
//
//  Created by Aleksandr Rybachev on 14.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        hierarchy()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        updateLayout(with: view.frame.size)
    
    }
    
    private func hierarchy() {
        view.addSubview(tableView)
    }
    
    private func updateLayout(with size: CGSize) {
        tableView.frame = CGRect.init(origin: .zero, size: size)
    }


}

