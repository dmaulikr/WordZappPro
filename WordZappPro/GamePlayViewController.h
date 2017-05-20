//
//  GamePlayViewController.h
//  WordZappPro
//
//  Created by Adam Schor on 5/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>



@interface GamePlayViewController : UIViewController <MCSessionDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblTestWords;
@property NSString *incomingWord;

@property NSMutableArray *wordLabels;
@property NSMutableArray *letterButtons;

@property CGFloat screenWidth;
@property CGFloat screenHeight;

@property (strong,nonatomic) NSMutableArray *arrayRandomLetters;


@property (strong,nonatomic) NSArray *masterWordList;
@property (strong,nonatomic) NSArray *activeWordList;

@property NSMutableArray *arrayWordTwo;
@property NSMutableArray *arrayWordThree;
@property NSMutableArray *arrayWordFour;
@property (strong, nonatomic)NSMutableArray *arrayLettersInOrder;



@property (strong,nonatomic) NSString *nameMasterWordList;
@property (strong,nonatomic) NSString *nameActiveWordList;

//Lights
@property (strong,nonatomic) UILabel *light2;
@property (strong,nonatomic) UILabel *light3;
@property (strong,nonatomic) UILabel *light4;

//timer
@property NSTimer *timer;
@property int startTimerValue;
@property (strong,nonatomic) UILabel *labelTimer;

//points
@property (strong, nonatomic) UILabel *labelPoints;
@property int points;

//High Scores
@property (strong,nonatomic) NSMutableArray *arrayTopTenOne;
@property (strong,nonatomic) NSArray *sortedArrayTopTenOne;
@property (strong,nonatomic) NSMutableArray *arrayTopTenTwo;
@property (strong,nonatomic) NSArray *sortedArrayTopTenTwo;
@property (strong,nonatomic) NSMutableArray *arrayTopTenThree;

@property (strong,nonatomic) NSString *nameActiveTopTenArray;

@property (strong,nonatomic) NSArray *sortedArrayTopTenThree;



@property (strong, nonatomic) NSString *keyForHighScore;



@property (strong, nonatomic) IBOutlet UIButton *buttonAgain;

@property (strong,nonatomic) UIButton *btnBack;

@property int gameLevel;

@end
