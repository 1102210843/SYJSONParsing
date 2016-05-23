# SYJSONParsing
这是一个轻量级的JSON解析及模型转换工具，支持普通JSON格式的解析，数据到模型的转换

#1.JSON解析SYJSONParsing
该类进行JSON解析，支持NSData和NSString类型

+ (id)jsonParsingWithData:(NSData *)data error:(NSError **)error;

+ (id)jsonParsingWithString:(NSString *)string error:(NSError **)error;


#2.模型转换 SYBaseModel
模型转换参考JSONModel部分方法

将模型继承于SYBaseModel类，在文件中添加属性即可

#JSON数据中key为关键字的情况
如果JSON数据中的key为关键字，那么属性以KW开头，即keyword，后面接key字段，如下：

@property (nonatomic, strong) NSString *KWdescription;

#数据格式嵌套

1.字典

如果数据中嵌套字典，那么与创建model相同，自定义一个类，继承于SYBaseModel类，然后作为属性添加到上层model中，如下面代码中 key5：

2.数组

a.如果数据中嵌套数组，且数组中为NSString、NSNumber，那么直接添加属性 

@property (nonatomic, strong) NSArray *key3;

b.如果数组中为字典，那么字典即为一个新的model，创建一个新的model，并且声明一个协议，写法如下面代码中 key3：

c.应该不会有数组中又嵌数组这么奇葩的情况吧


#import "SYBaseModel.h"

@class SYKey5Model;

@class SYKey3Model;

@protocol SYKey3Model <NSObject>

@end

@interface SYTestModel : SYBaseModel

@property (nonatomic, strong) NSString *key1;

@property (nonatomic, strong) NSString *key2;

@property (nonatomic, strong) NSArray <SYKey3Model>*key3;

@property (nonatomic, strong) NSArray *key4;

@property (nonatomic, strong) SYKey5Model *key5;

@end

@interface SYKey3Model : SYBaseModel

@property (nonatomic, strong) NSString *aaa;

@property (nonatomic, strong) NSString *sss;

@end

@interface SYKey5Model : SYBaseModel

@property (nonatomic,  strong) NSString *eee;

@property (nonatomic, strong) NSString *www;

@end




#属性的类型

- (instancetype)initModelTransformModelWithDict:(NSDictionary *)dict{

if (self = [super initModelTransformModelWithDict:dict]) {

//类型转换

//如果属性设置为 int，NSInteger，CGFloat，BOOL等类型时，需在.m文件中重写初始化方法，对属性进行手动转换

self.totalTime = [[dict objectForKey:@"totalTime"]integerValue];

}

return self;

}

 
