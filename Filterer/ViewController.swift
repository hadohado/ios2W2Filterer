//
//  ViewController.swift
//  Filterer
//
//  Created by ha tuong do on 1/14/17.
//  Copyright © 2017 higg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var filteredImage: UIImage?
    
    @IBOutlet weak var imageView1: UIImageView!
    
    
    @IBOutlet weak var imageToggle: UIButton!
    
    @IBAction func onImageToggle(sender: UIButton) {
        if imageToggle.selected {
            let image = UIImage(named: "sample.png")!
            imageView1.image = image
            imageToggle.selected = false
        } else {
            imageView1.image = filteredImage
            imageToggle.selected = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //--------------------------------------------
        // my Code
        //--------------------------------------------
        imageToggle.setTitle("Show Before Image", forState: .Selected)
        let image = UIImage(named: "sample.png")!
        // Process the image!
        // convert UIImage -> RGBA image
        // the ! at end of line means conditional
        // let myRGBA = RGBAImage(image: image)!
        var myRGBA = RGBAImage(image: image)!
        let x=10
        let y=10
        let index = y * myRGBA.width    +    x
        var pixel = myRGBA.pixels[index]
        pixel.red = 255
        pixel.green = 0
        pixel.blue = 0
        myRGBA.pixels[index] = pixel
        let newImage = myRGBA.toUIImage()
        
        
        let avgRed = 119
        let avgGreen = 98
        let avgBlue = 83
        
        let sum = avgRed + avgGreen + avgBlue
        //--------------------
        // red boosting filter
        //--------------------
        // var  myFilter = Filter(redFilter: 5, redIncrease: true) ;
        // myFilter.redFilter;
        
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                let redDiff = Int(pixel.red) - avgRed
                let greenDif = Int(pixel.green) - avgGreen
                let blueDif = Int(pixel.blue) - avgBlue
                var modifier = 1 + 4 * (Double(y) / Double(myRGBA.height))
                
                if (Int(pixel.red) < avgRed) {
                    modifier = 1
                }
                pixel.red = UInt8(max(min(255, Int(round(Double(avgRed) + modifier * Double(redDiff)))), 0))
                
                // pixel.red = UInt8( max(0, min(255,avgRed + redDiff ) ) )
                
                myRGBA.pixels[index] = pixel
            }
        }
        // let result = myRGBA.toUIImage()
        filteredImage = myRGBA.toUIImage()
        print("This code has run successfully !!!")
        
        // imageView1.image = result
        //--- end of code ---------------------------
    
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

