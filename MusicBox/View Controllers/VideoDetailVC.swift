//
//  VideoDetailVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 06/03/2021.
//

import SwiftUI
import SnapKit

class VideoDetailVC: UIViewController {
    
    private var comments = CommentModel.comments
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .appBackground
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 16, weight: .semibold))
        let rightArrowIcon = UIImage(systemName: "chevron.backward", withConfiguration: iconConfig)?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.white)
        btn.setImage(rightArrowIcon, for: .normal)
        btn.setTitle("Back", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var topVideoView: UIView = {
        let topView = UIView()
        topView.backgroundColor = .yellow

        let topViewHeight = view.frame.height / 2

        // add background image
        let bgIV = UIImageView(image: #imageLiteral(resourceName: "pic_1"))
        bgIV.contentMode = .scaleAspectFill
        bgIV.clipsToBounds = true
        bgIV.backgroundColor = .green
        
        topView.addSubview(bgIV)
        bgIV.snp.makeConstraints { (make) in
            make.edges.equalTo(topView)
        }
        
        // add gradient layer
        let gradientHeight: CGFloat = topViewHeight / 2.4
        let gradientLayerYOffset: CGFloat = topViewHeight - gradientHeight
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.appBackground.cgColor]
        gradientLayer.locations = [0, 0.85]
        topView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = CGRect(x: 0, y: gradientLayerYOffset, width: view.frame.width, height: gradientHeight)

        // add play button
        let playButton = UIButton()
        let playIconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 48))
        let playIcon = UIImage(systemName: "play.circle.fill", withConfiguration: playIconConfig)?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.appAccent.withAlphaComponent(0.8))
        playButton.setImage(playIcon, for: .normal)
        
        topView.addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        // add title lable
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = "Midnight Theme Is \nBeautiful"
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        
        topView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(topView).inset(20)
        }
        
        // add comment label
        let commentLabel = UILabel()
        commentLabel.font = UIFont.systemFont(ofSize: 16)
        commentLabel.textColor = .systemGray
        
        let attrString = NSMutableAttributedString(string: "Comments  ")
        attrString.append(NSMutableAttributedString(string: "4", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]))
        
        commentLabel.attributedText = attrString

        topView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).inset(-16)
            make.leading.trailing.bottom.equalTo(topView).inset(20)
        }
        
        // add bottom separator view
        let bottomSeparatorView = UIView()
        bottomSeparatorView.backgroundColor = UIColor.appAccent.withAlphaComponent(0.2)
        
        topView.addSubview(bottomSeparatorView)
        bottomSeparatorView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(topView).inset(10)
            make.bottom.equalTo(topView)
            make.height.equalTo(1)
        }
        
        return topView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(topVideoView)
        topVideoView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 2)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topVideoView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
        }
    }
    
    @objc private func handleBackButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
}

struct VideoDetailVC_Preview: PreviewProvider {
    
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container : UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return VideoDetailVC()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            // NO ACTION
        }
    }
}
