//
//  CollectionViewRecipe.swift
//  A4
//
//  Created by Archita Nemalikanti on 12/3/24.
//

import UIKit
import SDWebImage

public class CollectionViewRecipeCell: UICollectionViewCell{
    // MARK: - Properties (view)
    private let foodImage = UIImageView()
    private let foodTitle = UILabel()
    private let foodRankingDifficulty = UILabel()
    private let bookmark = UIImageView()
    
    var marked: Bool = true
        
    // MARK: - Properties (data)
    static let reuse = "UICollectionViewRecipeReuse"
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFoodImage()
        setupFoodTitle()
        setupFoodRankingDifficulty()
        setupBookmark()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
    
    // MARK: - Configure
    func configure(with recipe: Recipe){
        foodImage.sd_setImage(with: URL(string: recipe.imageUrl))
        foodTitle.text = recipe.name
        foodRankingDifficulty.text = String(recipe.rating) + " ∙ " + recipe.difficulty
    }
    
    // MARK: - Setup Views
    private func setupFoodImage(){
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.layer.cornerRadius = 16 
        foodImage.clipsToBounds = true
        contentView.addSubview(foodImage)

        
        NSLayoutConstraint.activate([
            foodImage.widthAnchor.constraint(equalToConstant: 148),
            foodImage.heightAnchor.constraint(equalToConstant: 148),
            foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setupFoodTitle(){
        foodTitle.textColor = UIColor.a4.black
        foodTitle.font = .systemFont(ofSize: 16, weight: .semibold)
        foodTitle.numberOfLines = 2
        foodTitle.lineBreakMode = .byWordWrapping
        
        foodTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(foodTitle)
        
        NSLayoutConstraint.activate([
            foodTitle.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 4),
            foodTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            foodTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ])
    }
    
    private func setupFoodRankingDifficulty(){
        foodRankingDifficulty.textColor = UIColor.a4.silver
        foodRankingDifficulty.font = .systemFont(ofSize: 12, weight: .semibold)
        
        foodRankingDifficulty.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(foodRankingDifficulty)
        
        NSLayoutConstraint.activate([
            foodRankingDifficulty.topAnchor.constraint(equalTo: foodTitle.bottomAnchor, constant: 4),
            foodRankingDifficulty.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }
    
    private func setupBookmark(){
        if (marked){
            bookmark.image = UIImage(named: "Bookmark")
            
            bookmark.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(bookmark)
            
            NSLayoutConstraint.activate([
                bookmark.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 4),
                bookmark.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 4),
                bookmark.widthAnchor.constraint(equalToConstant: 20),
                bookmark.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
    }
}
