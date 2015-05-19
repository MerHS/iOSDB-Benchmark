//
//  DBMessage.h
//  CoreData
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DBSender;

@interface DBMessage : NSManagedObject

@property (nonatomic, strong) NSNumber * messageID;
@property (nonatomic, strong) NSString * msgData;
@property (nonatomic, strong) NSDate * sendTime;
@property (nonatomic, strong) NSNumber * viewed;
@property (nonatomic, strong) DBSender *sender;

@end
