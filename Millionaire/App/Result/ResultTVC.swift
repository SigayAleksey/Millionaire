//
//  ResultTVC.swift
//  Millionaire
//
//  Created by Алексей Сигай on 02/03/2019.
//  Copyright © 2019 Алексей Сигай. All rights reserved.
//

import UIKit

class ResultTVC: UITableViewController {
    
    let cellID = "ResultCell"
    
    fileprivate static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.resultsOfGames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let result = Game.shared.resultsOfGames[indexPath.row]
        cell.textLabel?.text = ResultTVC.dateFormatter.string(from: result.date)
        cell.detailTextLabel?.text = "\(result.winning)"
        return cell
    }

}
