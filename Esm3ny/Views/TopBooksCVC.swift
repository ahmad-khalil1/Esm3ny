//
//  TopBooksCVCCollectionViewCell.swift
//  Esm3ny
//
//  Created by Ahmad Khalil on 2/16/21.
//

import UIKit

class TopBooksCVC: UICollectionViewCell {
    static let reuseIdentifier = "TopBooksCVC-collectionView-cell-reuse-identifier"
     
    let starImage                       = UIImageView(image: #imageLiteral(resourceName: "Star"))
    var ratingLabel                     = UILabel(text: "5.0", font: UIFont(name: "Montserrat-Medium", size: 14) ?? .systemFont(ofSize: 40), fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var ratingCountLabel                = UILabel(text: "(88)", font: UIFont(name: "Montserrat-Regular", size: 14) ?? .systemFont(ofSize: 40),
                                                  numberOfLines: 0 , fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.5))
    var priceLabel                      = UILabel(text: "19.99 €", font:  UIFont(name: "Montserrat-Medium", size: 16) ?? .systemFont(ofSize: 40),
                                                  numberOfLines: 0 , fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) )
    var bookAuthorLabel                 = UILabel(text: "Jane Austen", font:  UIFont(name: "Montserrat-Regular", size: 14) ?? .systemFont(ofSize: 40),
                                                  numberOfLines: 0, fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.8))
    var bookNameLabel                   = UILabel(text: "Pride and Prejudice", font:  UIFont(name: "Montserrat-SemiBold", size: 16) ??
                                                    .systemFont(ofSize: 30) , fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var bookImage                       = UIImageView(cornerRadius: 8, image: #imageLiteral(resourceName: "Cover1"))
    
    func creatStackView() -> UIStackView{
    
        let mainHorizontalStack         = UIStackView(horizontalStackedViews: [ bookImage , UIStackView(verticalStackedViews:
                                                                                                                    [bookNameLabel ,
                                                                                                                     bookAuthorLabel ,
                                                                                                                     UIStackView(horizontalStackedViews:
                                                                                                                                    [ priceLabel , UIView() , UIStackView(horizontalStackedViews: [ starImage, ratingLabel , ratingCountLabel , UIView()] , spacing: 4)
                                                                                                                                    ] , spacing: 7)
                                                                                                                    ], spacing: 5,distrubtion:.fillEqually) , UIView()], spacing: 12)
        return mainHorizontalStack
    }
    
    var book : BookItem? {
        didSet{
            guard let bookItem = book as? BookItemDetailed else {
                fatalError("invalide bookItem intialization NOT BookItemDetailed type ")
            }
            self.ratingLabel.text       = String(bookItem.rating)
            self.ratingCountLabel.text  = String(bookItem.ratingCount)
            self.priceLabel.text        = String(bookItem.price)
            self.bookAuthorLabel.text   = bookItem.bookAutherName
            self.bookNameLabel.text     = bookItem.bookAutherName
            self.bookImage.image        = bookItem.image
            configure()

        }
        
    }
    
    fileprivate func configure() {
        contentView.backgroundColor = .clear
        let stack = creatStackView()
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.fillSuperView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
