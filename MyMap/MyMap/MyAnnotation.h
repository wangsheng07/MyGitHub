//
//  MyAnnotation.h
//  MyMap
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>

@property (nonatomic,assign)CLLocationCoordinate2D coordinate;

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subtitle;


@property (nonatomic,strong)UIImage *icon;




@end
