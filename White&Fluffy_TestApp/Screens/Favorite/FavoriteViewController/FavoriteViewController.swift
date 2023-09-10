//
//  FavoriteViewController.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 06.09.2022.
//

import UIKit
import Kingfisher

final class FavoriteViewController: UIViewController {
    
    //MARK: Private properties
    private var viewModel: FavoriteViewModelProtocol!
    private let cellID = "cellFavoritePhoto"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .whiteCustom
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = self.view.frame
        tableView.register(CellFavoritePhoto.self, forCellReuseIdentifier: cellID)
        view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoriteViewModel()
        view.backgroundColor = .whiteCustom
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVM = viewModel.viewModelForSelectedRow(at: indexPath)
        let detailsVC = DetailViewController()
        navigationController?.pushViewController(detailsVC, animated: true)
        detailsVC.viewModel = detailVM
    }
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CellFavoritePhoto else { fatalError("Unabel to create cell") }
        cell.backgroundColor = .whiteCustom
        let cellViewModel = viewModel.cellViewModel(at: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}
