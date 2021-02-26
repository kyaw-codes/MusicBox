//
//  MKTabBar.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import UIKit
import SnapKit

class MKTabBar: UIView {
    
    // MARK: - Delegate
    
    var onTabItemTap: ((Int) -> Void)!
    
    // MARK: - Private Properties

    private var iconSize: CGSize = CGSize(width: 28, height: 28)

    /*
     * Injected in constructor
     * Provide information needed to render out the tab bar
     */
    private var tabItemData: [MKTabItemData]!
    
    /*
     * Representing the array of TabBarItem(i.e UIView subclass)
     */
    private var tabItemViews: [UIView] = [UIView]()
    
    /*
     * Currently selected tab index
     */
    private var selectedIndex = 0
    
    private var xOffsets = [CGFloat]()
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .appTabBackground
    }
    
    convenience init(items: [MKTabItemData]) {
        self.init(frame: .zero)
        
        tabItemData = items
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var tabContentPlaceholderViews = [UIView]()
        
        // Calculate the x offsets for each tab item
        calculateOffsetForEachTabItem(&xOffsets)
        
        // Partition placeholder views for tab bar item to fit in equally
        partitionPlaceholderViews(&tabContentPlaceholderViews)
        
        // Build tab item view, add it to on of the placeholder views, laying out the tab item and finally add placeholders to the
        for i in 0..<tabContentPlaceholderViews.count {
            let placeholderView = tabContentPlaceholderViews[i]
            let tabBarItem = tabItemData[i]
        
            // Build tab item view
            let tabItemView = i == 0 ? crateTabBarItem(icon: tabBarItem.iconSelected, isActive: true) : crateTabBarItem(icon: tabBarItem.icon, isActive: false)
            
            tabItemViews.append(tabItemView)
            
            placeholderView.addSubview(tabItemView)
            
            tabItemView.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                make.top.equalToSuperview().inset(10)
            }
            
            addSubview(placeholderView)
        }
    }
    
    // MARK: - Tap Handlers
    
    @objc func handleTabItemTap(sender: UIGestureRecognizer) {
        let previousIndex = selectedIndex
        selectedIndex = sender.view!.tag
        onTabItemTap(selectedIndex)
        
        // Unactivate the selected tab appearance
        let previousTabView = tabItemViews[previousIndex] as! UIStackView
        (previousTabView.arrangedSubviews[0] as! UIImageView).tintColor = .appAccent
        (previousTabView.arrangedSubviews[0] as! UIImageView).image = tabItemData[previousIndex].icon
        (previousTabView.arrangedSubviews[1]).alpha = 0
        
        // Activate the selected tab appearance
        let currentTabView = tabItemViews[selectedIndex] as! UIStackView
        (currentTabView.arrangedSubviews[0] as! UIImageView).tintColor = .white
        (currentTabView.arrangedSubviews[0] as! UIImageView).image = tabItemData[selectedIndex].iconSelected
        (currentTabView.arrangedSubviews[1]).alpha = 1
    }
    
    // MARK: - Private Helpers

    fileprivate func calculateOffsetForEachTabItem(_ xOffsets: inout [CGFloat]) {
        for i in 0..<tabItemData.count {
            let unitWidth = (frame.width - 24) / CGFloat(tabItemData.count)
            xOffsets.append((CGFloat(i) * unitWidth) + 12)
        }
    }

    fileprivate func partitionPlaceholderViews( _ tabContentPlaceholderViews: inout [UIView]) {
        for i in 0..<xOffsets.count {
            let xOffset = xOffsets[i]
            let placeholderView = UIView(frame: CGRect(x: xOffset, y: 0, width: frame.width / CGFloat(tabItemData.count), height: frame.height))
            
            // By assigning the index number to placeholder view's tag, it will tell the index of the tab item when tap
            placeholderView.tag = i
            
            placeholderView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTabItemTap(sender:))))
            
            tabContentPlaceholderViews.append(placeholderView)
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
    
}
