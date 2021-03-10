//
//  SearchVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import SwiftUI

class SearchVC: UICollectionViewController {
    
    // MARK: - Private Properties
    
    private let continueWatchingVideos = WatchedVideoModel.continueWatchingVideos
    private let watchedVideos = WatchedVideoModel.watchedVideos
    
    // MARK: - Constructors
    init() {
        // TODO: Build compositional layout
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell & Header Registrations
    
    // TODO: Register search cell
    
    
    // TODO: Register continue watching cell
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        collectionView.backgroundColor = .appBackground
    }
    
    // MARK: - Private Helpers
    
    // TODO: Compose continue watching section

}

extension SearchVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return continueWatchingVideos.count
    }
    
    // TODO: Implement cellForItemAtIndexPath(collectionView:indexPath:)
}

extension SearchVC {
    
    enum Section: Int {
        case SEARCH = 0
        case CONTINUE_WATCHING = 1
        case HISTORY = 2
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
