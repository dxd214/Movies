//
//  ImageListModel.h
//  01 Movie
//
//  Created by lyb on 14-10-14.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseModel.h"

/*
 {
 "id": 2070298,
 "image": "http://img21.mtime.cn/pi/2012/04/12/115903.34837484_1280X720.jpg",
 "type": 6
 }
 */

@interface ImageListModel : BaseModel

@property(nonatomic, copy)NSString *image;
@property(nonatomic, retain)NSNumber *type;

@end
