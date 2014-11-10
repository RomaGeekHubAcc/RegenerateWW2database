//
//  CDPacks.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDItems;

@interface CDPacks : NSManagedObject

@property (nonatomic, retain) NSNumber * packId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *items;
@end

@interface CDPacks (CoreDataGeneratedAccessors)

- (void)addItemsObject:(CDItems *)value;
- (void)removeItemsObject:(CDItems *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
