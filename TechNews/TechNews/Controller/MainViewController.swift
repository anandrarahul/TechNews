//
//  MainViewController.swift
//  TechNews
//
//  Created by Rahul Anand on 08/05/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak private var newsCollectionView: UICollectionView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var errorLabel: UILabel!
    @IBOutlet weak private var refreshButton: UIButton!
    
    private let dispatchGroup = DispatchGroup()
    private let decoder = JSONDecoder()
    private var url: URL?
    private let restApi = RestApi()
    fileprivate var articles: [Articles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Tech News"
        self.errorLabel.isHidden = true
        self.refreshButton.isHidden = true
        self.newsCollectionView.dataSource = self
        self.newsCollectionView.delegate = self
        self.activityIndicator.startAnimating()
        url = self.restApi.getUrlForNews()
        self.fetchNewsArticles()
        dispatchGroup.notify(queue: .main) {
            self.newsCollectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction private func refreshButtonClicked(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()
        self.errorLabel.isHidden = true
        self.refreshButton.isHidden = true
        url = self.restApi.getUrlForNews()
        self.fetchNewsArticles()
        dispatchGroup.notify(queue: .main) {
            self.newsCollectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    private func fetchNewsArticles() {
        dispatchGroup.enter()
        guard let newsUrl = url else { return }
        URLSession.shared.dataTask(with: newsUrl) {(data, response, error) in
            guard let data = data else { return }
            do {
                let newsData = try self.decoder.decode(Result.self, from: data)
                if let responseJson = newsData.articles {
                    self.articles = responseJson
                }
            } catch _ {
                DispatchQueue.main.async {
                    self.errorLabel.text = "Error occured during Network call"
                    self.errorLabel.isHidden = false
                    self.refreshButton.isHidden = false
                }
            }
            self.dispatchGroup.leave()
        }.resume()
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCollectionViewCell
        cell.updateCell(self.articles[indexPath.row].urlToImage, self.articles[indexPath.row].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.newsCollectionView.frame.width - 20, height: self.newsCollectionView.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailVC") as! DetailsViewController
        detailsViewController.dataSource = DetailViewControllerDataSource(articles: self.articles[indexPath.row])
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

