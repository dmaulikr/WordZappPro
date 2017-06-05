//
//  CommonGamePlayMethods.m
//  WordZappPro
//
//  Created by Adam Schor on 6/2/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "CommonGamePlayMethods.h"
#import "letterButton.h"
#import "wordLabel.h";



@implementation CommonGamePlayMethods


-(CommonGamePlayMethods *)initWithView:(UIView *) view {
    self.view = view;
    self.screenWidth = view.frame.size.width;
    self.screenHeight = view.frame.size.height;
    
    return self;
}

+(NSArray *)setUpWordLists {
    NSString *nameMasterWordList;
    NSString *nameActiveWordList;
    NSString *contents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:nameMasterWordList ofType:@"txt"] encoding:NSASCIIStringEncoding error:NULL];
    NSArray *masterWordList = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    contents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:nameActiveWordList ofType:@"txt"] encoding:NSASCIIStringEncoding error:NULL];
//    _activeWordList = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
   // return _activeWordList;
    return  [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
}

-(NSArray *)setUpLights {
    
    
    NSLog(@"setting up lights...");
  //  CGFloat screenWidth = _view.frame.size.width;
    CGFloat screenHeight = _view.frame.size.height;
    CGFloat boxWidth = _screenWidth/10;
    CGFloat boxHeight = boxWidth;
   // CGFloat xPositionFactor = 5;
    CGFloat paddingTop = 0;

    
    
    _light2 = [[UILabel alloc]init];
    _light2.frame = CGRectMake(0, screenHeight*.45 + paddingTop, boxWidth, boxHeight);
    _light2.layer.cornerRadius = boxHeight/2;
    _light2.clipsToBounds = YES;
    _light2.backgroundColor = [UIColor redColor];
     [_view addSubview:_light2];
    
    _light3 = [[UILabel alloc]init];
    _light3.frame = CGRectMake(0, screenHeight*.3 + paddingTop, boxWidth, boxHeight);
    _light3.layer.cornerRadius = boxHeight/2;
    _light3.clipsToBounds = YES;
    _light3.backgroundColor = [UIColor redColor];
     [_view addSubview:_light3];
    
    _light4 = [[UILabel alloc]init];
    _light4.frame = CGRectMake(0, screenHeight*.15 + paddingTop, boxWidth, boxHeight);
    _light4.layer.cornerRadius = boxHeight/2;
    _light4.clipsToBounds = YES;
    _light4.backgroundColor = [UIColor redColor];
     [_view addSubview:_light4];
    
    
    return [NSArray arrayWithObjects:_light2, _light3, _light4, nil];
}

-(NSMutableArray *)setUpLetterButtons{
    
    letterButton *letter;
    NSMutableArray *letterButtons = [[NSMutableArray alloc] init];
    
    
   
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
      //  [letter setTitle:[_arrayRandomLetters objectAtIndex:y] forState:UIControlStateNormal];
        letter.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:boxWidth*.9];
        [letter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
       [letter addTarget:self action:@selector(wasDragged:withEvent:)forControlEvents:UIControlEventTouchDragInside];
        
      //  [letter addTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventTouchUpInside];
        [letterButtons addObject:letter];
        [self.view addSubview:letter];
    }
    return letterButtons;
}

-(IBAction)wasDragged: (UIButton *)button withEvent: (UIEvent *)event {
    UITouch *touch = [[event touchesForView:button]anyObject];
    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat deltaX = location.x - previousLocation.x;
    CGFloat deltaY = location.y - previousLocation.y;
    button.center = CGPointMake(button.center.x + deltaX, button.center.y + deltaY);
    [self.view bringSubviewToFront:button];
}

-(NSMutableArray *)setUpWordLabels {
    NSMutableArray *arrayWordLabels = [[NSMutableArray alloc] init];
    wordLabel *word =[[wordLabel alloc] init];
    CGFloat boxWidth = _screenWidth/8;
    CGFloat boxHeight = boxWidth;
    CGFloat xPositionFactor = 5;
    CGFloat paddingTop = 0;
    
    for (int x = 0; x<9; x++) {
        
        
        if (x<2) {
            
            word = [[wordLabel alloc] initWithFrame:CGRectMake(_screenWidth/xPositionFactor * (x+1), _screenHeight*.45 + paddingTop, boxWidth, boxHeight)];
        }
        
        else if (x <5){
            word = [[wordLabel alloc] initWithFrame:CGRectMake(_screenWidth/xPositionFactor * (x+1-2), _screenHeight*.3 + paddingTop, boxWidth, boxHeight)];
            
        }
        
        else if (x <9){
            word = [[wordLabel alloc] initWithFrame:CGRectMake(_screenWidth/xPositionFactor * (x+1-5), _screenHeight*.15 + paddingTop, boxWidth, boxHeight)];
            
        }
        
        word.layer.borderColor = [[UIColor blackColor] CGColor];
        word.layer.borderWidth = 2;
        
        word.backgroundColor = [UIColor whiteColor];
        
        [arrayWordLabels addObject:word];
        [self.view addSubview:word];
        
        
    }
    return arrayWordLabels;
}





@end
