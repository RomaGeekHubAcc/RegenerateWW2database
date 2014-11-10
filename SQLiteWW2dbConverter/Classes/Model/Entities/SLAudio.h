//
//  SLAudio.h
//  Parallaxer
//
//  Created by Igor Karpenko on 3/1/13.
//  Copyright (c) 2013 Mozi Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLAudio : NSObject

@property (nonatomic, assign) NSInteger audioId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *audioInfo;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) BOOL isBackgroundAudio;
@property (nonatomic, assign) BOOL isAutoPlay;
@property (nonatomic, assign) BOOL isAutoStop;
@property (nonatomic, assign) NSInteger localization;

@end
