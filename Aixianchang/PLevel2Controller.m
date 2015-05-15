//
//  PLevel2Controller.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "PLevel2Controller.h"

@interface PLevel2Controller ()
@property (strong, nonatomic) UIScrollView *scrollView;
@end

@implementation PLevel2Controller

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"如何提高个人等级";
    self.view.backgroundColor = BackgroundColor;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 0400)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets (UIEdgeInsetsZero);
    }];

    UILabel *label = [UILabel new];
    label.text = @"了解个人等级获得更多特权";
    label.font = FONT13;
    [_scrollView addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView).offset(15);
        make.centerY.equalTo(_scrollView.mas_top).offset(20);
    }];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderWidth = 1.0f;
    view.layer.borderColor = UIColorFromRGB(0x868686).CGColor;
    [_scrollView addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(40);
//        make.left.equalTo(self.view).offset(-1);
//        make.right.equalTo(self.view).offset(1);
        make.width.equalTo(_scrollView);
        make.edges.equalTo(_scrollView).insets(UIEdgeInsetsMake(40, 0, 0, 0));
    }];
    
    UILabel *tip1 = [UILabel new];
    tip1.font = FONT15;
    tip1.text = @"如何提高个人等级";
    [view addSubview:tip1];
    [tip1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.top.equalTo(view).offset(5);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0x868686);
    [view addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tip1);
        make.right.equalTo(view).offset(-15);
        make.top.equalTo(tip1.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    
    UILabel *tip2 = [UILabel new];
    tip2.font = FONT12;
    tip2.numberOfLines = 0;
    tip2.text = @"   1999年10月，当时还只有16岁的她在美国出道，以Mai-K名义推出首张英文《Baby I Like》，由美国的独立厂牌Bip·Record发行，以[外国输入盘]的形式在日本发售，旋即被抢购一空。其后于12月8日发行以仓木麻衣名义发行的首张日文单曲《Love, Day After Tomorrow》，正式于日本出道。这张单曲初动销量只得约3万张，可是其后每周销量一直上升，并于2000年3月正式突破百万销量，合计138万张。成为2000年最耀眼的新人歌手。\n\n\
    首张单曲达成百万销售后，仓木随即推出《Stay by my side》与《Secret of my heart》两张单曲，皆获得近百万的高销量。其中《Secret of my heart》更是首次跟动画名侦探柯南合作，至今仓木仍有不少歌曲成为名侦探柯南的使用歌。\n\n\
    2000年6月7日发行专辑先行单曲《NEVER GONNA GIVE YOU UP》。6月28日发行首张专辑《delicious way》。专辑惊人的初动销量达211万，打破由去年宇多田光的《First Love》所创下的最高出道专辑初动销量。专辑累积销量达353万，力压当年滨崎步的《Duty》成为该年专辑销量冠军。获得了2000年度细碟销量冠军、大碟销量亚军、最佳作词、最出色新人奖和最高唱片收入亚军等五个奖项。而《delicious way》至今仍是日本历代销量第9专辑。\n\n\
    首张专辑获得巨大成功后，她便开始转换曲风，于年底发行《Simply Wonderful》跟《Reach for the sky》两张单曲，皆获得30万至40万的高销量。\
        环观整个2000年，仓木甫出道便立足日本音乐界的最顶峰，高销量的唱片亦为她带来约160亿日元的总销售额，成为该年总销售额歌手亚军。\n\n\
        踏入2001年，她继续推出了三张单曲：《冰冷的海／Start in my life》、《Stand Up》、《always》，皆获得数十万的稳定销量。\n\n\
        同年她于立命馆宇治高等学校毕业，并入读立命馆大学産业社会学部人间文化课程。\n\n\
        7月4日，推出第二张个人专辑《Perfect Crime》，销量旋即突破百万，达到131万张。8月19日至9月4日，举办了与爽健美茶合作的首次个人演唱会“爽健美茶 Natural Breeze 2001 happy live”。\n\n\
        2001年的她仍然具高人气，全年的唱片总销量达二百多万，而总销售额达60亿日元，为当年女性个人歌手第4。";
    [view addSubview:tip2];
    [tip2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tip1).offset(3);
        make.right.equalTo(line).offset(-3);
        make.top.equalTo(line).offset(5);
    }];
    
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tip2).offset(10);
    }];
}


@end
