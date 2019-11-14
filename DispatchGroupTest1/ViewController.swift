//
//  ViewController.swift
//  DispatchGroupTest1
//
//  Created by Алексей Пархоменко on 11.11.2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let urlString = "http://blog.gspd.mobi/content/images/2015/06/uikit_classes.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dispatchGroup = DispatchGroup()
        
        
        dispatchGroup.enter()
        fetchImage { (_, _) in
            print("Закончили загружать изображение 1")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchImage { (image, _) in
            print("Закончили загружать изображение 2")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchImage { (_, _) in
            print("Закончили загружать изображение 3")
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { // 3 - 1 - 1 - 1 = 0
            print("Все изображение загружены")
        }
    }
    
    func fetchImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, fatalError())
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(UIImage(data: data ?? Data()), nil)
            }
        }.resume()
    }


}

