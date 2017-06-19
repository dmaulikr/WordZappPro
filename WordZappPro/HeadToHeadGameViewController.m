//
//  HeadToHeadGameViewController.m
//  WordZappPro
//
//  Created by Adam Schor on 5/30/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "HeadToHeadGameViewController.h"
#import "CommonGamePlayMethods.h"
#import "letterButton.h"
#import "wordLabel.h"



@interface HeadToHeadGameViewController ()

@end

@implementation HeadToHeadGameViewController

- (void)viewDidLoad {
//    CommonGamePlayMethods *methods = [[CommonGamePlayMethods alloc] init];
//    methods.view = self.view;
//    CommonGamePlayMethods *methods = [[CommonGamePlayMethods alloc]initWithView:self.view];
    _calledMethod = [[CommonGamePlayMethods alloc] initWithView:self.view];
    
//    NSArray *lights = [methods setUpLights];
//    ((UILabel *)lights[0]).backgroundColor = [UIColor blueColor];
    [self getWords];
    [self setUpLights];
    [self setUpWordLabels];
    NSLog(@"The view did load of word labels array is %@",_arrayWordLabels);
    
    [self setUpLetterButtons];
    
    
    
        
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpLights{
    NSArray *lights = [_calledMethod setUpLights];
    

}
-(void)getWords{
        _arrayRandomLetters = [[NSMutableArray alloc] init];
        
        for (int x = 0; x<9; x++) {
            NSString *eachLetter = [NSString stringWithFormat:@"%c", [_incomingLetters characterAtIndex:x]];
            [_arrayRandomLetters addObject:eachLetter];
        }
    NSLog(@"The random letters are %@",_arrayRandomLetters);
}



-(void)setUpLetterButtons {
    
    CommonGamePlayMethods *letterButtons = [[CommonGamePlayMethods alloc] initWithView:self.view];
    NSMutableArray *letters = [letterButtons setUpLetterButtons];
    for (int y =0; y<9; y++) {
        
        UIButton *currentButton = [[UIButton alloc] init];
        currentButton = letters[y];
        
        [currentButton setTitle:[_arrayRandomLetters objectAtIndex:y] forState:UIControlStateNormal];
        [currentButton addTarget:self action:@selector(wasDragged:withEvent:)forControlEvents:UIControlEventTouchDragInside];
        [currentButton addTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    
}

-(IBAction)wasDragged: (UIButton *)button withEvent: (UIEvent *)event {
    CommonGamePlayMethods *drag = [[CommonGamePlayMethods alloc]initWithView:self.view];
    [drag wasDragged:button withEvent:event];
}



-(IBAction)dragStopped:(letterButton *)sender {
    
    CommonGamePlayMethods *dragStop = [[CommonGamePlayMethods alloc] initWithView:self.view];
    [dragStop dragStopped:(letterButton *)sender];
    

    if ([self checkAllWords]) {
        NSLog(@"Check words worked");
    }
    NSLog(@"Tile in place");
    
}

-(void)setUpWordLabels{
    CommonGamePlayMethods *wordLabels = [[CommonGamePlayMethods alloc] initWithView:self.view];
    _arrayWordLabels = [wordLabels setUpWordLabels];
    
}

//-(void)checkWords {
  
//    CommonGamePlayMethods *checkWords = [[CommonGamePlayMethods alloc] initWithView:self.view];
//     return [checkWords checkAllWords];
//
    -(BOOL)checkAllWords {
        
        NSMutableArray *letters = [[NSMutableArray alloc] init];
        
        for (wordLabel *label in _arrayWordLabels) {
            if (label.linkedButton.titleLabel.text != nil) {
                [letters addObject:label.linkedButton.titleLabel.text];
                NSLog(@"here");
            } else {
                [letters addObject:@" -"];
                NSLog(@"There");
            }
        }
        NSLog(@"The word label array is %@",_arrayWordLabels);
        
        NSString *word4 = [NSString stringWithFormat:@"%@%@%@%@", letters[5], letters[6], letters[7], letters[8]];
        NSString *word3 = [NSString stringWithFormat:@"%@%@%@", letters[2], letters[3], letters[4]];
        NSString *word2 = [NSString stringWithFormat:@"%@%@", letters[0], letters[1]];
        
      //  NSLog(@"%@ (%d), %@ (%d), %@ (%d)", word2, [_masterWordList containsObject:word2], word3, [_masterWordList containsObject:word3], word4, [_masterWordList containsObject:word4]);
        
   /*    if ([_masterWordList containsObject:word4]) {
            _light4.backgroundColor = [UIColor greenColor];}
        else {
            _light4.backgroundColor = [UIColor redColor];
            
        }
        
        
        if ([_masterWordList containsObject:word3]) {
            _light3.backgroundColor = [UIColor greenColor];}
        else {
            _light3.backgroundColor = [UIColor redColor];
            
        }
        
        if ([_masterWordList containsObject:word2]) {
            _light2.backgroundColor = [UIColor greenColor];}
        else {
            _light2.backgroundColor = [UIColor redColor];
            
        }*/
        
        
        return true;
        
        return ([_masterWordList containsObject:word4] && [_masterWordList containsObject:word3] && [_masterWordList containsObject:word2]);
        
    
    

}

@end
