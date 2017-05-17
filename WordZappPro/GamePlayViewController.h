//
//  GamePlayViewController.h
//  WordZappPro
//
//  Created by Adam Schor on 5/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamePlayViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblTestWords;
@property NSString *incomingWord;

@property NSMutableArray *wordLabels;
@property NSMutableArray *letterButtons;

@property CGFloat screenWidth;
@property CGFloat screenHeight;

@property (strong,nonatomic) NSMutableArray *arrayRandomLetters;

@end
