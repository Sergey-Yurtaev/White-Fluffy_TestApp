//
//  MainPhotoViewController.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 06.09.2022.
//

import UIKit

class MainPhotoViewController: UIViewController {
    
    //MARK: Private propertie
    private var viewModel: MainPhotoViewModelProtocol! {
        didSet {
            viewModel.fetchPhoto(searchTerm: "") { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    private let cellID = "cellSarchPhoto"
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    private var refreshControl = UIRefreshControl()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.register(CellPhoto.self, forCellWithReuseIdentifier: cellID)
        collection.backgroundColor = .whiteCustom
        collection.dataSource = self
        collection.delegate = self
        view.addSubview(collection)
        return collection
    }()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainPhotoViewModel()
        setupView()
        setupSearchBar()
        setupRefreshControl()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { [weak self] (_) in
            self?.viewModel.fetchPhoto(searchTerm: searchText) { [weak self] in 
                self?.collectionView.reloadData()
            }
        })
    }
    
    // MARK: - Private methods
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    private func setupView() {
        view.backgroundColor = .whiteCustom
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blueCustom]
        
    }
    
    // MARK: - Selector methods
    @objc private func update() {
        viewModel.fetchPhoto(searchTerm: "") { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.collectionView.reloadData()
            }
        }
    }
}

    // MARK: - UICollectionViewMethods
extension MainPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CellPhoto else {fatalError("cell error")}
        
        let cellViewModel = viewModel.cellViewModel(at: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVM = viewModel.viewModelForSelectedRow(at: indexPath)
        let detailsVC = DetailViewController()
        navigationController?.pushViewController(detailsVC, animated: true)
        detailsVC.viewModel = detailVM
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: 10)
        return CGSize(width: width, height: width)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return finalWidth - 1
    }
}

extension MainPhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}
