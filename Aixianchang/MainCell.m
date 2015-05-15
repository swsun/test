//
//  MainCell.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/19.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "MainCell.h"
#import "NewsModel.h"

@interface MainCell ()
@property (strong, nonatomic) UILabel *lblFree;
@property (strong, nonatomic) UILabel *lblDate;
@property (strong, nonatomic) UILabel *lblCategory;
@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) UILabel *lblPublisher;
@property (strong, nonatomic) UILabel *lblContent;
@property (strong, nonatomic) UIImageView *imgView;
@end

@implementation MainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        [_imgView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 5, 120));
        }];
        
        _lblFree = [UILabel new];
        _lblFree.font = FONT9;
        _lblFree.text = @"免费";
        _lblFree.textAlignment = NSTextAlignmentCenter;
        _lblFree.textColor = TextColor;
        _lblFree.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_lblFree];
        [_lblFree makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(1);
            make.width.equalTo(@40);
            make.height.equalTo(@14);
        }];
        
        _lblDate = [UILabel new];
        _lblDate.font = FONT9;
        _lblDate.textAlignment = NSTextAlignmentCenter;
        _lblDate.textColor = [UIColor blackColor];
        [self.contentView addSubview:_lblDate];
        [_lblDate makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.mas_right);
            make.top.equalTo(self.contentView);
            make.width.equalTo(@70);
            make.height.equalTo(@15);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@2);
        }];
        
        UIView *line2 = [UIView new];
        line2.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:line2];
        [line2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
//            make.top.equalTo(self.contentView);
            make.bottom.equalTo(_imgView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@2);
        }];
        
        _lblCategory = [UILabel new];
        _lblCategory.font = FONT9;
        _lblCategory.textAlignment = NSTextAlignmentCenter;
        _lblCategory.textColor = [UIColor whiteColor];
        _lblCategory.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_lblCategory];
        [_lblCategory makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.width.equalTo(@50);
            make.height.equalTo(@15);
        }];
        
        _lblTitle = [UILabel new];
        _lblTitle.font = FONT12;
        _lblTitle.textColor = [UIColor blackColor];
        [self.contentView addSubview:_lblTitle];
        [_lblTitle makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgView.mas_right).offset(10);
            make.top.equalTo(self.contentView).offset(20);
        }];
        
        _lblPublisher = [UILabel new];
        _lblPublisher.font = FONT10;
        _lblPublisher.textColor = UIColorFromRGB(0x646464);
        [self.contentView addSubview:_lblPublisher];
        [_lblPublisher makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lblTitle);
            make.top.equalTo(_lblTitle.mas_bottom).offset(3);
        }];
        
        _lblContent = [UILabel new];
        _lblContent.numberOfLines = 3;
        _lblContent.font = FONT11;
        _lblContent.textColor = UIColorFromRGB(0x868686);
        [self.contentView addSubview:_lblContent];
        [_lblContent makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lblTitle);
            make.top.equalTo(_lblPublisher.mas_bottom).offset(6);
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NewsModel *)model
{
    _model = model;
//    _imgView.image = [UIImage imageNamed:@"17"];
    
//    _lblFree.text = @"免费";
//    _lblDate.text = @"今天/MON";
//    _lblCategory.text = @"舞台剧";
//    _lblTitle.text = @"这辈子有过你";
//    _lblPublisher.text = @"念剧场出品";
//    _lblContent.text = @"撒地方啦忘记啤酒我怕额没打牌吗破额妈妈的的名片我们的哦陪恶魔的";
    
    if (_model.isfree) {
        _lblFree.hidden = NO;
    }else
        _lblFree.hidden = YES;
    
    _lblTitle.text = _model.title;
    _lblPublisher.text = _model.director;
    _lblContent.text = _model.summary;
    _lblDate.text = _model.showtime;
    _lblCategory.text = [[NewsModel NewsCategoryNames] objectAtIndex:_model.category - 1];
    [_imgView sd_setImageWithURL:_model.stagePicture];
}

@end
