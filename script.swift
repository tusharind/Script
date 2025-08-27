//import UIKit
//class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var tableView: UITableView!
//    
//    let movies: [String: String] = [
//        "Inception": "Christopher Nolan",
//        "Interstellar": "Christopher Nolan",
//        "The Matrix": "Lana & Lilly Wachowski",
//        "Pulp Fiction": "Quentin Tarantino"
//    ]
//    
//    var selectedMovie: String?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movies.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let movieName = Array(movies.keys)[indexPath.row]
//        cell.textLabel?.text = movieName
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedMovie = Array(movies.keys)[indexPath.row]
//        performSegue(withIdentifier: "sec", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "sec",
//           let collectionVC = segue.destination as? CollectionVC,
//           let movie = selectedMovie {
//            // Pass movie name and director as a dictionary
//            collectionVC.items = [movie: movies[movie]!]
//        }
//    }
//}
//
//
//class CollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    var items: [String: String] = [:]  // movie -> director
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(UINib(nibName: "customCell1", bundle: nil),
//                                forCellWithReuseIdentifier: "customCell1")
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell1",
//                                                      for: indexPath) as! customCell1
//        
//        let movieName = Array(items.keys)[indexPath.row]
//        cell.labelA.text = movieName
//        cell.labelB.text = items[movieName]
//        
//        return cell
//    }
//}

import UIKit

// MARK: - Table View Controller
class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let movies: [String: [String]] = [
        "Inception": ["Leonardo DiCaprio", "Joseph Gordon-Levitt", "Elliot Page",
                      "Tom Hardy", "Ken Watanabe", "Cillian Murphy", "Marion Cotillard", "Michael Caine"],
        "Interstellar": ["Matthew McConaughey", "Anne Hathaway", "Jessica Chastain",
                         "Michael Caine", "Mackenzie Foy", "Casey Affleck", "Topher Grace", "David Gyasi"],
        "The Matrix": ["Keanu Reeves", "Laurence Fishburne", "Carrie-Anne Moss",
                       "Hugo Weaving", "Joe Pantoliano", "Gloria Foster", "Marcus Chong", "Belinda McClory"]
    ]
    
    var selectedMovie: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movieName = Array(movies.keys)[indexPath.row]
        cell.textLabel?.text = movieName
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = Array(movies.keys)[indexPath.row]
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "sec", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sec",
           let collectionVC = segue.destination as? CollectionVC,
           let movie = selectedMovie {
            collectionVC.items = movies[movie] ?? []
            collectionVC.title = movie
        }
    }
}

// MARK: - Collection View Controller
class CollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var items: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "customCell2", bundle: nil),
                                forCellWithReuseIdentifier: "customCell2")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell2",
                                                      for: indexPath) as! customCell2
        cell.label1.text = items[indexPath.row]
        return cell
    }

//    // MARK: - 3 cells per row layout
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding: CGFloat = 10
//        let totalSpacing = padding * 2 + (padding * 2) // left + right + between cells
//        let width = (collectionView.frame.width - totalSpacing) / 3
//        return CGSize(width: width, height: 50)
//    }
    
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let numberOfCellsPerRow: CGFloat = 4
//        let padding: CGFloat = 10            // spacing between cells
//        let totalSpacing = padding * (numberOfCellsPerRow + 1) // left + right + spaces between cells
//        
//        let width = (collectionView.frame.width - totalSpacing) / numberOfCellsPerRow
//        return CGSize(width: width, height: 50)  // height can be whatever you like
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsPerRow: CGFloat = 4
        let padding: CGFloat = 10   // spacing between cells and section edges
        
        // total horizontal padding = left + right + spacing between cells
        let totalPadding = padding * (cellsPerRow + 1)
        let availableWidth = collectionView.frame.width - totalPadding
        let cellWidth = availableWidth / cellsPerRow
        
        return CGSize(width: cellWidth, height: 50) // adjust height as needed
    }

    // 2️⃣ Minimum line spacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    // 3️⃣ Minimum inter-item spacing
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }

