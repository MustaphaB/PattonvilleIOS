//
//  TableHeader.swift
//  Pattonville-School-District-App
//
//  Created by Mamadu Barrie on 1/4/17.
//  Copyright © 2017 Joshua Zahner. All rights reserved.
//

import UIKit
import iCarousel

class TableHeader: UITableViewHeaderFooterView, iCarouselDataSource, iCarouselDelegate{

    @IBOutlet var tableCarousel: iCarousel!
    var carouselWidth: CGFloat = 0
    var carouselHeight: CGFloat = 0

    
    var images : [[Any]] = []
    
    let circle = #imageLiteral(resourceName: "circle.jpg")
    let java = #imageLiteral(resourceName: "java.jpg")
    let lines = #imageLiteral(resourceName: "lines.jpg")
    let natureDear = #imageLiteral(resourceName: "nature- dear.jpg")
    let illusion = #imageLiteral(resourceName: "illusion.jpg")
    let diamond = #imageLiteral(resourceName: "diamond.jpg")
    
    override func awakeFromNib() {
    
        super.awakeFromNib()
        
        carouselWidth = UIScreen.main.bounds.size.width;
        carouselHeight = tableCarousel.bounds.size.height;
        
        images.append([circle, "Circle"])
        images.append([java, "java"])
        images.append([lines, "lines"])
        images.append([natureDear, "Deer"])
        images.append([illusion, "Illusion"])
        images.append([diamond, "Diamond"])
        
        tableCarousel.type = iCarouselType.linear
        tableCarousel.isPagingEnabled = true
        tableCarousel.reloadData()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var CarouselTimer: Timer!
        
        CarouselTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)

    }
    
    
    
    func scroll(){
        tableCarousel.scroll(byNumberOfItems: 1, duration: 2.0)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int{
        return images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView
    {
        
        var view: UIView
        var imageView: UIImageView
        var captionView: UIView
        var captionLabel: UILabel
        
        // Create new UIView the same dimensions as the carousel view
        view = UIView(frame: CGRect(x: 0, y: 0, width: carouselWidth, height: 200));
        let viewHeight = view.bounds.size.height
        
        //Create new UIImageView 30 units shorter than the main view. Set image content mode to Aspect Fill. Clip to bounds.
        imageView = UIImageView(frame: CGRect(x:0, y:0, width: carouselWidth, height: viewHeight))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        
        captionView = UIView(frame: CGRect(x: 0, y: imageView.bounds.size.height - 30, width: carouselWidth, height: 30))
        captionView.backgroundColor = .black;
        captionView.alpha = 0.5
        
        //Create new UILabel at the bottom of the view. Set textColor to black.
        captionLabel = UILabel(frame: CGRect(x: 10, y: 0, width: carouselWidth - 20 , height: 30))
        captionLabel.textColor = UIColor.white
        
        
        imageView.image = images[index][0] as? UIImage
        captionLabel.text = images[index][1] as? String
        
        //Add imageView and label to main view as subviews
        
        view.addSubview(imageView)
        imageView.addSubview(captionView)
        captionView.addSubview(captionLabel)
        
        tableCarousel.addSubview(view)
        
        //return main view as the
        return view;
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if(option == iCarouselOption.wrap){
            return 1.0
        }
        return value
        
    }



}
