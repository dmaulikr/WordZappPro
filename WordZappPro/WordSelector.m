//
//  WordSelector.m
//  WordZappPro
//
//  Created by Adam Schor on 5/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "WordSelector.h"

@implementation WordSelector

+(NSString *)createWords {
    
    
    
    
    NSString *theWords;
    theWords = @"TestWords";
    return theWords;
    }

+(NSMutableArray*)createArrayOfLetters{
    NSArray *masterWordList = [[NSArray alloc] init];
    NSArray *activeWordList = [[NSArray alloc] init];
    NSString *nameMasterWordList;
    NSString *nameActiveWordList;
    
    NSMutableArray *arrayWordTwo = [[NSMutableArray alloc] init];
    NSMutableArray *arrayWordThree = [[NSMutableArray alloc] init];
    NSMutableArray *arrayWordFour = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrayRandomLetters = [[NSMutableArray alloc] init];
    NSMutableArray *arrayLettersInOrder = [[NSMutableArray alloc] init];
    
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:nameMasterWordList  ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    masterWordList = [content componentsSeparatedByString:@"\n"];
    
    path = [[NSBundle mainBundle] pathForResource:nameActiveWordList ofType:@"txt"];
    content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    activeWordList = [content componentsSeparatedByString:@"\n"];
    
    
    //  _currentList = _easyList;
    
    arrayWordTwo = [[NSMutableArray alloc] initWithObjects:@"",@"", nil];
    arrayWordThree = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", nil];
    arrayWordFour = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"", nil];
    
    
    
    
    //_arrayShortWords = [[NSMutableArray alloc] initWithObjects:@"as",@"bun",@"camp", nil];
    
    NSString *word4;
    NSString *word3;
    NSString *word2;
    
    
    
    int randomNumber1;
    int randomNumber2;
    int randomNumber3;
    
    do {randomNumber1 = arc4random_uniform(activeWordList.count);
        word4=[[activeWordList objectAtIndex:randomNumber1] uppercaseString];
        
    }
    while (word4.length != 4);//was 6 and so on
    
    
    do {randomNumber2 = arc4random_uniform(activeWordList.count);
        word3=[[activeWordList objectAtIndex:randomNumber2] uppercaseString];
        
    }
    while (word3.length != 3);
    
    
    do {randomNumber3 = arc4random_uniform(activeWordList.count);
        word2=[[activeWordList objectAtIndex:randomNumber3] uppercaseString];
    }
    while (word2.length != 2);
    
    
    NSLog(@"the words are %@ %@ %@",word2,word3,word4);
    
    //randomize the letters
    
    arrayRandomLetters = [[NSMutableArray alloc] init];
    
    for (int w = 1; w<3; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word2 characterAtIndex:w-1]];
        [arrayRandomLetters addObject:eachLetter];
        
        
    }
    
    for (int w = 1; w<4; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word3 characterAtIndex:w-1]];
        [arrayRandomLetters addObject:eachLetter];
        
        
    }
    
    for (int w = 1; w<5; w++) {
        NSString *eachLetter = [NSString stringWithFormat:@"%c", [word4 characterAtIndex:w-1]];
        [arrayRandomLetters addObject:eachLetter];
        
    }
    
    arrayLettersInOrder = [[NSMutableArray alloc] initWithArray:arrayRandomLetters];
    
    
    //randomize the letterArray
    
    
    NSUInteger countLetters;
    countLetters = arrayRandomLetters.count;
    
    
    int z;
    
    for (z=0; z<countLetters; z++) {
        u_int32_t countRemaining;
        
        countRemaining = countLetters - z;
        
        int exchangeIndex = z + arc4random_uniform(countRemaining);
        [arrayRandomLetters exchangeObjectAtIndex:z withObjectAtIndex:exchangeIndex];
        
        
    }

    
    
    
    
    return arrayRandomLetters;
    
}


@end
