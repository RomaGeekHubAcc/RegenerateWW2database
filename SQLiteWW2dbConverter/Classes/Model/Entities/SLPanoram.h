//
//  SLPanoram.h
//  Parallaxer
//
//  Created by Stanislav Leliyk on 10/26/12.
//  Copyright 2012 Mozi Development. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SLPanoram : NSObject

@property (nonatomic, retain) NSString *archiveInfo;
@property (nonatomic, retain) NSString *fullImage;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) NSInteger panoramaId;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, retain) NSString *thumbnailImage;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) BOOL visibleOnMap;

@end
