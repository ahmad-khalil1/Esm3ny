//
//  AKFloatTabBar.swift
//  CustomTabBarTest
//
//  Created by Ahmad Khalil on 2/15/21.
//

import UIKit

class AKFloatTabBar: UITabBarController, UITabBarControllerDelegate {
    
    private var selectedTab: Int = 0
    private var buttons = [UIButton]()
    
    
    
    private let customTabBarView: UIView = {
        func creatBlurView() -> UIVisualEffectView {
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return blurEffectView
        }
        let view                                                      = UIView(frame: .zero)
        view.backgroundColor                                          = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.2)
        let blurView                                                  = creatBlurView()
        view.addSubview(blurView)
            
        view.clipsToBounds                                            = true
        view.translatesAutoresizingMaskIntoConstraints                = false
        return view
    }()
    
   
    
    private let stackView: UIStackView = {
        let stackView                                                 = UIStackView()
        stackView.distribution                                        = .equalSpacing
        stackView.axis                                                = .horizontal
        stackView.spacing                                             = 25
        stackView.translatesAutoresizingMaskIntoConstraints           = false
        return stackView
    }()
    
    override var viewControllers: [UIViewController]? {
        didSet {
            createButtonsStack(viewControllers!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        addCustomTabBarView()
        ConfigureLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customTabBarView.layer.cornerRadius = customTabBarView.frame.size.height / 2
    }
    
    
    private func createButtonsStack(_ viewControllers: [UIViewController]) {
        
        // clean :
        buttons.removeAll()
        
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        for (index, Contoller) in viewControllers.enumerated() {
            guard let tabBarItem = Contoller.tabBarItem as? AKFloatTabBarItem else {
                assertionFailure("TabBarItems class must be KRTabBarItem")
                return
            }
                       
            let button                                                     = UIButton()
            button.tag                                                     = index
            button.addTarget(self, action: #selector(didSelectIndex(sender:)), for: .touchUpInside)
            if Contoller == viewControllers.first {
                button.isSelected = true
            }
            
            let image                                                       = Contoller.tabBarItem.image
            let selectedImage                                               = tabBarItem.selectedImage
           
            button.setImage(image, for: .normal)
            button.setImage(selectedImage, for: .selected)

            
            
            button.imageView?.clipsToBounds                                 = true
            button.translatesAutoresizingMaskIntoConstraints                = false
            stackView.addArrangedSubview(button)
            buttons.append(button)

        }
        
        view.setNeedsLayout()
    }
    
    private func ConfigureLayout() {
        let margins = view.layoutMarginsGuide
        customTabBarView.anchor(top: nil, leading: nil, bottom: margins.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0) , size: .init(width: 238, height: 51))
        customTabBarView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        
        stackView.anchor(top: nil, leading: customTabBarView.leadingAnchor , bottom: nil, trailing: customTabBarView.trailingAnchor, padding: .init(top: 0, left: 25, bottom: 0, right: 25))
        stackView.heightAnchor.constraint(equalTo: customTabBarView.heightAnchor).isActive = true
    }
    
    private func addCustomTabBarView() {
        customTabBarView.frame                                                 = tabBar.frame
        
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
        customTabBarView.addSubview(stackView)
    }
    
    @objc private func didSelectIndex(sender: UIButton) {
        buttons.forEach{$0.isSelected = false}
        let index                                                              = sender.tag
        self.selectedIndex                                                     = index
        self.selectedTab                                                       = index
        sender.isSelected                                                      = true
    }
    
    
    // Delegate:
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard
            let items                                                          = tabBar.items,
            let index                                                          = items.firstIndex(of: item)
            else {
                print("not found")
                return
        }
        didSelectIndex(sender: self.buttons[index])
    }
    
    
}

