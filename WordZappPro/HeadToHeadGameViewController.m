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
    CommonGamePlayMethods *methods = [[CommonGamePlayMethods alloc]initWithView:self.view];
    NSArray *lights = [methods setUpLights];
    ((UILabel *)lights[0]).backgroundColor = [UIColor blueColor];
   
    [self setUpLetterButtons];
    [self setUpWordLabels];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getWords{
    
    _activeWordList = [CommonGamePlayMethods setUpWordLists ];
    
    NSLog(@"The word list is %@",_activeWordList);
    
    
}

-(void)setUpLetterButtons {
    NSMutableArray *testLettersArray = [[NSMutableArray alloc] initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",nil];
    
    CommonGamePlayMethods *letterButtons = [[CommonGamePlayMethods alloc] initWithView:self.view];
    NSMutableArray *letters = [letterButtons setUpLetterButtons];
    for (int y =0; y<9; y++) {
        
        UIButton *currentButton = [[UIButton alloc] init];
        currentButton = letters[y];
        
       [currentButton setTitle:[testLettersArray objectAtIndex:y] forState:UIControlStateNormal];
        [currentButton addTarget:self action:@selector(wasDragged:withEvent:)forControlEvents:UIControlEventTouchDragInside];
        [currentButton addTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    
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

-(float)distanceBetween:(CGRect )rect and: (CGRect ) rect2 {
    
    float deltaX = (rect.origin.x + rect.size.width/2) - (rect2.origin.x + rect.size.width/2);
    float deltaY = (rect.origin.y + rect.size.height/2) - (rect2.origin.y + rect.size.height/2);
    
    float deltaP = sqrtf(deltaX*deltaX + deltaY*deltaY);
    
    
    return fabsf(deltaP);
}


-(IBAction)dragStopped:(letterButton *)sender {
    
    CGFloat tolerance = sender.frame.size.width/1.5;
    
    
    sender.linkedLabel.linkedButton = nil;
    sender.linkedLabel = nil;
    
    for (wordLabel *label in _arrayWordLabels) {
        if ([self distanceBetween:sender.frame and:label.frame] < tolerance) {
            if (label.linkedButton == nil) {
                sender.frame = label.frame;
                sender.linkedLabel = label;
                label.linkedButton = sender;
            }
        }
    }
//    if ([self checkWords]) {
//        [_timer invalidate];
//        [self stopButtons];
//        
//        
//        
//        if (_startTimerValue>0) {
//            _points = _points + 60 +_startTimerValue;
//            _startTimerValue = _startTimerValue + 30;
//            _labelPoints.text = [NSString stringWithFormat:@"%i",_points];
//            _buttonAgain.enabled = YES;
//            _buttonAgain.alpha = 1;
//            
//            [self winSplash];
//            
//        }
//    }
    
    NSLog(@"Tile in place");
    
}

-(void)setUpWordLabels{
    CommonGamePlayMethods *wordLabels = [[CommonGamePlayMethods alloc] initWithView:self.view];
    _arrayWordLabels = [wordLabels setUpWordLabels];
    
    
}
@end
