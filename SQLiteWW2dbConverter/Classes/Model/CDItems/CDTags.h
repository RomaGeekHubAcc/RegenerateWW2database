//
//  CDTags.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDDimensions, CDItems;

@interface CDTags : NSManagedObject

@property (nonatomic, retain) NSNumber * dimensionId;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * radius;
@property (nonatomic, retain) NSNumber * tagId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) CDDimensions *dimensions;
@property (nonatomic, retain) NSSet *items;
@end

@interface CDTags (CoreDataGeneratedAccessors)

- (void)addItemsObject:(CDItems *)value;
- (void)removeItemsObject:(CDItems *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
