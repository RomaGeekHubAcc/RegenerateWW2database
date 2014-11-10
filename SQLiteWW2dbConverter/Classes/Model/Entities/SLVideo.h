//
//  SLVideo.h
//  Parallaxer
//
//  Created by s.leluk on 17.09.12.
//  Copyright 2012 Mozi Development. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SLVideo : NSObject 

@property (nonatomic, assign) NSInteger videoId;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *videoUrl;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, assign) BOOL visibleOnMap;
@property (nonatomic, retain) NSString *cover;
@property (nonatomic, strong) NSString *thumbnailCover;
@property (nonatomic, assign) NSInteger *localization;

@property (nonatomic, strong) NSString *videoCoverOldName;


-(BOOL) generateVideoCovers;

@end
