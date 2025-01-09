//
//  ViewController.swift
//  A4
//
//  Created by Vin Bui on 10/31/23.
//

import Foundation
import UIKit
import SwiftUI

class ViewController: UIViewController{
    
    // MARK: - Properties (view)
    private var collectionView: UICollectionView!
    private var collectionViewMenu: UICollectionView!
        
    let screenwidth = UIScreen.main.bounds.width
    let screenheight = UIScreen.main.bounds.height
    let bound = (UIScreen.main.bounds.width - 296)/3
    
    // MARK: - Properties (data)
    private let refreshControl = UIRefreshControl()
    
    var recipes: [Recipe] = []
    var difficulties: [Difficulty] = Difficulty.diff
    var filteredRecipes: [Recipe] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "ChefOS"

        filteredRecipes = recipes
        
        setupCollectionViewRecipe()
        setupCollectionViewMenu()
        
        refreshControl.addTarget(self, action: #selector(fetchAllRecipes), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        fetchAllRecipes()
    }
    
    @objc private func fetchAllRecipes() {
        NetworkManager.shared.fetchRecipes { [weak self] fetchedRecipes in
            guard let self = self else { return }
            
            self.recipes = fetchedRecipes
            self.filteredRecipes = fetchedRecipes
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionViewMenu.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

    
    private func setupCollectionViewMenu(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionViewMenu = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewMenu.alwaysBounceHorizontal = true
        collectionViewMenu.register(CollectionViewDifficulty.self, forCellWithReuseIdentifier: CollectionViewDifficulty.reuse)
        collectionViewMenu.delegate = self
        collectionViewMenu.dataSource = self
        
        view.addSubview(collectionViewMenu)
        collectionViewMenu.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionViewMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: bound),
            collectionViewMenu.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionViewMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionViewMenu.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupCollectionViewRecipe(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.register(CollectionViewRecipeCell.self, forCellWithReuseIdentifier: CollectionViewRecipeCell.reuse)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: bound),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -bound),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 172),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func filterRecipes(by difficulty: Difficulty) {
        if  difficulty.diff == "All"{
            filteredRecipes = recipes
            collectionView.reloadData()
        }
        else{
            filteredRecipes = recipes.filter { $0.difficulty == difficulty.diff }
            collectionView.reloadData()
        }
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewMenu {
            let selectedDiff = difficulties[indexPath.row]
            filterRecipes(by: selectedDiff)
            
            for cell in collectionView.visibleCells {
                guard let difficultyCell = cell as? CollectionViewDifficulty else { continue }
                // Reset background and text color
                difficultyCell.contentView.backgroundColor = UIColor.a4.offWhite
                difficultyCell.diffi.textColor = .black
            }

            if let selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewDifficulty {
                // Highlight the selected cell
                selectedCell.contentView.backgroundColor = UIColor.a4.yellowOrange
                selectedCell.diffi.textColor = .white
            }
            
            
        } else {
            let selectedRecipe = recipes[indexPath.row]
            if let selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewRecipeCell {
                let detailVC = ViewControllerforEach(recipe: selectedRecipe)
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return collectionView == collectionViewMenu ? difficulties.count : filteredRecipes.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == collectionViewMenu {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewDifficulty.reuse, for: indexPath) as? CollectionViewDifficulty else {
                    return UICollectionViewCell()
                }
                cell.configure(with: difficulties[indexPath.row])
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewRecipeCell.reuse, for: indexPath) as? CollectionViewRecipeCell else {
                    return UICollectionViewCell()
                }
                let recipe = recipes[indexPath.row]
                cell.configure(with: filteredRecipes[indexPath.row])
                
                return cell
            }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewMenu {
            return CGSize(width: 100, height: 30) // Adjust size for horizontal menu
        } else {
            return CGSize(width: 148, height: 216) // Recipe cell size
        }
    }
}


