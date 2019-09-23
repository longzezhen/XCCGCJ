//
//	DDZMapModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "DDZMapModel.h"
#import <NSObject+YYModel.h>

@interface YYEatModel ()

@end
@implementation YYEatModel

@end

NSString *const kDDZMapModelIsCurrentPosition = @"isCurrentPosition";
NSString *const kDDZMapModelIsPassOrNot = @"isPassOrNot";
NSString *const kDDZMapModelMapGrade = @"mapGrade";

@interface DDZMapModel ()
@end
@implementation DDZMapModel


/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kDDZMapModelIsCurrentPosition] isKindOfClass:[NSNull class]]){
		self.isCurrentPosition = [dictionary[kDDZMapModelIsCurrentPosition] boolValue];
	}

	if(![dictionary[kDDZMapModelIsPassOrNot] isKindOfClass:[NSNull class]]){
		self.isPassOrNot = [dictionary[kDDZMapModelIsPassOrNot] boolValue];
	}

	if(![dictionary[kDDZMapModelMapGrade] isKindOfClass:[NSNull class]]){
		self.mapGrade = [dictionary[kDDZMapModelMapGrade] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kDDZMapModelIsCurrentPosition] = @(self.isCurrentPosition);
	dictionary[kDDZMapModelIsPassOrNot] = @(self.isPassOrNot);
	dictionary[kDDZMapModelMapGrade] = @(self.mapGrade);
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.isCurrentPosition) forKey:kDDZMapModelIsCurrentPosition];	[aCoder encodeObject:@(self.isPassOrNot) forKey:kDDZMapModelIsPassOrNot];	[aCoder encodeObject:@(self.mapGrade) forKey:kDDZMapModelMapGrade];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.isCurrentPosition = [[aDecoder decodeObjectForKey:kDDZMapModelIsCurrentPosition] boolValue];
	self.isPassOrNot = [[aDecoder decodeObjectForKey:kDDZMapModelIsPassOrNot] boolValue];
	self.mapGrade = [[aDecoder decodeObjectForKey:kDDZMapModelMapGrade] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	DDZMapModel *copy = [DDZMapModel new];

	copy.isCurrentPosition = self.isCurrentPosition;
	copy.isPassOrNot = self.isPassOrNot;
	copy.mapGrade = self.mapGrade;

	return copy;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // 将personId映射到key为id的数据字段
//    return @{@"personId":@"id"};
    // 映射可以设定多个映射字段
      return @{@"persionId":@[@"id",@"uid",@"ID"],
               @"nameStr":@"name",
               @"sex":@"sexDic.sex"
               };
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{@"eats" : [YYEatModel class]};
}


@end
