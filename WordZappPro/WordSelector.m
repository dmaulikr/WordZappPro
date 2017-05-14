//
//  WordSelector.m
//  WordZappPro
//
//  Created by Adam Schor on 5/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "WordSelector.h"

@implementation WordSelector

-(void)createWords {
    
    
    _masterWordList = [[NSArray alloc] init];
    _activeWordList = [[NSArray alloc] init];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:_nameMasterWordList  ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    _masterWordList = [content componentsSeparatedByString:@"\n"];
    
    path = [[NSBundle mainBundle] pathForResource:_nameActiveWordList ofType:@"txt"];
    content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    _activeWordList = [content componentsSeparatedByString:@"\n"];
    
    
    //  _currentList = _easyList;
    
    _arrayWordTwo = [[NSMutableArray alloc] initWithObjects:@"",@"", nil];
    _arrayWordThree = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
    _arrayWordFour = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"", nil];
    
    
    
    
    //_arrayShortWords = [[NSMutableArray alloc] initWithObjects:@"as",@"bun",@"camp", nil];
    
    NSString *word4;
    NSString *word3;
    NSString *word2;
    
    
    
    int randomNumber1;
    int randomNumber2;
    int randomNumber3;
    
    do {randomNumber1 = arc4random_uniform(_activeWordList.count);
        word4=[[_activeWordList objectAtIndex:randomNumber1] uppercaseString];
        
    }
    while (word4.length != 4);//was 6 and so on
    
    
    do {randomNumber2 = arc4random_uniform(_activeWordList.count);
        word3=[[_activeWordList objectAtIndex:randomNumber2] uppercaseString];
        
    }
    while (word3.length != 3);
    
    
    do {randomNumber3 = arc4random_uniform(_activeWordList.count);
        word2=[[_activeWordList objectAtIndex:randomNumber3] uppercaseString];
    }
    while (word2.length != 2);
    
    
    NSLog(@"the words are %@ %@ %@",word2,word3,word4);
    
    //randomize the letters
    
    _arrayRandomLetters = [[NSMutableArray alloc] init];
    
    for (int w = 1; w<3; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word2 characterAtIndex:w-1]];
        [_arrayRandomLetters addObject:eachLetter];
        
        
    }
    
    for (int w = 1; w<4; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word3 characterAtIndex:w-1]];
        [_arrayRandomLetters addObject:eachLetter];
        
        
    }
    
    for (int w = 1; w<5; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word4 characterAtIndex:w-1]];
        [_arrayRandomLetters addObject:eachLetter];
        
    }
    
    _arrayLettersInOrder = [[NSMutableArray alloc] initWithArray:_arrayRandomLetters];
    
    
    //randomize the letterArray
    
    
    NSUInteger countLetters;
    countLetters = _arrayRandomLetters.count;
    
    
    int z;
    
    for (z=0; z<countLetters; z++) {
        u_int32_t countRemaining;
        
        countRemaining = countLetters - z;
        
        int exchangeIndex = z + arc4random_uniform(countRemaining);
        [_arrayRandomLetters exchangeObjectAtIndex:z withObjectAtIndex:exchangeIndex];
        
        
    }
    
}



@end
