//
//  NotificationVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import UIKit
import SwiftUI

struct NotificationModel: Hashable {
    
    let id = UUID()
    var name: String
    var profileImage: UIImage
    var time: String
    var type: NotificationType
    
    static var notifications: [NotificationModel] = [
        .init(name: "Tyson Marlo", profileImage: UIImage(named: "pic_1")!, time: "2h", type: .like),
        .init(name: "Joan Silverlake", profileImage: UIImage(named: "pic_3")!, time: "2h", type: .follow),
        .init(name: "Joan Silverlake", profileImage: UIImage(named: "pic_3")!, time: "2h", type: .reply),
        .init(name: "Tyson Marlo", profileImage: UIImage(named: "pic_1")!, time: "3h", type: .like)
    ]
    
    enum NotificationType {
        case like
        case follow
        case reply
        
        var notificationText: String {
            switch self {
            case .like:
                return "liked to your song."
            case .follow:
                return "started following you!"
            default:
                return "replied to your comment."
            }
        }
    }
}

class NotificationCell : UICollectionViewCell {
    
    // MARK: - Properties
    var notification: NotificationModel? {
        didSet {
            // TODO: Implement Later
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withTintColor(.appGray), style: .plain, target: nil, action: nil)
    }
    
}

extension NotificationVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 2 * padding, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
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
