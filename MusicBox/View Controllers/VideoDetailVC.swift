//
//  VideoDetailVC.swift
//  MusicBox
//
//  Created by Ko Kyaw on 06/03/2021.
//

import SwiftUI
import SnapKit
import EmojiPicker

class VideoDetailVC: UIViewController {
    
    private var comments = CommentModel.comments
    private var commentViewBottomConstraint: Constraint?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .clear
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
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleBackButtonClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var writeCommentView = WriteCommentView()

    private lazy var topVideoView = VideoHeaderView()
    
    private var datasource: UICollectionViewDiffableDataSource<Int, CommentModel>?
    private var snapshot: NSDiffableDataSourceSnapshot<Int, CommentModel>?
    
    private lazy var commentCellRegistration = UICollectionView.CellRegistration<CommentCell, CommentModel> { (cell, indexPath, comment) in
        cell.comment = comment
        cell.onCommentReacted = { reactedCell in
            reactedCell.likeButton.tintColor = reactedCell.likeButton.tintColor == UIColor.appAccent ? UIColor.appRed : UIColor.appAccent
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBackground
        
        writeCommentView.delegate = self

        setUpViews()
        createDatasource()
        applySnapshot()
            
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    private func setUpViews() {
        view.addSubview(topVideoView)
        topVideoView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.height / 2)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topVideoView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(writeCommentView)
        writeCommentView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            self.commentViewBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            make.height.equalTo(65)
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOutside)))
    }
    
    private func createDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let strongSelf = self else { return nil }
            return collectionView.dequeueConfiguredReusableCell(using: strongSelf.commentCellRegistration, for: indexPath, item: item)
        })
    }
    
    private func applySnapshot() {
        snapshot = NSDiffableDataSourceSnapshot()
        snapshot?.appendSections([0])
        snapshot?.appendItems(comments)
        datasource?.apply(snapshot!, animatingDifferences: true)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: .fixed(10), trailing: .none, bottom: .none)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            return section
        }
    }
    
    @objc private func handleBackButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        let isKeyboardShowing = notification.name == UIView.keyboardWillShowNotification
        let keyboardRect = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) as? NSValue)?.cgRectValue
        
        let keyboardHeight = keyboardRect!.height - view.safeAreaInsets.bottom
        let bottomInset = isKeyboardShowing ? keyboardHeight : 0
        
        commentViewBottomConstraint?.update(inset: bottomInset)
        
        let animationDuration = ((notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]) as? NSNumber)?.doubleValue
        
        UIView.animate(withDuration: animationDuration ?? 0) {
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: animationDuration ?? 0) {
            self.view.layoutIfNeeded()
        } completion: { (_) in
            let lastCommentIndexPath = IndexPath(item: self.comments.count - 1, section: 0)
            self.collectionView.scrollToItem(at: lastCommentIndexPath, at: .bottom, animated: true)
        }

    }
    
    // Dismiss the keyboard when tap anywhere outside of the targeted frame i.e the write comment view
    @objc private func handleTapOutside() {
        writeCommentView.commentTextField.endEditing(true)
    }
    
}

extension VideoDetailVC : WriteCommentViewDelegate {

    func onEmojiPickerTap() {
        let emojiPickerVC = EmojiPicker.viewController
        emojiPickerVC.delegate = self
        
        let offsetX = writeCommentView.frame.width - (writeCommentView.frame.height - 12) - 45
        let offsetY = writeCommentView.frame.origin.y - 5
        
        emojiPickerVC.sourceRect = CGRect(x: offsetX, y: offsetY, width: 0, height: 0)
        emojiPickerVC.darkModeBackgroundColor = .appTabBackground
        emojiPickerVC.isDarkMode = true
        emojiPickerVC.size = CGSize(width: writeCommentView.frame.width - writeCommentView.frame.height - 10, height: 240)
        emojiPickerVC.permittedArrowDirections = .down
        
        present(emojiPickerVC, animated: true, completion: nil)
    }
    
    func onSendButtonTap() {
        let commentField = writeCommentView.commentTextField
        let commentText = commentField.text ?? ""
        commentField.text = ""
        
        comments.append(CommentModel(profileImage: UIImage(named: "pic_2")!, name: "Monkey", commentDuration: "A few second ago", comment: commentText))
        applySnapshot()
        
        let lastCommentIndexPath = IndexPath(item: comments.count - 1, section: 0)
        
        collectionView.scrollToItem(at: lastCommentIndexPath, at: .top, animated: true)
    }
}

extension VideoDetailVC : EmojiPickerViewControllerDelegate {
    
    func emojiPickerViewController(_ controller: EmojiPickerViewController, didSelect emoji: String) {
        writeCommentView.commentTextField.text?.append(emoji)
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
