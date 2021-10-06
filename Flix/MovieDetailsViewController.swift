//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Recleph Mere on 10/5/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movie: [String:Any]!
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieTitle.text = movie["title"] as? String
        movieDescription.text = movie["overview"] as? String
        
        releaseDate.text = movie["release_date"] as? String
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)!
        
        posterView.af.setImage(withURL: posterURL)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        
        backdropView.af.setImage(withURL: backdropURL)
        
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
