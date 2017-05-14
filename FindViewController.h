//
//  FindViewController.h
//  WordZappPro
//
//  Created by Adam Schor on 5/8/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "AppDelegate.h"

@interface FindViewController : UIViewController <MCBrowserViewControllerDelegate, UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UISwitch *swVisible;
@property (weak, nonatomic) IBOutlet UITableView *tblConnectedDevices;
@property (weak, nonatomic) IBOutlet UIButton *btnDisconnect;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
- (IBAction)browseForDevices:(id)sender;
//- (IBAction)toggleVisibility:(id)sender;
- (IBAction)disconnect:(id)sender;

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;

- (IBAction)btnSendDataPressed:(id)sender;
-(void)didReceiveDataWithNotification:(NSNotification *)notification;
@property (strong, nonatomic) IBOutlet UITextView *tvChat;

@property NSString *theWords;

@end
