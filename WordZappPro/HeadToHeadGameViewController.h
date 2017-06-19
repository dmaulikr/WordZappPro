//
//  HeadToHeadGameViewController.h
//  WordZappPro
//
//  Created by Adam Schor on 5/30/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonGamePlayMethods.h"


@interface HeadToHeadGameViewController : UIViewController

@property (strong,nonatomic) NSArray *activeWordList;

@property (strong,nonatomic)NSMutableArray *arrayWordLabels;
@property (strong,nonatomic)NSMutableArray *arrayRandomLetters;


@property (strong, nonatomic)NSString *nameMasterWordList;
@property (strong, nonatomic)NSMutableArray *masterWordList;
@property (strong, nonatomic)NSString *incomingLetters;
@property CommonGamePlayMethods *calledMethod;


@end
