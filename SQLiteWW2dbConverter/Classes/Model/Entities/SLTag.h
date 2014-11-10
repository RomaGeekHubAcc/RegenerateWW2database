//
//  SLTag.h
//  Parallaxer
//
//  Created by Victor Chernysh on 9/15/12.
//  Copyright 2012 Mozi Development. All rights reserved.
//

#import "PrefixHeader.pch"

@interface SLTag : NSObject

@property(nonatomic, assign) NSInteger tagId;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, assign) float latitude;
@property(nonatomic, assign) float longitude;
@property(nonatomic, assign) float radius;
@property(nonatomic, assign) NSInteger dimensionId;

@end
