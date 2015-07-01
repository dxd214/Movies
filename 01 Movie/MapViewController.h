//
//  MapViewController.h
//  WXMovie
//
//  Created by wei.chen on 14-2-19.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>

@interface WXAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end


@interface MapViewController : BaseViewController<MKMapViewDelegate> {
    MKMapView *_mapView;
}

@property(nonatomic,retain)NSArray *annotations;

@end
