//
//  CDItems.h
//  SQLiteWW2dbConverter
//
//  Created by Roman Rybachenko on 10/17/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDAudio, CDImages, CDPacks, CDPanorams, CDTags, CDTypes, CDVideos;

@interface CDItems : NSManagedObject

@property (nonatomic, retain) NSString * amendedUser;
@property (nonatomic, retain) NSString * backgroundImage;
@property (nonatomic, retain) NSNumber * contentTypeId;
@property (nonatomic, retain) NSDate * copyrightExpiryDate;
@property (nonatomic, retain) NSString * copyrightNotes;
@property (nonatomic, retain) NSString * copyrightOwner;
@property (nonatomic, retain) NSNumber * coverId;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDate * dateFrom;
@property (nonatomic, retain) NSNumber * dateMask;
@property (nonatomic, retain) NSDate * dateSpot;
@property (nonatomic, retain) NSDate * dateTo;
@property (nonatomic, retain) NSNumber * dateVisibleOnTimeline;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSNumber * includeTitle;
@property (nonatomic, retain) NSNumber * ipadPriority;
@property (nonatomic, retain) NSNumber * ipadVisible;
@property (nonatomic, retain) NSNumber * iphonePriority;
@property (nonatomic, retain) NSNumber * iphoneVisible;
@property (nonatomic, retain) NSNumber * isMap;
@property (nonatomic, retain) NSNumber * isTimeLine;
@property (nonatomic, retain) NSNumber * itemId;
@property (nonatomic, retain) NSString * itemLongText;
@property (nonatomic, retain) NSString * itemShortText;
@property (nonatomic, retain) NSDate * lastChangeDate;
@property (nonatomic, retain) NSNumber * packId;
@property (nonatomic, retain) NSString * timelineImage;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * typeId;
@property (nonatomic, retain) NSNumber * visibleOnMapText;
@property (nonatomic, retain) NSSet *audio;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) CDPacks *packs;
@property (nonatomic, retain) NSSet *panorams;
@property (nonatomic, retain) NSSet *tags;
@property (nonatomic, retain) CDTypes *types;
@property (nonatomic, retain) NSSet *videos;
@end

@interface CDItems (CoreDataGeneratedAccessors)

- (void)addAudioObject:(CDAudio *)value;
- (void)removeAudioObject:(CDAudio *)value;
- (void)addAudio:(NSSet *)values;
- (void)removeAudio:(NSSet *)values;

- (void)addImagesObject:(CDImages *)value;
- (void)removeImagesObject:(CDImages *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addPanoramsObject:(CDPanorams *)value;
- (void)removePanoramsObject:(CDPanorams *)value;
- (void)addPanorams:(NSSet *)values;
- (void)removePanorams:(NSSet *)values;

- (void)addTagsObject:(CDTags *)value;
- (void)removeTagsObject:(CDTags *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

- (void)addVideosObject:(CDVideos *)value;
- (void)removeVideosObject:(CDVideos *)value;
- (void)addVideos:(NSSet *)values;
- (void)removeVideos:(NSSet *)values;

@end
