//
//  DBObject.h
//  Obj-LevelDB
//
//  Created by JHY on 2015. 4. 10..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBObject : NSObject

@property(strong, nonatomic) NSNumber*  messageID;
@property(strong, nonatomic) NSDate*    sendTime;
@property(strong, nonatomic) NSString*  sender;
@property(strong, nonatomic) NSString*    msgData;
@property(strong, nonatomic) NSNumber*  viewed;

@end
