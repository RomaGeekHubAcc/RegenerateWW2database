//
//  SLImage.h
//  Parallaxer
//
//  Created by s.leluk on 17.09.12.
//  Copyright 2012 Mozi Development. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SLImage : NSObject {
    
}

@property (nonatomic, assign) NSInteger imageId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, assign) BOOL hideWhiteBorder;
@property (nonatomic, assign) BOOL visibleOnMap;
@property (nonatomic, retain) NSString *thumbnailImage;
@property (nonatomic, retain) NSString *fullImage;

@property (strong, nonatomic) NSString *oldImageName;


-(BOOL) generateFullAndThumnailImages;

@end
