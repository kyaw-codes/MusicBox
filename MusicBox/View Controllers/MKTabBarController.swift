//
//  BaseTabBarController.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import SwiftUI
import SnapKit

enum MKTabBarItem: CaseIterable {
    
    case home, search, addNew, notification, profile
    
    var icon: UIImage {
        get {
            switch self {
            case .search:
                return UIImage(systemName: "magnifyingglass")!
            case .addNew:
                return UIImage(systemName: "plus")!
            case .notification:
                return UIImage(systemName: "bell")!
            case .profile:
                return UIImage(systemName: "person")!
            default:
                return UIImage(systemName: "house")!
            }
        }
    }
    
    var iconSelected: UIImage {
        get {
            switch self {
            case .search:
                return UIImage(systemName: "magnifyingglass")!
            case .addNew:
                return UIImage(systemName: "plus")!
            case .notification:
                return UIImage(systemName: "bell")!
            case .profile:
                return UIImage(systemName: "person")!
            default:
                return UIImage(systemName: "house")!
            }
        }
    }
    
    var viewController: UIViewController {
        get {
            switch self {
            case .search:
                return SearchVC()
            case .addNew:
                return AddNewVC()
            case .notification:
                return NotificationVC()
            case .profile:
                return ProfileVC()
            default:
                return UINavigationController(rootViewController: HomeVC())
            }
        }
    }
}

class MKTabBar: UIView {
    
    var iconSize: CGSize = CGSize(width: 28, height: 28)
    var tabBarItems: [MKTabBarItem]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .appTabBackground
    }
    
    convenience init(items: [MKTabBarItem]) {
        self.init(frame: .zero)
        
        tabBarItems = items
        
//        var tabBarItemViews = [UIView]()
//
//        for i in 0..<items.count {
//            let item = items[i]
//            tabBarItemViews.append(crateTabBarItem(icon: item.icon, isActive: i == 0))
//        }
//
//        let stackView = UIStackView(arrangedSubviews: tabBarItemViews)
//        stackView.distribution = .equalSpacing
//
//        addSubview(stackView)
//        stackView.snp.makeConstraints { (make) in
//            make.leading.trailing.equalToSuperview().inset(40)
//            make.top.equalToSuperview().inset(10)
//        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var xOffsets = [CGFloat]()
        var tabContentViews = [UIView]()
        
        for i in 0..<tabBarItems.count {
            let unitPoint = (frame.width - 24) / CGFloat(tabBarItems.count)
            xOffsets.append((CGFloat(i) * unitPoint) + 12)
        }
        
        for i in 0..<xOffsets.count {
            let xOffset = xOffsets[i]
            let contentView = UIView(frame: CGRect(x: xOffset, y: 0, width: frame.width / CGFloat(tabBarItems.count), height: frame.height))
            tabContentViews.append(contentView)
        }
        
        for i in 0..<tabContentViews.count {
            let tabView = tabContentViews[i]
            let tabBarItem = tabBarItems[i]
            let tabItem = crateTabBarItem(icon: tabBarItem.icon, isActive: i == 0)
            
            tabView.addSubview(tabItem)
            
            tabItem.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                make.top.equalToSuperview().inset(10)
            }
            
            addSubview(tabView)
        }
        
    }
    
    private func crateTabBarItem(icon image: UIImage, isActive: Bool) -> UIView {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .center

        let imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = isActive ? .white : .appAccent
        
        let bottomUnderline = UIView()
        bottomUnderline.backgroundColor = .white
        bottomUnderline.alpha = isActive ? 1 : 0
        
        sv.addArrangedSubview(imageView)
        sv.addArrangedSubview(bottomUnderline)
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(iconSize.width)
            make.height.equalTo(iconSize.height)
        }
        
        bottomUnderline.snp.makeConstraints { (make) in
            make.height.equalTo(3)
            make.width.equalTo(iconSize.width + 18)
        }
        bottomUnderline.layer.cornerRadius = 3
        
        return sv
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class MKTabBarController: UITabBarController {
    
    private let tabItems: [MKTabBarItem] = MKTabBarItem.allCases
    private lazy var mkViewControllers: [UIViewController] = tabItems.map { $0.viewController }
    private let tabBarHeigth = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mkTabBar = MKTabBar(items: tabItems)
        viewControllers = mkViewControllers
        tabBar.isHidden = true
        
        view.addSubview(mkTabBar)
        mkTabBar.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(tabBarHeigth)
        }

    }
}

struct MKTabBarController_Preview: PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return MKTabBarController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
