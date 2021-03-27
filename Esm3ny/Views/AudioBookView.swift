//
//  AudioBookView.swift
//  Esm3ny
//
//  Created by Ahmad Khalil on 2/23/21.
//

import UIKit
@IBDesignable
class AudioBookView: UIView {
    

    
    let bookImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "coverpdf")
        return imageView
    }()
    
    let playbutton : UIButton = {
        let button = UIButton()
        let image = #imageLiteral(resourceName: "playButton").withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(1)
        
        return button   
    }()
    
    let bluredView : UIView = {
        let View = UIView()
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = View.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = View.frame
        View.addSubview(blurEffectView)
        View.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowRadius = 1
        View.layer.shadowOffset = .init(width: 4, height: 14)
        View.clipsToBounds = true
        View.layer.cornerRadius = 40
        return View
    }()
    
    let starImage                       = UIImageView(image: #imageLiteral(resourceName: "Star"))
    var ratingLabel                     = UILabel(text: "5.0", font: UIFont(name: "Montserrat-Medium", size: 16) ?? .systemFont(ofSize: 40), fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var ratingCountLabel                = UILabel(text: "(88)", font: UIFont(name: "Montserrat-Regular", size: 16) ?? .systemFont(ofSize: 40),
                                                  numberOfLines: 0 , fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.5))
   
    var bookAuthorLabel                 = UILabel(text: "Aldous H.", font:  UIFont(name: "Montserrat-Regular", size: 16 ) ?? .systemFont(ofSize: 40),
                                                  numberOfLines: 0, fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.8))
    var bookNameLabel                   = UILabel(text: "Brave New World", font:  UIFont(name: "Montserrat-SemiBold", size: 20) ??
                                                    .systemFont(ofSize: 30) , fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
  
    let progresBar : UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.progress = 0.7
        progress.progressTintColor =  #colorLiteral(red: 1, green: 0.4745098039, blue: 0.2823529412, alpha: 1)
        progress.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.937254902, blue: 0.9490196078, alpha: 1)
        
//        progress.layer.cornerRadius = progress.frame.height/2
        return progress
    }()
    
    let ellapsetime                = UILabel(text: "00:00", font: UIFont(name: "Montserrat-Regular", size: 14) ?? .systemFont(ofSize: 40), numberOfLines: 0 , fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    let remainingTime              = UILabel(text: "-0:08:30", font: UIFont(name: "Montserrat-Regular", size: 14) ?? .systemFont(ofSize: 40), numberOfLines: 0 , fontcolor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    
    
    func creatTimeStackView() -> UIStackView {
        let stack = UIStackView(horizontalStackedViews: [ ellapsetime ,remainingTime ],spacing: 220 , distrubtion: .fill )
//        stack.constrainWidth(constant: 335 )
        return stack
    }
    
    func creatRatingStackView() -> UIStackView {
        let stack = UIStackView(horizontalStackedViews: [  starImage, ratingLabel , ratingCountLabel  ] , spacing: -4 , distrubtion: .equalSpacing )
        stack.alignment = .center
        return stack
    }
    
    func creatBookDataStackView() -> UIStackView {
        let ratingStack = creatRatingStackView()
        let stack = UIStackView(verticalStackedViews: [ bookNameLabel , bookAuthorLabel , ratingStack ], spacing: 6, distrubtion: .fillEqually)
//        stack.constrainHeight(constant: 78)
        stack.alignment = .center
        return stack
    }
    
    func creatPlayerStack() -> UIStackView {
        let timeStack = creatTimeStackView()
        let stack  = UIStackView(verticalStackedViews: [progresBar , timeStack] ,spacing: 12)
        stack.alignment = .center
        //        stack.constrainHeight(constant: 78)
        return stack
    }
    
 
    
    init(){
        super.init(frame: .zero)
        
        configure()
    }
    
    func configure() {
        backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.08235294118, blue: 0.2117647059, alpha: 1)
        
        
        configureLayout()
        

    }
    
    func configureLayout() {
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bookImageView)
        bookImageView.anchor(top: self.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 560))
        
        bluredView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bluredView)
        bluredView.anchor(top: bookImageView.bottomAnchor , leading: nil, bottom: nil, trailing: nil, padding: .init(top: -40 , left: 0, bottom: 0, right: 0), size: .init(width: 80 , height: 80))
        bluredView.centerXanchorToSuperView()
        
        
        playbutton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playbutton)
        playbutton.anchor(top: bookImageView.bottomAnchor , leading: nil, bottom: nil, trailing: nil, padding: .init(top: -40 , left: 0, bottom: 0, right: 0), size: .init(width: 80 , height: 80))
        playbutton.centerXanchorToSuperView()
        
        let dataStack = creatBookDataStackView()
        dataStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dataStack)
        dataStack.centerXanchorToSuperView()
        dataStack.anchor(top: playbutton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        let playerStack = creatPlayerStack()
        playerStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerStack)
        progresBar.constrainWidth(constant: 335)

//        playerStack.centerXanchorToSuperView()
        playerStack.anchor(top: dataStack.bottomAnchor, leading: self.leadingAnchor , bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.trailingAnchor , padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AudioBookView_preview : PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        AudioBookView().toPreview()
    }
}
#endif
