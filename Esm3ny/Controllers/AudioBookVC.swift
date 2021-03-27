//
//  AudioBookVC.swift
//  Esm3ny
//
//  Created by Ahmad Khalil on 2/23/21.
//

import UIKit

class AudioBookVC: UIViewController {
    
    var audioBookView : UIView
    
    init(audioBookView : UIView) {
        self.audioBookView = audioBookView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        configureView()
        

    }
    fileprivate func configureView() {
        
        self.view = audioBookView
        

//        self.view.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.08235294118, blue: 0.2117647059, alpha: 1)
    }
    

    
}
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct AudioBookVC_preview : PreviewProvider {
    
    static var previews: some View {
        // view controller using programmatic UI
        AudioBookVC(audioBookView: AudioBookView()).toPreview()
    }
}
#endif
