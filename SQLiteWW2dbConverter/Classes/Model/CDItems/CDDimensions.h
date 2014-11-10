//
//  CDDimensions.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDTags;

@interface CDDimensions : NSManagedObject

@property (nonatomic, retain) NSNumber * color;
@property (nonatomic, retain) NSNumber * dimensionId;
@property (nonatomic, retain) NSNumber * isFilter;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *tags;
@end

@interface CDDimensions (CoreDataGeneratedAccessors)

- (void)addTagsObject:(CDTags *)value;
- (void)removeTagsObject:(CDTags *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
