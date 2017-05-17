//
//  GamePlayViewController.m
//  WordZappPro
//
//  Created by Adam Schor on 5/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "GamePlayViewController.h"
#import "WordSelector.h"
#import "letterButton.h"
#import "wordLabel.h"


@interface GamePlayViewController ()

@end

@implementation GamePlayViewController

- (void)viewDidLoad {
    
 
    _lblTestWords.text = _incomingWord;
    NSLog(@"The incoming words are %@",_incomingWord);
    
    [self setUpLetterButtons];
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpLetterButtons{
    
    letterButton *letter;
    _letterButtons = [[NSMutableArray alloc] init];
    
    
    CGFloat boxWidth = _screenWidth/8;
    CGFloat boxHeight = boxWidth;
    CGFloat xPositionFactorRow1 = 5;
    CGFloat xPositionFactorRow2 = 5;
    CGFloat paddingTop = 0;
    
    for (int y = 0; y < 9; y++) {
        letter = [[letterButton alloc] init];
        
        if (y < 4) {
            letter.frame = CGRectMake(10 + boxWidth + _screenWidth/xPositionFactorRow1   * y, _screenHeight*.7 + paddingTop, boxWidth, boxHeight);
        }
        
        else if (y < 9) {
            letter.frame = CGRectMake(20 + _screenWidth/xPositionFactorRow2 * (y-4), _screenHeight*.8 + paddingTop, boxWidth, boxHeight);
        }
        
        [letter setBackgroundImage:[UIImage imageNamed:@"tile.png"] forState:UIControlStateNormal];
        [letter setTitle:[_arrayRandomLetters objectAtIndex:y] forState:UIControlStateNormal];
        letter.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:boxWidth*.9];
        [letter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    //    [letter addTarget:self action:@selector(wasDragged:withEvent:)forControlEvents:UIControlEventTouchDragInside];
     //   [letter addTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventTouchUpInside];
        [_letterButtons addObject:letter];
        [self.view addSubview:letter];
    }
    
    
    
}

@end
