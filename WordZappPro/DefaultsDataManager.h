//
//  DefaultsDataManager.h
//  WordGame 2.0
//
//  Created by Adam Schor on 12/5/15.
//  Copyright © 2015 AandA Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultsDataManager : NSObject



+(void)saveData: (NSObject *) data forKey: (NSString *)key;
+(id)getDataForKey: (NSString *) key;


@end
