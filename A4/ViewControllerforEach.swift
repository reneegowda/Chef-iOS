//
//  ViewControllerforEach.swift
//  A4
//
//  Created by Archita Nemalikanti on 11/18/24.
//
import Foundation
import UIKit


class ViewControllerforEach: UIViewController{
    // MARK: - Properties (view)
    var recipe: Recipe?
    let i = (UIScreen.main.bounds.width/2) - (329/2)
        
    private let foodImage = UIImageView()
    private let foodTitle = UILabel()
    private let foodDescr = UILabel()
    private let bookmark = UIBarButtonItem()

    var isBookmarked = false
    
    init(recipe: Recipe?) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupPage()
        
    }
    private func setupPage(){
        
        // bookmark
        let bookmarkButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(toggleBookmark))
        navigationItem.rightBarButtonItem = bookmarkButton
        
        // image
        foodImage.sd_setImage(with: URL(string: recipe!.imageUrl))
        foodImage.layer.cornerRadius = 40
        foodImage.clipsToBounds = true
        
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(foodImage)
        
        NSLayoutConstraint.activate([
            foodImage.widthAnchor.constraint(equalToConstant: 329),
            foodImage.heightAnchor.constraint(equalToConstant: 329),
            foodImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:99),
            foodImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: i)
        ])
        
        // title
        foodTitle.text = recipe?.name
        foodTitle.textColor = UIColor.a4.black
        foodTitle.font = .systemFont(ofSize: 24, weight: .semibold)
        
        foodTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(foodTitle)
        
        NSLayoutConstraint.activate([
            foodTitle.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 32),
            foodTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //description
        foodDescr.text = recipe?.description
        foodDescr.textColor = UIColor.a4.silver
        foodDescr.font = .systemFont(ofSize: 14, weight: .semibold)
        
        foodDescr.numberOfLines = 0
        foodDescr.lineBreakMode = .byWordWrapping
        
        foodDescr.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(foodDescr)
        
        
        NSLayoutConstraint.activate([
            foodDescr.topAnchor.constraint(equalTo: foodTitle.bottomAnchor, constant: 16),
            foodDescr.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: i),
            foodDescr.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -i)
        ])
    }
    
    @objc private func PopVC(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func toggleBookmark() {
        isBookmarked.toggle()
        
        if isBookmarked {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
            //let index = bookmarks.firstIndex(of: recipe!.name)
        }
    }
}


