//
//  SearchVC.swift
//  InstaAPI
//
//  Created by Elif Tüm on 30.10.2023.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class SearchVC: UIViewController {
    
    private let searchBar = UISearchBar()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var highlightsModel : HighlightsModel?
    
    private let cellIdentifier = "Cell"
    
    private var viewmodel = SearchViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        setupViews()
        setupConstraints()
    }
    
    private func setupDelegates(){
        viewmodel.delegate = self
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func setupViews() {
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .white
        searchBar.placeholder = "Enter an username..."
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(CGFloat(35))
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return highlightsModel?.result?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SearchResultCell
        if let highlight = highlightsModel?.result?[indexPath.row] {
            cell.configure(highlightsResult: highlight)
            return cell
        }
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            viewmodel.getHighlightes(userName: text)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width/2)-20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedId = highlightsModel?.result?[indexPath.row].id {
            let vc = HighlightDetailsVC(id: selectedId)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension SearchVC:  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {}

extension SearchVC: SearchBusinessLogic {
    
    func didFinishWithResponse(response: HighlightsModel) {
        highlightsModel = response
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func didFinishWithError(error: CustomError) {
        print(error.localizedDescription)
    }
}

class SearchResultCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func configure(highlightsResult:HighlightsResult) {
        imageView.setImage(url: highlightsResult.coverMedia?.croppedImageVersion?.url ?? "")
        titleLabel.text = highlightsResult.title
        imageView.makeCircular()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFit
        
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.gray.cgColor
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(titleLabel.snp.top).offset(-5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
    }
}
