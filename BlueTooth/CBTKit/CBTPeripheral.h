//
//  CBTPeripheral.h
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@class CBTPeripheral;
@protocol CBTPeripheralDelegate <NSObject>

- (void)peripheral:(CBTPeripheral *)peripheral didDiscoverPeripheralService:(CBService *)sevice;

@end


@interface CBTPeripheral : NSObject

- (id)initWithPeripheral:(CBPeripheral *)peripheral;
+ (instancetype)initWithPeripheral:(nullable CBPeripheral *)peripheral;


// Current peripheral
@property (strong, nonatomic) CBPeripheral *peripheral;

// For delegate 
@property (weak, nonatomic) id <CBTPeripheralDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
