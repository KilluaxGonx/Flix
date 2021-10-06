//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Recleph Mere on 10/6/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var movies = [[String:Any]]()
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 4

        let width = (view.frame.size.width - 2) / 2.0
        let height = width * 1.5
        layout.itemSize = CGSize(width: width, height: height)

        let url = URL(string: "https://api.themoviedb.org/3/movie/283995/recommendations?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data,
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            self.movies = dataDictionary["results"] as! [[String:Any]]
            self.collectionView.reloadData()

           }
        }
        
        task.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)!
        
        cell.posterImageView.af.setImage(withURL: posterURL)
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
