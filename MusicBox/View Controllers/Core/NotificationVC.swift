//
//  NotificationVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import UIKit
import SwiftUI

class NotificationVC: UIViewController {
    
    // MARK: - Properties
    private var notifications = NotificationModel.notifications
    private var datasource: UICollectionViewDiffableDataSource<Int, NotificationModel>?
    private var snapshot: NSDiffableDataSourceSnapshot<Int, NotificationModel>?
    
    private let padding: CGFloat = 20
    // MARK: - View
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    // MARK: - Cell Registration
    
    private var notificationCellRegistration = UICollectionView.CellRegistration<NotificationCell, NotificationModel> { (cell, indexPath, item) in
        cell.notification = item
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .appBackground
        setupNavigationBar()
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.frame = view.bounds
        
        createDatasource()
        applySnapshot()
    }
    
    // MARK: - Private Helpers
    
    private func createDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: self.notificationCellRegistration, for: indexPath, item: item)
        })
    }
    
    private func applySnapshot() {
        snapshot = NSDiffableDataSourceSnapshot()
        snapshot?.appendSections([0])
        snapshot?.appendItems(notifications)
        
        datasource?.apply(snapshot!, animatingDifferences: true)
    }
    
    private func setupNavigationBar() {
        title = "Notifications"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.barTintColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withTintColor(.appGray), style: .plain, target: nil, action: nil)
    }
    
}

extension NotificationVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 2 * padding, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
    }
}

struct NotificationVC_Preview: PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return NotificationVC()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // NO ACTION
        }
    }
}
