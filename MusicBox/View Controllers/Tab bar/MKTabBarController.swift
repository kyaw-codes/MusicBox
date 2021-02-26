//
//  BaseTabBarController.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import SwiftUI
import SnapKit

class MKTabBarController: UITabBarController {
    
    private let tabItems: [MKTabItemData] = MKTabItemData.allCases
    private lazy var mkViewControllers: [UIViewController] = tabItems.map { $0.viewController }
    private let tabBarHeigth = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mkTabBar = MKTabBar(items: tabItems)
        viewControllers = mkViewControllers
        tabBar.isHidden = true
        
        mkTabBar.onTabItemTap = { [weak self] index in
            guard let strongSelf = self else { return }
            strongSelf.selectedIndex = index
        }
        
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
