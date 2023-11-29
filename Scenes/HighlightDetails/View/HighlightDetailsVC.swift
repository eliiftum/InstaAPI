//
//  HighlightDetailsVC.swift
//  InstaAPI
//
//  Created by Elif Tüm on 29.10.2023.
//

import UIKit
import AVFoundation
import AVKit

class HighlightDetailsVC: UIViewController {
    
    private var highlightsDetails: HighlightStoriesModel?
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var id : String
    
    private var viewModel = HighlightDetailViewModel()
    
    private let cellIdentifier = "DetailCell"
    
    
    init(id: String) {
        self.id = id
        super.init(nibName: nil , bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupCollectionView()
        setupConstraints()
        viewModel.getDetails(detailsId: id)

    }
    
    private func setupDelegates(){
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.register(HighlightDetailCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HighlightDetailCell
        if let highlight = highlightsDetails?.result?[indexPath.row] {
            cell.configure(highlightsResult: highlight)
            return cell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return highlightsDetails?.result?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedUrl = highlightsDetails?.result?[indexPath.row].videoVersions?.first?.url, let url = URL(string: selectedUrl) {
            let avplayer = AVPlayer(url: url)
            let avplayerVC = AVPlayerViewController()
            avplayerVC.player = avplayer
            self.present(avplayerVC, animated: true)
        }
    }
    
}

extension HighlightDetailsVC:  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
}

extension HighlightDetailsVC: HighlightDetailBusinessLogic {
    func didFinishWithResponse(response: HighlightStoriesModel) {
        highlightsDetails = response
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func didFinishWithError(error: CustomError) {
        print(error.localizedDescription)
    }
}


class HighlightDetailCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    func configure(highlightsResult:HighlightStoriesResult) {
        
        imageView.setImage(url: highlightsResult.imageVersions2?.candidates?.first?.url ?? "")
        titleLabel.text = "Has Audio \(highlightsResult.hasAudio ?? true ? "Yes": "No")"
        imageView.makeCircular()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        
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

