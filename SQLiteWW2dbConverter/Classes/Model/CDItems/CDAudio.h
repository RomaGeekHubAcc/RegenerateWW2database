//
//  CDAudio.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDItems;

@interface CDAudio : NSManagedObject

@property (nonatomic, retain) NSNumber * audioId;
@property (nonatomic, retain) NSString * audioInfo;
@property (nonatomic, retain) NSNumber * isAutoPlay;
@property (nonatomic, retain) NSNumber * isAutoStop;
@property (nonatomic, retain) NSNumber * isBackgroundAudio;
@property (nonatomic, retain) NSNumber * itemId;
@property (nonatomic, retain) NSNumber * localization;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) CDItems *items;

@end
