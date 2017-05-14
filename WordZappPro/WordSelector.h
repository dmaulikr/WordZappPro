//
//  WordSelector.h
//  WordZappPro
//
//  Created by Adam Schor on 5/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordSelector : NSObject

@property (strong,nonatomic) NSArray *masterWordList;
@property (strong,nonatomic) NSArray *activeWordList;

@property NSMutableArray *arrayWordTwo;
@property NSMutableArray *arrayWordThree;
@property NSMutableArray *arrayWordFour;
@property (strong,nonatomic) NSMutableArray *arrayRandomLetters;
@property (strong, nonatomic)NSMutableArray *arrayLettersInOrder;

@property (strong,nonatomic) NSString *nameMasterWordList;
@property (strong,nonatomic) NSString *nameActiveWordList;
@end
