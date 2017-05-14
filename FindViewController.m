//
//  FindViewController.m
//  WordZappPro
//
//  Created by Adam Schor on 5/8/17.
//  Copyright © 2017 AandA Development. All rights reserved.
//

#import "FindViewController.h"
#import "AppDelegate.h"


@interface FindViewController ()

//@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;
//@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    _appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [[_appDelegate mcManager] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
    
    _arrConnectedDevices = [[NSMutableArray alloc] init];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(peerDidChangeStateWithNotification:) name:@"MCDidChangeStateNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    
    [_appDelegate.mcManager setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
    [_appDelegate.mcManager setupMCBrowser];
    [_appDelegate.mcManager advertiseSelf:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleVisibility:(id)sender {
    [_appDelegate.mcManager advertiseSelf:_swVisible.isOn];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrConnectedDevices.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [_arrConnectedDevices objectAtIndex:indexPath.row];
    return cell;

}

-(void)browseForDevices:(id)sender{
    [[_appDelegate mcManager]setupMCBrowser];
    [[[_appDelegate mcManager]browser]setDelegate:self];
    [self presentViewController:[[_appDelegate mcManager]browser] animated:YES completion:nil];
    

}

-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
}

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    MCSessionState state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    if (state != MCSessionStateConnecting) {
        [_tblConnectedDevices reloadData];
        
        BOOL peersExist = ([[_appDelegate.mcManager.session connectedPeers] count] == 0);
        [_btnDisconnect setEnabled:!peersExist];
      //  [_txtName setEnabled:peersExist];
    }
    if (state == MCSessionStateConnected) {
        [_arrConnectedDevices addObject:peerDisplayName];
        NSLog(@"Connected and dismiss");
        [_appDelegate.mcManager.browser dismissViewControllerAnimated:YES completion:nil];
        
    }
    else if (state == MCSessionStateNotConnected){
        if ([_arrConnectedDevices count] > 0) {
            NSInteger indexOfPeer = [_arrConnectedDevices indexOfObject:peerDisplayName];
            [_arrConnectedDevices removeObjectAtIndex:indexOfPeer];
        }
    }

}

-(IBAction)disconnect:(id)sender {
    [_appDelegate.mcManager.session disconnect];
    
  //  _txtName.enabled = YES;
    
    [_arrConnectedDevices removeAllObjects];
    [_tblConnectedDevices reloadData];
    
}
- (IBAction)btnSendDataPressed:(id)sender {
    
    NSString *words = @"One Word";
    
    
    NSData *dataToSend = [words dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *allPeers = _appDelegate.mcManager.session.connectedPeers;
    NSError *error;
    
    [_appDelegate.mcManager.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
   
    
  }


-(void)didReceiveDataWithNotification:(NSNotification *)notification{
   //MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
   //NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"The received text is %@",receivedText);
    _lblStatus.text = receivedText;
    
    [_tvChat performSelectorOnMainThread:@selector(setText:) withObject:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"%@", receivedText]] waitUntilDone:NO];
    
}
@end
