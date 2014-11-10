//
//  CDPanorams.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDItems;

@interface CDPanorams : NSManagedObject

@property (nonatomic, retain) NSString * archiveInfo;
@property (nonatomic, retain) NSString * fullImage;
@property (nonatomic, retain) NSNumber * itemId;
@property (nonatomic, retain) NSNumber * panoramaId;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * thumbnailImage;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * visibleOnMap;
@property (nonatomic, retain) CDItems *items;

@end
