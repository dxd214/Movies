//
//  MapViewController.m
//  WXMovie
//
//  Created by wei.chen on 14-2-19.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MapViewController.h"

@implementation WXAnnotation


- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    
    self = [super init];
    
    if (self) {
        _coordinate = coordinate;
    }
    
    return self;
    
}

@end


@interface MapViewController ()

@property(nonatomic,retain)MKUserLocation *userLocation;

@end

@implementation MapViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-20-44)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
    
}

#pragma mark - MKMapView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identify = @"map-Annation";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify] ;
        
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    }
    
    annotationView.annotation = annotation;
    
    return annotationView;
    
}

//更新当前设备的位置，持续调用的
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
   
    if (self.userLocation == nil) {
        
        CLLocationCoordinate2D center = userLocation.coordinate;
        MKCoordinateSpan span = {0.1,0.1};
        MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
        
        //设置显示区域
        [_mapView setRegion:region animated:YES];
        
        self.userLocation = userLocation;
    }
    
    
}

//地图加载完之后调用的协议方法
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
    //添加标注视图
    
    for (WXAnnotation *annotation in self.annotations) {
        [_mapView addAnnotation:annotation];
    }
    
}


@end
