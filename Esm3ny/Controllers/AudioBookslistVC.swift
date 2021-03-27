//
//  ViewController.swift
//  Esm3ny
//
//  Created by Ahmad Khalil on 2/8/21.
//

import UIKit

class AudioBookslistVC: UIViewController {
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    enum section : CaseIterable {
        case continueReading
        case topBooks
    }
    
    // props
    var dataSource : UICollectionViewDiffableDataSource< section , BookItem >!
    var collectionView : UICollectionView!
    
    var orangeViewConstrain = NSLayoutConstraint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatBackground()
        creatHeaderView()
       
        
        creatCollectionView()
        configureDataSource()
    }
    
    func creatBackground() {
        
        let orangView = UIView()
        orangView.backgroundColor = #colorLiteral(red: 1, green: 0.4745098039, blue: 0.2823529412, alpha: 1)

        let purpleView : UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.08235294118, blue: 0.2117647059, alpha: 1) 
            return view
        }()
        
        let verticalstackView = VerticalStackView(arrangedSubViewsArray: [orangView , purpleView])
        view.addSubview(verticalstackView)
        
        let orangeViewConstraint = orangView.heightAnchor.constraint(equalToConstant: 200)
        orangeViewConstraint.isActive = true
        self.orangeViewConstrain = orangeViewConstraint
        //        constrainHeight(constant: 200)
        verticalstackView.fillSuperView()
        
        
    }
    
    
    func creatHeaderView() {
        
        let logoImage = UIImageView(cornerRadius: 0, image: #imageLiteral(resourceName: "Logo"))
        logoImage.contentMode = .scaleAspectFit
        
        let dotsButton : UIButton = {
            let button = UIButton()
            button.setImage(#imageLiteral(resourceName: "3DotsButton"), for: .normal)
            return button
        }()
        logoImage.constrainWidth(constant: 148)
        logoImage.constrainHeight(constant: 29)
//        dotsButton.constrainHeight(constant: 24)
        dotsButton.constrainWidth(constant: 24)
        
        let horizontalStack = UIStackView(arrangedSubviews: [ logoImage , UIView() ,  dotsButton])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 0
        
        logoImage       .translatesAutoresizingMaskIntoConstraints = false
        dotsButton      .translatesAutoresizingMaskIntoConstraints = false
        horizontalStack .translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(horizontalStack)
        horizontalStack.anchor(top: view.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 57, left: 20, bottom: 0, right: 20))
        
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let sectionType = section.allCases[sectionIndex]
            switch sectionType {
            case .continueReading:
                return self.creatContinueReadinglayout()
            case .topBooks:
                return self.creatTopBookslayout()
            }
        }
        return layout
    }
    func creatTopBookslayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension:  .fractionalWidth(1) , heightDimension: .absolute(112)), subitems: [item])
        group.contentInsets = .init(top: 8  , leading: 0  , bottom: 8 , trailing: 0)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20)), elementKind: AudioBookslistVC.sectionHeaderElementKind , alignment: .top)
        header.contentInsets = .init(top: 40, leading: 4 , bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 50, leading: 16, bottom: 0, trailing: 16)
        header.pinToVisibleBounds = true
        
        return section

    }
    func creatContinueReadinglayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        //        item.contentInsets = .init(top: 0, leading: 4 , bottom: 0, trailing: 4 )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(150), heightDimension: .absolute(224)), subitems: [item])
        //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(150), heightDimension: .absolute(224)), subitems: [item])
        group.contentInsets = .init(top: 0, leading: 1 , bottom: 0, trailing: 1)
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20)), elementKind: AudioBookslistVC.sectionHeaderElementKind , alignment: .top)
        header.contentInsets = .init(top: 0, leading: 4 , bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 10, leading: 16, bottom: 10, trailing: 130)
        header.pinToVisibleBounds = true

        section.visibleItemsInvalidationHandler = {[weak self] visibleItems, point, environment in
            if let scrollView = self?.collectionView {
                let cellHalfWidth : CGFloat = 75
                // the center point of the axis where the zoom occured
                let centerX = self!.collectionView.frame.origin.x + 20 + cellHalfWidth
                
                if let visbilCells = self?.collectionView.visibleCells {
//                    print(visbilCells.count)
                    for (num , cell ) in visbilCells.enumerated(){
                        // the coordinates of the cell orgin in term of it's rootView space coordinates
                        let basePosition = cell.convert(CGPoint.zero, to: self?.view)
                        let cellCenterX = basePosition.x + cellHalfWidth
                        
                        let distance = abs(cellCenterX - centerX)
//                        print("\(distance)  +  distance  for number\(num)")
                        //to make delay on applying the scale in small scrolling
                        let tolerance : CGFloat = 0.02
                        // 0.095 to make the scale  bigger ,, the smaller this number is -> the bigger the scale is
                        var scale = 1.0 + tolerance - ((distance / centerX ) * 0.095)
                        
//                        print("\(centerX)  +  centerX for number\(num)")
                        if scale > 1.0 {
                            scale = 1.0
                        }
                        // wierd number we don't know where it come from
                        if scale < 0.860091 {
                            scale = 0.860091
                        }
//                        print("\(scale)  +  scale  for number\(num)")
                        cell.transform = CGAffineTransform(scaleX: scale, y: scale)
                    }
                }
            }
        }
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func configureDataSource (){
        dataSource = UICollectionViewDiffableDataSource< section , BookItem >(collectionView: collectionView, cellProvider: { (collectionView, indexPath, bookItem) -> UICollectionViewCell? in
            let sectionType = section.allCases[indexPath.section]
            switch sectionType {
            case .continueReading :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContinueBooksCVC.reuseIdentifier, for: indexPath) as? ContinueBooksCVC
                cell?.book = bookItem
                return cell
            case .topBooks :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopBooksCVC.reuseIdentifier, for: indexPath) as? TopBooksCVC
                cell?.book = bookItem
                return cell
            }
          
        })
        
        // trying the supplemantryView registration handler in the same scoop with the supplemantryView provider closure
        let supplemantryRegistration = UICollectionView.SupplementaryRegistration<ContinueLisitningHeader>(elementKind: AudioBookslistVC.sectionHeaderElementKind ) { (supplemantryView, string, indexPath) in
            let sectionType = section.allCases[indexPath.section]
            switch sectionType {
            case .continueReading :
                supplemantryView.label.text = "Continue listening"
            case .topBooks :
                supplemantryView.label.text = "Top Books"
            }
        }
        dataSource.supplementaryViewProvider = {(view , kinde , index ) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplemantryRegistration, for: index)
        }

        let snapShot = snapShotForCurrentState()
        dataSource.apply(snapShot)
    }
    
    func snapShotForCurrentState() -> NSDiffableDataSourceSnapshot<section   , BookItem> {
        var snapshot = NSDiffableDataSourceSnapshot< section , BookItem >()
        snapshot.appendSections([section.continueReading , section.topBooks])
        let books = makeBooksArray()
        snapshot.appendItems(books, toSection: section.continueReading)
        let books2 = makeBooksArray2()
////        snapshot.appendSections([section.topBooks])
        snapshot.appendItems(books2 , toSection: section.topBooks)
        return snapshot
    }
        
    fileprivate func makeBooksArray() -> [BookItem] {
        return [BookItem(title: "Brave New World", image: #imageLiteral(resourceName: "Mask")) , BookItem(title: "The Old Man And The Sea", image: #imageLiteral(resourceName: "booksPhoto3")) , BookItem(title: "1984", image: #imageLiteral(resourceName: "booksPhoto")), BookItem(title: "The Old Man And The Sea", image: #imageLiteral(resourceName: "booksPhoto3")), BookItem(title: "1984", image: #imageLiteral(resourceName: "booksPhoto")), BookItem(title: "Brave New World", image: #imageLiteral(resourceName: "Mask")) , BookItem(title: "The Old Man And The Sea", image: #imageLiteral(resourceName: "booksPhoto3"))]
    }
    
    fileprivate func makeBooksArray2() -> [BookItem] {
        return [BookItemDetailed(title: "Pride and Prejudice", image: #imageLiteral(resourceName: "Cover1"), rating: 5.0, ratingCount: 88, price: 19.5, bookAutherName: "Jane Austen") , BookItemDetailed(title: "The Lord of the Flies", image: #imageLiteral(resourceName: "Cover"), rating: 4.5, ratingCount: 120, price: 5, bookAutherName: "William Golding") , BookItemDetailed(title: "Farenheit", image: #imageLiteral(resourceName: "Cover0"), rating: 1.4, ratingCount: 1250, price: 120, bookAutherName: "J.K. Rowling"), BookItemDetailed(title: "Pride and Prejudice", image: #imageLiteral(resourceName: "Cover1"), rating: 5.0, ratingCount: 88, price: 19.5, bookAutherName: "Jane Austen") , BookItemDetailed(title: "Farenheit", image: #imageLiteral(resourceName: "Cover0"), rating: 1.4, ratingCount: 1250, price: 120, bookAutherName: "J.K. Rowling") , BookItemDetailed(title: "The Lord of the Flies", image: #imageLiteral(resourceName: "Cover"), rating: 4.5, ratingCount: 120, price: 5, bookAutherName: "William Golding") , BookItemDetailed(title: "Farenheit", image: #imageLiteral(resourceName: "Cover0"), rating: 1.4, ratingCount: 1250, price: 120, bookAutherName: "J.K. Rowling")
                ]
    }
    
    func creatCollectionView() {
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
      
        collectionV.delegate = self

        collectionV.register(ContinueBooksCVC.self, forCellWithReuseIdentifier: ContinueBooksCVC.reuseIdentifier)
        collectionV.register(TopBooksCVC.self, forCellWithReuseIdentifier: TopBooksCVC.reuseIdentifier)

        collectionView = collectionV
        
        collectionV.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionV.backgroundColor = .clear
        self.view.addSubview(collectionV)
        collectionV.fillSuperviewWithPadding(padding: .init(top: 67, left: 0, bottom: 0, right: 0 ))
        
    }
     

    
}

extension AudioBookslistVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AudioBookVC(audioBookView: AudioBookView())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView else {return}
        
        let scrollViewOffset = scrollView.contentOffset.y
        
        let viewConstantHeight = max(111, min(200, 200-scrollViewOffset*2.8))
        orangeViewConstrain.constant = viewConstantHeight
        self.view.layoutIfNeeded()
        }
    }




//                        print(zoomedPoint.x )
//                        print("Zoomed Point")
//
//                        print(visibleItems[1].frame.origin.x )
//                        print( "center point of first of visible item")
//
//                        print(cell.center)
//                        print("cell.frame.origin.x")
//
//                        print(basePosition )
//                        print("basePosition ")
//
//                        print(self?.collectionView.frame.origin)
//                        print("self?.collectionView.frame.origin.x")
                    
//if !range.contains(Int(cell.frame.origin.x)) {
//                            if var snapShot = self?.snapShotForCurrentState() {
//                                print("didApplied snapshot-----------------------------------------")
//
//                                self?.dataSource.apply(snapShot )
//    //                            snapShot.reloadSections([.continueReading])
//                            }
//                        }
              
//                        if let cells = self?.collectionView.visibleCells as? [ContinueBooksCVC] {
//                            cells.filter{$0 != cell }.forEach{$0.transformTolarge()}
//                        }

//let zoomedPoint = CGPoint(x: scrollView.contentOffset.x + 81 , y: scrollView.contentOffset.y + 97 )
//let zoomCenterAxisCenter : CGPoint = .init(x: 81 , y: 139)
//if let indexpath =  self?.collectionView.indexPathForItem(at:  zoomedPoint)  {
//
//    if let cell = self?.collectionView.cellForItem(at: indexpath ) as? ContinueBooksCVC {
////                        print(cell.book?.title)
//
//        let basePosition = cell.convert(CGPoint.zero, to: self?.view)
////                        cell.transformTolarge()
//        let range = 17...145
//
//
//
////
//    }
//}

//       let zoomedPoint = CGPoint(x: scrollView.contentOffset.x + 85, y: scrollView.contentOffset.y + (self.collectionView.frame.size.height / 2) )
//        print("did")

//        if let indexPath = self.collectionView.indexPathForItem(at: zoomedPoint) {
//            let cell = self.collectionView.cellForItem(at: indexPath ) as! ContinueBooksCVC
//            print("yes")
//
