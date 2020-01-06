//
//  CBTManager.m
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//
//  <https://developer.apple.com/documentation/corebluetooth?language=objc>


/*
 1、Start up a central manager object
 2、Discover and connect to peripheral devices that are advertising
 3、Explore the data on a peripheral device after you’ve connected to it
 4、Send read and write requests to a characteristic value of a peripheral’s service
 5、Subscribe to a characteristic’s value to be notified when it is updated
*/


#import "CBTManager.h"


@interface CBTManager ()


@end


@implementation CBTManager


+ (CBTManagerAuthrozationStatus)checkAuthrozationStatusForManager:(CBManager *)manager {
        
    return 0;
}


- (id)init {
    if (self = [super init]) {
        self.discoverPeripherals = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)dealloc {

}


#pragma mark    -   public method

- (void)scanPeripherals {
    
}

#pragma mark    -   private




#pragma mark    -   get method



@end
