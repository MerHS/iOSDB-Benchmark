//
//  DBSender.h
//  CoreData
//
//  Created by JHY on 2015. 5. 20..
//  Copyright (c) 2015년 KINETC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DBMessage;

@interface DBSender : NSManagedObject

@property (nonatomic, strong) NSNumber * senderID;
@property (nonatomic, strong) NSData * senderImage;
@property (nonatomic, strong) NSString * senderName;
@property (nonatomic, strong) NSSet *messages;
@end

@interface DBSender (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(DBMessage *)value;
- (void)removeMessagesObject:(DBMessage *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
