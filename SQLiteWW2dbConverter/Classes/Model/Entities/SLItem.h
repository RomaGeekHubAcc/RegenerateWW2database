//
//  SLItem.h
//  Parallaxer
//
//  Created by Victor Chernysh on 9/14/12.
//  Copyright (c) 2012 Mozi Development. All rights reserved.
//

#import "PrefixHeader.pch"

#import "SLTag.h"

@interface SLItem : NSObject

@property(nonatomic, assign) NSInteger itemId;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, assign) BOOL includeTitle;
@property(nonatomic, retain) NSString *itemShortText;
@property(nonatomic, retain) NSString *itemLongText;
@property(nonatomic, assign) BOOL visibleOnMapText;
@property(nonatomic, assign) BOOL isMap;
@property(nonatomic, assign) BOOL ipadVisible;
@property(nonatomic, assign) BOOL iphoneVisible;
@property(nonatomic, assign) NSInteger ipadPriority;
@property(nonatomic, assign) NSInteger iphonePriority;
@property(nonatomic, retain) NSDate *dateSpot;
@property(nonatomic, retain) NSDate *dateFrom;
@property(nonatomic, retain) NSDate *dateTo;
@property(nonatomic, assign) NSInteger dateMask;
@property(nonatomic, assign) BOOL dateVisibleOnTimeline;
@property(nonatomic, retain) NSString *timelineImage;
@property(nonatomic, retain) NSString *backgroundImage;
@property(nonatomic, assign) NSInteger packId;
@property(nonatomic, assign) NSInteger typeId;
@property(nonatomic, assign) NSInteger contentTypeId;
@property(nonatomic, assign) NSInteger coverId;
@property(nonatomic, retain) NSDate *copyrightExpiryDate;
@property(nonatomic, retain) NSString *copyrightOwner;
@property(nonatomic, retain) NSString *copyrightNotes;
@property(nonatomic, assign) BOOL favorite;
@property(nonatomic, retain) NSArray *tags;
@property(nonatomic, retain) NSArray *panorams;
@property(nonatomic, retain) NSArray *images;
@property(nonatomic, retain) NSArray *videos;
@property(nonatomic, retain) NSArray *audio;
@property(nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString * amendedUser;
@property (nonatomic, retain) NSDate * lastChangeDate;

@property (nonatomic, assign) NSInteger indexOfObjectWhereDate;// added temp @property
@property (nonatomic, strong) NSString *imageName;


@end
