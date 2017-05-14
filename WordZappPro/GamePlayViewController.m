//
//  GamePlayViewController.m
//  WordZappPro
//
//  Created by Adam Schor on 5/14/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "GamePlayViewController.h"
#import "WordSelector.h"

@interface GamePlayViewController ()

@end

@implementation GamePlayViewController

- (void)viewDidLoad {
    
   // _incomingWord = @"Hello Local";
    _lblTestWords.text = _incomingWord;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)chooseWord {
    
    
}


@end
