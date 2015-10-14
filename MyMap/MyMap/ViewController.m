//
//  ViewController.m
//  MyMap
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
#import <AMapNaviKit/AMapNaviKit.h>

@interface ViewController ()<MKMapViewDelegate,MAMapViewDelegate,AMapNaviManagerDelegate>

@property (nonatomic,strong)MKMapView *mapView;
@property (nonatomic,strong)CLLocationManager *manager;

@property (nonatomic,strong)MAMapView *maMap;

@property (nonatomic,strong)AMapNaviManager *naviManager;

@end

@implementation ViewController

- (void)initNaviManager
{
    if (_naviManager == nil)
    {
        _naviManager = [[AMapNaviManager alloc] init];
        [_naviManager setDelegate:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.manager = [[CLLocationManager alloc]init];
    //向设备请求授权
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        //向设备申请 "程序在使用时,使用定位功能"
        [self.manager requestWhenInUseAuthorization];
        //requestAlwaysAuthorization  后台使用也支持定位
    }
    
    
    
//    self.mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:_mapView];
//    
//    //设置地图样式
//    self.mapView.mapType = MKMapTypeStandard;
//    
//    //设置地图显示中心
//    CLLocationCoordinate2D locat = CLLocationCoordinate2DMake(40,116);
//    
//    [self.mapView setCenterCoordinate:locat animated:YES];
//    
//    //设置地图的显示范围
//    [self.mapView setRegion:MKCoordinateRegionMake(locat, MKCoordinateSpanMake(10,10))];
//    
//    //跟踪用户,打开用户位置
//    
//    self.mapView.showsUserLocation = YES;
//    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading
//    ;
//    // 是否允许地图旋转
//    self.mapView.rotateEnabled = NO;
//    
//    
//    self.mapView.delegate = self;
    
    
    //高德地图
    [MAMapServices sharedServices].apiKey = @"ab7905b8e928232d45046e04f2d4fe8e";
    _maMap = [[MAMapView alloc]initWithFrame:self.view.frame];
    self.maMap.delegate = self;
    [self.view addSubview:_maMap];
 
    // 地图样式(卫星地图)
    //_maMap.mapType = MAMapTypeSatellite;
    
    //显示实时交通路况
    _maMap.showTraffic = YES;
    
    
    
    
    
    [AMapNaviServices sharedServices].apiKey =@"2ce111c92949da606bfcd6d4f0f9078c";
    
    [self initNaviManager];
    
    // Do any additional setup after loading the view, typically from a nib.
}


// 导航路径规划
//- (void)routeCal
//{
//    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:39.989614 longitude:116.481763];
//    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:39.983456 longitude:116.315495];
//    
//    NSArray *startPoints = @[startPoint];
//    NSArray *endPoints   = @[endPoint];
//    
//    //驾车路径规划（未设置途经点、导航策略为速度优先）
//    [_naviManager calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:0];
//    
//    //步行路径规划
//    [self.naviManager calculateWalkRouteWithStartPoints:startPoints endPoints:endPoints];
//}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"获取位置成功");
}

//定位失败的代理方法
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
    NSLog(@"定位失败");
}

// 屏幕区域地图开始发生变化
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
  
    NSLog(@"屏幕区将发生变化");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{

    NSLog(@"屏幕区域变化结束");
}


//点击屏幕,在自己的位置上擦一个大头针
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
// 
//    MyAnnotation *ann = [[MyAnnotation alloc]init];
//    ann.coordinate = CLLocationCoordinate2DMake(40, 116) ;
//   ann.title = @"也在此";
//   ann.subtitle = @"开!";
//   ann.icon = [UIImage imageNamed:@"slider.png"];
//    [self.mapView addAnnotation:ann];
//}
//
//
//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    if (![annotation isKindOfClass:[MyAnnotation class]])  return nil;
//    
//    static NSString *identifier = @"identifire";
//    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//    if (!pinAnnotationView) {
//        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: identifier];
//    }
//    
// 
//    // 设置大头针的属性
//    pinAnnotationView.annotation = annotation;
//   pinAnnotationView.image = ((MyAnnotation *)annotation).icon;
//  //  pinAnnotationView.image = [UIImage imageNamed:@"slider.png"];
//    
//    // 设置可以显示冒泡上的左右图片
//    pinAnnotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider.png"]];
//    pinAnnotationView.rightCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider.png"]];
//    
//    // 从天而降(动画，只有用系统大头针样式才起作用)
//    // pinAnnotationView.animatesDrop = YES;
//    
//    //气泡偏移量
//    pinAnnotationView.calloutOffset = CGPointMake(0, 1);
//    // 设置可以显示冒泡
//    pinAnnotationView.canShowCallout = YES;
//    
//    return pinAnnotationView;
//}

// 高德 大头针标注
- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    
    [_maMap addAnnotation:pointAnnotation];

}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorGreen;
        
        
        // 自定义标注图片时:添加的图片
        // annotationView.image = [UIImage imageNamed:@"restaurant"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        //annotationView.centerOffset = CGPointMake(0, 1);
        
        
        return annotationView;
    }
    return nil;
}


//高德 :iOS SDK可自定义标注的图标和弹出气泡的样式，均通过MAAnnotationView来实现。

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
