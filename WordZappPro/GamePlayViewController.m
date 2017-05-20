//
//  GamePlayViewController.m
//  WordGame 2.0
//
//  Created by Adam Schor on 11/24/15.
//  Copyright © 2015 AandA Development. All rights reserved.
//

#import "GamePlayViewController.h"
#import "letterButton.h"
#import "wordLabel.h"
#import "DefaultsDataManager.h"
#import "WordSelector.h"
#import "AppDelegate.h"



@interface GamePlayViewController ()

@end

@implementation GamePlayViewController


- (void)goBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
    
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    
    //BEGIN NEW CODE
    if (_incomingWord !=NULL){
        _lblTestWords.text = _incomingWord;
        NSLog(@"The incoming words are %@",_incomingWord);
        
        _arrayRandomLetters = [[NSMutableArray alloc] init];
        
        for (int x = 0; x<9; x++) {
            NSString *eachLetter = [NSString stringWithFormat:@"%c", [_incomingWord characterAtIndex:x]];
            [_arrayRandomLetters addObject:eachLetter];
        }
    } else {
        _arrayRandomLetters = [[NSMutableArray alloc] initWithArray:[WordSelector createArrayOfLetters]];
    }
    //END NEW CODE
    
    _screenWidth  = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    _buttonAgain = [[UIButton alloc] init];
    [_buttonAgain setTitle:@"Again" forState:UIControlStateNormal];
    [_buttonAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _buttonAgain.backgroundColor = [UIColor blackColor];
    _buttonAgain.frame = CGRectMake(0, _screenHeight - 60, _screenWidth, 60);
    [_buttonAgain addTarget:self action:@selector(restart:) forControlEvents:UIControlEventAllEvents];
    
    [self.view addSubview:_buttonAgain];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.63 green:1.00 blue:0.60 alpha:1.0];
    
    
    
    
    UIButton *back = [[UIButton alloc] init];
    [back addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    back.frame = CGRectMake(_screenWidth / 2 - 45, 0, 90, 30);
    [back setTitle:@"Back" forState:UIControlStateNormal];
    back.layer.cornerRadius = 15;
    back.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    back.layer.borderColor = [[UIColor blackColor] CGColor];
    back.layer.borderWidth = 2;
    
    back.backgroundColor = [UIColor clearColor];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:back];
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    //load variables
    
    
    
    
    
    _startTimerValue = 60;
    
    _buttonAgain.enabled = NO;
    _buttonAgain.alpha = 0;
    
    
    _points = 0;
    switch (_gameLevel) {
        case 0:
            _keyForHighScore = @"keyForHighScoreOne";
            _nameActiveTopTenArray = @"arrayTopTenOne";
            break;
        case 1:
            _keyForHighScore = @"keyForHighScoreTwo";
            _nameActiveTopTenArray = @"arrayTopTenTwo";
            break;
        case 2:
            _keyForHighScore = @"keyForHighScoreThree";
            _nameActiveTopTenArray = @"arrayTopTenThree";
            break;
        default:
            break;
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (_gameLevel) {
        case 0:
            _nameActiveWordList =@"easyList";
            break;
        case 1:
            _nameActiveWordList =@"mediumList";
            break;
        case 2:
            _nameActiveWordList =@"hardList";
            break;
        default:
            break;
    }
    
    _nameMasterWordList = @"hardList";
    
    [self setUpWordLists];
    [self setUpWordLabels];
    [self setUpLetterButtons];
    [self setUpTimerLabel];
    [self setUpPointsLabel];
    [self setUpHighScore];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCountDown) userInfo:nil repeats:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [self saveHighscore];
}




#pragma mark SET UP WORD LISTS
-(void)setUpWordLists {
    NSString *contents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_nameMasterWordList ofType:@"txt"] encoding:NSASCIIStringEncoding error:NULL];
    _masterWordList = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    contents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_nameActiveWordList ofType:@"txt"] encoding:NSASCIIStringEncoding error:NULL];
    _activeWordList = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    
}


#pragma mark POSITION LETTERS, WORDS and OTHER LABELS

-(void)setUpWordLabels {
    _wordLabels = [[NSMutableArray alloc] init];
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
        
        [_wordLabels addObject:word];
        [self.view addSubview:word];
        
        
    }
    
    
    //set up lights
    
    _light2 = [[UILabel alloc]init];
    _light2.frame = CGRectMake(0, _screenHeight*.45 + paddingTop, boxWidth, boxHeight);
    _light2.layer.cornerRadius = boxHeight/2;
    _light2.clipsToBounds = YES;
    _light2.backgroundColor = [UIColor redColor];
    [self.view addSubview:_light2];
    
    _light3 = [[UILabel alloc]init];
    _light3.frame = CGRectMake(0, _screenHeight*.3 + paddingTop, boxWidth, boxHeight);
    _light3.layer.cornerRadius = boxHeight/2;
    _light3.clipsToBounds = YES;
    _light3.backgroundColor = [UIColor redColor];
    [self.view addSubview:_light3];
    
    _light4 = [[UILabel alloc]init];
    _light4.frame = CGRectMake(0, _screenHeight*.15 + paddingTop, boxWidth, boxHeight);
    _light4.layer.cornerRadius = boxHeight/2;
    _light4.clipsToBounds = YES;
    _light4.backgroundColor = [UIColor redColor];
    [self.view addSubview:_light4];
    
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
        
        [letter addTarget:self action:@selector(wasDragged:withEvent:)forControlEvents:UIControlEventTouchDragInside];
        [letter addTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventTouchUpInside];
        [_letterButtons addObject:letter];
        [self.view addSubview:letter];
    }
    
    
    
}

-(void)setUpTimerLabel {
    CGFloat paddingTop = 0;
    
    _labelTimer = [[UILabel alloc] initWithFrame:CGRectMake(0, _screenHeight*.05 + paddingTop, _screenWidth/3, _screenHeight/15)];
    _labelTimer.backgroundColor = [UIColor clearColor];
    _labelTimer.textColor = [UIColor blackColor];
    _labelTimer.text = [NSString stringWithFormat:@"%i",_startTimerValue];
    _labelTimer.layer.borderWidth = 2;
    _labelTimer.layer.borderColor = [[UIColor blackColor] CGColor];
    _labelTimer.font = [UIFont fontWithName:@"Helvetica" size:_screenHeight/10*.6];
    _labelTimer.textAlignment = NSTextAlignmentCenter;
    _labelTimer.layer.cornerRadius = _screenHeight/15/2;
    
    _labelTimer.backgroundColor = [UIColor whiteColor];
    _labelTimer.clipsToBounds = YES;
    
    
    
    NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
    componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
    componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDefault;
    
    NSTimeInterval interval = _startTimerValue;
    NSString *formattedString = [componentFormatter stringFromTimeInterval:interval];
    
    _labelTimer.text = formattedString;
    
    
    [self.view addSubview:_labelTimer];
    
}

-(void)setUpPointsLabel {
    CGFloat paddingTop = 0;
    
    _labelPoints = [[UILabel alloc] initWithFrame:CGRectMake(_screenWidth-_screenWidth/3, _screenHeight * .05 + paddingTop, _screenWidth/3, _screenHeight/15)];
    _labelPoints.backgroundColor = [UIColor clearColor];
    _labelPoints.textColor = [UIColor redColor];
    _labelPoints.layer.borderColor = [[UIColor blackColor] CGColor];
    _labelPoints.layer.borderWidth = 2;
    _labelPoints.font = [UIFont fontWithName:@"Helvetica" size:_screenHeight/10 * .6];
    _labelPoints.textAlignment = NSTextAlignmentCenter;
    _labelPoints.layer.cornerRadius = _screenHeight/15/2;
    
    _labelPoints.text = [NSString stringWithFormat:@"%i",_points];
    
    _labelPoints.backgroundColor = [UIColor whiteColor];
    _labelPoints.clipsToBounds = YES;
    
    [self.view addSubview:_labelPoints];
    
    
}

#pragma mark HIGH SCORE

-(void)setUpHighScore {
    
    _arrayTopTenOne = [[NSMutableArray alloc] initWithArray:[DefaultsDataManager getDataForKey:_keyForHighScore]];
    
    
    
}
#pragma mark WORD REVEAL

-(void)revealWord {
    
    
    
    for (letterButton *button in _letterButtons) {
        [button removeFromSuperview];
    }
    
    for (int i = 0; i<_arrayLettersInOrder.count; i++) {
        wordLabel *label = ((wordLabel *)_wordLabels[i]);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Helvetica" size:0.8*(_screenWidth/8)];
        label.textColor = [UIColor blackColor];
        //label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tile.png"]];
        _light2.backgroundColor= [UIColor greenColor];
        _light3.backgroundColor = [UIColor greenColor];
        _light4.backgroundColor = [UIColor greenColor];
        
        label.text = _arrayLettersInOrder[i];
    }
    _buttonAgain.enabled = YES;
    _buttonAgain.alpha = 1;
    
}

#pragma mark DRAG AND CHECK WORD CODES HERE


-(float)distanceBetween:(CGRect )rect and: (CGRect ) rect2 {
    
    float deltaX = (rect.origin.x + rect.size.width/2) - (rect2.origin.x + rect.size.width/2);
    float deltaY = (rect.origin.y + rect.size.height/2) - (rect2.origin.y + rect.size.height/2);
    
    float deltaP = sqrtf(deltaX*deltaX + deltaY*deltaY);
    
    
    return fabsf(deltaP);
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


-(IBAction)dragStopped:(letterButton *)sender {
    
    CGFloat tolerance = sender.frame.size.width/1.5;
    
    
    sender.linkedLabel.linkedButton = nil;
    sender.linkedLabel = nil;
    
    for (wordLabel *label in _wordLabels) {
        if ([self distanceBetween:sender.frame and:label.frame] < tolerance) {
            if (label.linkedButton == nil) {
                sender.frame = label.frame;
                sender.linkedLabel = label;
                label.linkedButton = sender;
            }
        }
    }
    if ([self checkWords]) {
        [_timer invalidate];
        [self stopButtons];
        
        
        
        if (_startTimerValue>0) {
            _points = _points + 60 +_startTimerValue;
            _startTimerValue = _startTimerValue + 30;
            _labelPoints.text = [NSString stringWithFormat:@"%i",_points];
            _buttonAgain.enabled = YES;
            _buttonAgain.alpha = 1;
            
            [self winSplash];
            
        }
    }
    
    
}

-(BOOL) checkWords {

    NSMutableArray *letters = [[NSMutableArray alloc] init];
    
    for (wordLabel *label in _wordLabels) {
        if (label.linkedButton.titleLabel.text != nil) {
            [letters addObject:label.linkedButton.titleLabel.text];
        } else {
            [letters addObject:@" -"];
        }
    }
    
    NSString *word4 = [NSString stringWithFormat:@"%@%@%@%@", letters[5], letters[6], letters[7], letters[8]];
    NSString *word3 = [NSString stringWithFormat:@"%@%@%@", letters[2], letters[3], letters[4]];
    NSString *word2 = [NSString stringWithFormat:@"%@%@", letters[0], letters[1]];
    NSLog(@"%@ (%d), %@ (%d), %@ (%d)", word2, [_masterWordList containsObject:word2], word3, [_masterWordList containsObject:word3], word4, [_masterWordList containsObject:word4]);
    
    if ([_masterWordList containsObject:word4]) {
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
        
    }
    
    
    return ([_masterWordList containsObject:word4] && [_masterWordList containsObject:word3] && [_masterWordList containsObject:word2]);
    
}

#pragma mark TIMER OPERATIONS

-(void)timerCountDown{
    
    _startTimerValue = _startTimerValue - 1;
    _labelTimer.text = [NSString stringWithFormat:@"%i",_startTimerValue];
    
    NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
    componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
    componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDefault;
    
    NSTimeInterval interval = _startTimerValue;
    NSString *formattedString = [componentFormatter stringFromTimeInterval:interval];
    
    _labelTimer.text = formattedString;
    
    
    
    if (_startTimerValue <11) {
        _labelTimer.backgroundColor = [UIColor redColor];
        _labelTimer.textColor = [UIColor yellowColor];
        _labelTimer.clipsToBounds = YES;
    }
    else {_labelTimer.backgroundColor = [UIColor whiteColor];
        _labelTimer.textColor = [UIColor blackColor];
    }
    
    if (_startTimerValue == 0) {
        UILabel *labelGameOver = [[UILabel alloc] init];
        labelGameOver.frame = CGRectMake(20, _screenHeight * .15, _screenWidth - 40, _screenHeight*.37);
        labelGameOver.layer.borderColor = [[UIColor redColor] CGColor];
        labelGameOver.layer.borderWidth = 2;
        labelGameOver.backgroundColor = [UIColor yellowColor];
        labelGameOver.textColor = [UIColor redColor];
        labelGameOver.layer.cornerRadius = 15;
        labelGameOver.clipsToBounds = YES;
        labelGameOver.text = @"Game Over";
        labelGameOver.font = [UIFont fontWithName:@"Courier" size:_screenHeight*.4*.2];
        labelGameOver.textAlignment = NSTextAlignmentCenter;
        [self stopButtons];
        
        [self saveHighscore];
        
        [self.view addSubview:labelGameOver];
        _points = 0;
        _startTimerValue = 60;
        [_timer invalidate];
        
        
        
        [UIView animateWithDuration:4 animations:^{
            labelGameOver.alpha = 0;
        } completion:^(BOOL finished) {
            [self revealWord];
            
        }];
        
        
        
        
        
        
        
    }
    
    
    
}



-(void) saveHighscore {
    
    if (_points>0) {
        
        NSArray *oldScores = [DefaultsDataManager getDataForKey:_keyForHighScore];
        NSMutableArray *newScores = [NSMutableArray arrayWithArray:oldScores];
        [newScores addObject:[NSNumber numberWithInt:_points]];
        
        
        // Used sort with descriptors to allow for ascending:no instead of using sort with selector
        
        
        NSSortDescriptor *scoreSortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"intValue" ascending:NO];
        NSArray *sortDescriptors = @[scoreSortDescriptor];
        NSArray *sortedScores = [newScores sortedArrayUsingDescriptors:sortDescriptors];
        NSArray *topTen = [sortedScores subarrayWithRange:NSMakeRange(0, MIN(10, sortedScores.count))];
        
        [DefaultsDataManager saveData:topTen forKey:_keyForHighScore];
    }
    
}

-(IBAction)restart:(id)sender {
    [_timer invalidate];
    _labelPoints.backgroundColor = [UIColor whiteColor];
    _labelPoints.textColor = [UIColor blackColor];
    _labelPoints.text = [NSString stringWithFormat:@"%i",_points];
    for (letterButton *button in _letterButtons) {
        [button removeFromSuperview];
    }
    for (wordLabel *label in _wordLabels) {
        label.text = @"";
        
    }

    _arrayRandomLetters = [[NSMutableArray alloc] initWithArray:[WordSelector createArrayOfLetters]];
    [self setUpWordLabels];
    [self setUpLetterButtons];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCountDown) userInfo:nil repeats:YES];
    _buttonAgain.enabled = NO;
    _buttonAgain.alpha = 0;
    
    
    
    
    
}

-(void)stopButtons {
    for (int x =0; x<9; x++) {
        letterButton *stop = [_letterButtons objectAtIndex:x];
        
        [stop removeTarget:self action:@selector(wasDragged:withEvent:) forControlEvents:UIControlEventAllEvents];
        [stop removeTarget:self action:@selector(dragStopped:) forControlEvents:UIControlEventAllEvents];
        
        
    }
    
    
    
}

-(void)winSplash {
#define degreesToRadians(x) (M_PI * x / 180.0)
    
    _buttonAgain.enabled = NO;
    _buttonAgain.alpha = NO;
    
    NSArray *arraySplashWords = [[NSArray alloc] initWithObjects:@"Hooray",@"Terrific",@"Wow",@"Nifty",@"Amazing",@"Yahoo!",@"Great",@"Brilliant",@"Inspiring",@"Yay", nil];
    NSArray *arraySplashColors = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor orangeColor],[UIColor magentaColor], nil];
    
    NSArray *arrayX = [[NSArray alloc]initWithObjects:@5 ,@-5, @5, @-5, @0.2, @10, nil];
    NSArray *arrayY = [[NSArray alloc]initWithObjects:@-5,@5 , @5, @-5, @0.2, @10, nil];
    
    
    int randomNumberWord = arc4random_uniform(arraySplashWords.count);
    int randomNumberColor = arc4random_uniform(arraySplashColors.count);
    //int randomNumberScale = arc4random_uniform(arrayScales.count);
    
    NSString *splashWord = [arraySplashWords objectAtIndex:randomNumberWord];
    UIColor *splashColor = [arraySplashColors objectAtIndex:randomNumberColor];
    //randomScale = [[arrayScales objectAtIndex:randomNumberScale] floatValue];
    
    
    
    UILabel *winLabel = [[UILabel alloc] init];
    winLabel.frame = CGRectMake(0, _screenHeight*.65, _screenWidth,_screenHeight*.3);
    winLabel.text = splashWord;
    winLabel.textColor = splashColor;
    
    winLabel.font = [UIFont fontWithName:@"Helvetica" size:_screenWidth * 0.05];
    winLabel.backgroundColor = [UIColor clearColor];
    winLabel.layer.cornerRadius = _screenHeight*.05;
    //winLabel.layer.borderColor = [[UIColor redColor] CGColor];
    //winLabel.layer.borderWidth = 2;
    winLabel.clipsToBounds = YES;
    winLabel.alpha = 1;
    winLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:winLabel];
    [self.view bringSubviewToFront:winLabel];
    
    
    
    
    
    int rand_index = ((arc4random() % arrayX.count));
    //int rand_index = 0;
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        winLabel.alpha = 1;
        //winLabel.frame = CGRectMake(-_screenWidth, _screenHeight*.7, _screenWidth*.5, _screenHeight*.1);
        // CGAffineTransform affineTransform = CGAffineTransformMakeRotation(degreesToRadians(-270));
        
        if (fabs([arrayX[rand_index]floatValue])<1)
        {
            winLabel.font = [UIFont fontWithName:@"Helvetica" size:_screenWidth * 0.2];
        }
        CGAffineTransform affineScale = CGAffineTransformMakeScale([arrayX[rand_index] floatValue], [arrayY[rand_index] floatValue]);
        
        // winLabel.transform = affineTransform;
        winLabel.transform = affineScale;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            CGAffineTransform affineScale = CGAffineTransformMakeScale(fabs([arrayX[rand_index] floatValue]), fabs([arrayY[rand_index] floatValue]));
            winLabel.transform = affineScale;
        } completion:^(BOOL finished) {
            _buttonAgain.enabled = YES;
            _buttonAgain.alpha = 1;
            winLabel.alpha = 0;
        }];
    }];
    
    
    
}






@end
