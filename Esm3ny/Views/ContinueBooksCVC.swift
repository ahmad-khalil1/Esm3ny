//
//  ContinueBooksCVC.swift
//  Esm3ny
//
//  Created by Ahmad Khalil on 2/10/21.
//

import UIKit

class ContinueBooksCVC: UICollectionViewCell {
    static let reuseIdentifier = "ContinueBooksCVC-collectionView-cell-reuse-identifier"
    
    let label = UILabel(text: "", font: .systemFont(ofSize: 40))
    let bookPicture : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    let playButton : UIButton =  {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "playButton"), for: .normal)
        return button
    }()
    
    let progressBar : UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.progress = 0.7
        progress.progressTintColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        progress.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.12)
        progress.layer.cornerRadius = 4
        
        return progress
    }()
    
    var book : BookItem? {
        didSet{
            if let book = self.book {
                self.bookPicture.image = book.image
            }
        }
    }
    
    func transformTolarge(){
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.154, y: 1.154)
//            (scaleX: 0.846, y: 0.846)
        }
    }
    
    fileprivate func configure() {
        contentView.addSubview(bookPicture)
        bookPicture.fillSuperView()
        
        addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.constrainWidth(constant: 50)
        playButton.constrainHeight(constant: 50)
        playButton.anchor(top: nil, leading: nil, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor  , padding: .init(top: 0, left: 0, bottom: 8, right: 8) )
        
        
        addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.constrainHeight(constant: 4)
        progressBar.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor  , padding: .init(top: 12, left: 12, bottom: 0 , right: 12) )
        
        //        self.layer.cornerRadius = 8
        //        self.layer.cornerRadius = contentView.bounds.width / 2
        //        clipsToBounds = true
        //        backgroundColor =  #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
