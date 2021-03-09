//
//  SearchVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import SwiftUI

class SearchVC: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        collectionView.backgroundColor = .appBackground
    }

}

struct SearchVC_Preview : PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return SearchVC()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // NO ACTION
        }
    }
}
