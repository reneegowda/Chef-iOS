//
//  CollectionViewDifficulty.swift
//  A4
//
//  Created by Archita Nemalikanti on 11/20/24.
//

import UIKit

public class CollectionViewDifficulty: UICollectionViewCell{
    // MARK: - Properties
    let diffi = UILabel()
    
    // MARK: - Properties (data)
    static let reuse = "UICollectionViewDifficultyReuse"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDiffi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with difficulty: Difficulty){
        diffi.text = difficulty.diff
    }
    
    private func setupDiffi(){
        diffi.textColor = UIColor.a4.black
        diffi.font = .systemFont(ofSize: 12, weight: .semibold)
        diffi.textAlignment = .center
        
        contentView.backgroundColor = UIColor.a4.offWhite
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        diffi.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(diffi)
        
        NSLayoutConstraint.activate([
            diffi.widthAnchor.constraint(equalToConstant: 412),
            diffi.heightAnchor.constraint(equalToConstant: 30),
            diffi.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            diffi.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
    }
}
