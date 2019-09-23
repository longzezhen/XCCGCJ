#import <UIKit/UIKit.h>

@interface YYEatModel : NSObject

@property (copy, nonatomic)NSString *food;
@property (copy, nonatomic)NSString *date;

@end

@interface DDZMapModel : NSObject

@property (nonatomic, assign) BOOL isCurrentPosition;
@property (nonatomic, assign) BOOL isPassOrNot;
@property (nonatomic, assign) NSInteger mapGrade;

@property (nonatomic, assign) NSNumber *persionId;
@property (nonatomic, strong) NSString *nameStr;

@property (copy,   nonatomic) NSString *sex;
@property (strong, nonatomic) NSArray <YYEatModel *> *eats;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
