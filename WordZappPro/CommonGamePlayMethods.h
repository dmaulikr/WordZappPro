//
//  CommonGamePlayMethods.h
//  WordZappPro
//
//  Created by Adam Schor on 6/2/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "letterButton.h"



@interface CommonGamePlayMethods : NSObject

@property UIView *view;


@property CGFloat screenWidth;
@property CGFloat screenHeight;

-(NSArray *)setUpLights;
+(NSArray *)setUpWordLists;
-(NSMutableArray *)setUpLetterButtons;
-(NSMutableArray *)setUpWordLabels;

-(IBAction)wasDragged: (UIButton *)button withEvent: (UIEvent *)event;
-(IBAction)dragStopped:(letterButton *)sender;

-(BOOL)checkAllWords;




-(CommonGamePlayMethods *)initWithView:(UIView *) view;

@property (strong,nonatomic) UILabel *light2;
@property (strong,nonatomic) UILabel *light3;
@property (strong,nonatomic) UILabel *light4;

@property (strong,nonatomic) NSMutableArray *arrayWordLabels;


@property (strong,nonatomic) NSArray *masterWordList;
@property (strong,nonatomic) NSArray *activeWordList;
@property (strong,nonatomic) NSString *nameMasterWordList;
@property (strong,nonatomic) NSString *nameActiveWordList;


@end
