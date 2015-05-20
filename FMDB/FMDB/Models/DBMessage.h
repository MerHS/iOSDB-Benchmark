//
//  DBMessage.h
//  FMDB
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBMessage : NSObject

@property (nonatomic) NSInteger messageID;
@property (nonatomic, strong) NSString * msgData;
@property (nonatomic, strong) NSDate * sendTime;
@property (nonatomic) NSInteger senderID;
@property (nonatomic) BOOL viewed;

-(id) initWithoutID;

+(DBMessage *) getRandomMessage;
+(DBMessage *) getRandomMessage:(NSInteger)senderID;

@end
