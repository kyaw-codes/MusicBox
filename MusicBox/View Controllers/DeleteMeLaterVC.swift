//
//  DeleteMeLaterVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 07/03/2021.
//

import SwiftUI
import SnapKit
import ReadMoreTextView

class DeleteMeLaterVC: UIViewController {
    
    let textView = ReadMoreTextView()
    let someView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.shouldTrim = true
        textView.attributedText = NSAttributedString(string: "Starbucks Corporation is an American multinational chain of coffeehouses and roastery reserves headquartered in Seattle, Washington. As the world's largest coffeehouse chain, Starbucks is seen to be the main representation of the United States' second wave of coffee culture.", attributes: [NSAttributedString.Key.font : UIFont(name: "Futura", size: 24)!])
        textView.maximumNumberOfLines = 3
        textView.attributedReadMoreText = NSAttributedString(string: "...Read More", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen, NSAttributedString.Key.font : UIFont(name: "Futura", size: 24)!])
        textView.attributedReadLessText = NSAttributedString(string: "...Read Less", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font : UIFont(name: "Futura", size: 24)!])
        
        someView.backgroundColor = .systemBlue
        
        view.addSubview(textView)
        view.addSubview(someView)
        
        textView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(40)
        }
                
        someView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom)
            make.leading.trailing.equalTo(textView)
            make.height.equalTo(200)
        }
    }
}

struct DeleteMeLaterVC_Preview: PreviewProvider {
    
    static var previews: some View {
        Container()
    }
    
    struct Container: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return DeleteMeLaterVC()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // Do Nothing
        }
    }
}
