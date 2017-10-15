//
//  RatingControl.swift
//  FoodTracker
//
//  Created by 生活酷 on 2017/9/4.
//  Copyright © 2017年 生活酷. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    //Mark:properties
    private var ratingButtons = [UIButton]();
    
    
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0);
    
    
    
    @IBInspectable var starCount: Int = 5;

    
    
    var ratingStarts = 0;
    
    
    
    
    
    
    //Mark:initiallization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    
    //Mark: private function
    private func setupButton() {
        
        
        for button in ratingButtons {
            removeArrangedSubview(button);
            button.removeFromSuperview();
            
        }
        
        ratingButtons.removeAll();
        
        
        let bundle = Bundle(for: type(of: self));
        let fillStar = UIImage(named:"fillStar", in: bundle, compatibleWith:self.traitCollection);
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith:self.traitCollection);
        let hightlightStar = UIImage(named:"highlightStar", in: bundle, compatibleWith:self.traitCollection);
        
        
        
        for index in 0..<starCount {
            
            // Create the button
            let button = UIButton();
            
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(fillStar, for: .selected)
            button.setImage(hightlightStar, for: .highlighted)
            button.setImage(hightlightStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.accessibilityLabel = "Set \(index + 1) star rating";
            
            
            //button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside);
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            ratingButtons.append(button);
         
            

        }
            updateButtonSelectionStates();
    }
    

    
    //Mark: action
    
    func ratingButtonTapped(button : UIButton) {
        
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        };
        

        let selectedRating = index + 1;
        
        if selectedRating == ratingStarts {
            // If the selected star represents the current rating, reset the rating to 0.
            ratingStarts = 0
        } else {
            // Otherwise set the rating to the selected star
            ratingStarts = selectedRating
        }
        
        
        updateButtonSelectionStates();
        
    }
    
    
    
    
    
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < ratingStarts;
            
            
            let hinString:String?
            if ratingStarts == index + 1 {
                hinString = "Tap to reset to 0"
            } else {
                hinString = nil;
            }
            
            let valueString: String
            switch(ratingStarts) {
                case 0:
                    valueString = "No rating set."
                case 1:
                    valueString = "1 star set."
                default:
                    valueString = "\(ratingStarts) stars set."
            }
            
            button.accessibilityHint = hinString;
            button.accessibilityValue = valueString;
            
        }
    }
    
    
    
    
    

}
