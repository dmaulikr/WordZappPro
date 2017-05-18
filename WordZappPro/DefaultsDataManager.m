//
//  DefaultsDataManager.m
//  WordGame 2.0
//
//  Created by Adam Schor on 12/5/15.
//  Copyright © 2015 AandA Development. All rights reserved.
//

#import "DefaultsDataManager.h"

@implementation DefaultsDataManager

/*
 +(BOOL)saveData:(NSObject *)data forKey:(NSString *)key {
 @try {
 [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
 }
 @catch (NSException *exception) {
 return false;
 }
 
 [[NSUserDefaults standardUserDefaults] synchronize];
 return true;
 
 }
 
 +(id)getDataForKey:(NSString *)key {
 return [[NSUserDefaults standardUserDefaults] objectForKey:key];
 */

+(void)saveData:(NSObject *)data forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(id)getDataForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    
}



@end
