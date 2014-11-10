//
//  CDTypes.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDContentTypes, CDItems;

@interface CDTypes : NSManagedObject

@property (nonatomic, retain) NSNumber * contentTypeId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * typeId;
@property (nonatomic, retain) CDContentTypes *contentTypes;
@property (nonatomic, retain) NSSet *items;
@end

@interface CDTypes (CoreDataGeneratedAccessors)

- (void)addItemsObject:(CDItems *)value;
- (void)removeItemsObject:(CDItems *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
