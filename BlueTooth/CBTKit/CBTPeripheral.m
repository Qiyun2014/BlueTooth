//
//  CBTPeripheral.m
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import "CBTPeripheral.h"

@interface CBTPeripheral () <CBPeripheralDelegate>

@end

@implementation CBTPeripheral

- (id)initWithPeripheral:(CBPeripheral *)peripheral {
    if (self = [super init]) {
        self.peripheral = peripheral;
        self.peripheral.delegate = self;
        self.services = [[NSMutableArray alloc] init];
    }
    return self;
}


+ (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    CBTPeripheral *mPeripheral = [[CBTPeripheral alloc] init];
    return mPeripheral;
}


#pragma mark    -   public method


- (NSInteger)getMaximumWriteDataOfLengthForStatus:(BOOL)withoutResponse {
    return [self.peripheral maximumWriteValueLengthForType:withoutResponse ?
                        CBCharacteristicWriteWithResponse : CBCharacteristicWriteWithoutResponse];
}


// 写入数据
- (void)writeData:(NSString *)data withoutResponse:(BOOL)withoutResponse {
    NSData *inputData = [data dataUsingEncoding:NSUTF8StringEncoding];
    [self.peripheral writeValue:inputData
              forCharacteristic:nil
                           type:withoutResponse ? CBCharacteristicWriteWithResponse : CBCharacteristicWriteWithoutResponse];
}


#pragma mark    -   get method


- (NSInteger)getSupportWriteMaximumLength {
    return [self.peripheral maximumWriteValueLengthForType:CBCharacteristicWriteWithResponse];
}

#pragma mark    -   CBPeripheralDelegate


- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral NS_AVAILABLE(10_9, 6_0) {
    NSLog(@"peripheral -->   did update");
}


- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices NS_AVAILABLE(10_9, 7_0) {
    NSLog(@"peripheral -->   did modify = %@", invalidatedServices);
}



- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(nullable NSError *)error NS_AVAILABLE(10_13, 8_0) {
    NSLog(@"peripheral -->   did read RSSI = %@, error = %@", RSSI, error);
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"peripheral -->   did discover services, error = %@", error);
    
    if (!error) {
        for (CBService *service in peripheral.services) {
            // 根据GATT (Generic Attribute Profile) 服务获取特征值
            [peripheral discoverCharacteristics:nil forService:service];
            
            // @example <CBService: 0x2825203c0, isPrimary = YES, UUID = 7798082B-B7B7-45A6-9933-563492EFE04E>, characteristics = (null)
            NSLog(@" -->  service = %@", service);
            if (self.delegate && [self.delegate respondsToSelector:@selector(peripheral:didDiscoverPeripheralService:)]) {
                [self.delegate peripheral:self didDiscoverPeripheralService:service];
            }
            
            // 存储所有服务
            if (![self.services containsObject:service]) {
                [self.services addObject:service];
            }
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"peripheral -->   did discover included services = %@, error = %@", service, error);
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    NSLog(@"peripheral -->   did discover characteristics services = %@, error = %@", service, error);
    if (!error) {
         for (CBCharacteristic *characteristic in service.characteristics) {
             switch (characteristic.properties) {
                 case CBCharacteristicPropertyWrite: {
                         NSLog(@"peripheral -->   CBCharacteristicPropertyWrite");
                         NSLog(@"peripheral -->   %lu", characteristic.properties & CBCharacteristicPropertyWrite);
                     }
                     break;
                     
                case CBCharacteristicPropertyWriteWithoutResponse:
                     NSLog(@"peripheral -->   CBCharacteristicPropertyWriteWithoutResponse");
                     break;
                     
                case CBCharacteristicPropertyRead:
                     NSLog(@"peripheral -->   CBCharacteristicPropertyRead");
                     break;
                     
                case CBCharacteristicPropertyNotify:
                     NSLog(@"peripheral -->   CBCharacteristicPropertyNotify");
                     break;
                     
                case CBCharacteristicPropertyIndicate:
                     NSLog(@"peripheral -->   CBCharacteristicPropertyIndicate");
                     break;
                     
                 default:
                     break;
             }
             NSLog(@"peripheral -->   设备获取特征成功，服务名：%@，特征值名：%@，特征UUID：%@，特征数量：%lu", service, characteristic, characteristic.UUID, service.characteristics.count);
             //获取特征对应的描述 会回调didDiscoverDescriptorsForCharacteristic
             [peripheral discoverDescriptorsForCharacteristic:characteristic];
               
             //获取特征的值 会回调didUpdateValueForCharacteristic
             [peripheral readValueForCharacteristic:characteristic];
             
             // 开启通知
             [peripheral setNotifyValue:YES forCharacteristic:characteristic];
         }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSASCIIStringEncoding];
    NSLog(@"特征名：%@，特征值：%@", characteristic, value);
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if(error){
        NSLog(@"设备获取描述失败，设备名：%@", peripheral.name);
    }
    for (CBDescriptor *descriptor in characteristic.descriptors) {
        [peripheral readValueForDescriptor:descriptor];
        NSLog(@"设备获取描述成功，描述名：%@",descriptor);
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    
    if (!error) {
        NSLog(@"读取特征值从描述信息   %@, value = %@", descriptor, descriptor.value);
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    
}


- (void)peripheralIsReadyToSendWriteWithoutResponse:(CBPeripheral *)peripheral {
    
}


- (void)peripheral:(CBPeripheral *)peripheral didOpenL2CAPChannel:(nullable CBL2CAPChannel *)channel error:(nullable NSError *)error {
    
}


@end
