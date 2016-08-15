//
//  CQRootViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/10/28.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQRootViewController.h"
#import "ZYMenuController.h"
#import "MyTableViewCell.h"
#import "PopViewLikeQQView.h"
#import "CQScanLifeViewController.h"

@interface CQRootViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segues;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * sectionArray;
@property(nonatomic,strong)NSMutableArray * rowInSectionArray;
@property(nonatomic,strong)NSMutableArray * selectedArray;
@property(nonatomic,strong)NSMutableArray * titleArray;
@property(nonatomic,assign)NSInteger flag;
@end

@implementation CQRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeUI];
    _flag=0;
    _sectionArray = [NSMutableArray arrayWithObjects:@"First",@"Second", nil];//每个分区的标题
    _rowInSectionArray = [NSMutableArray arrayWithObjects:@"3",@"2", nil];//每个分区中cell的个数
    _selectedArray = [NSMutableArray arrayWithObjects:@"0",@"0", nil];//这个用于判断展开还是缩回当前section的cell
    _titleArray = [NSMutableArray arrayWithObjects:@"标题1",@"标题2",@"标题3", nil];
    
//    self.dataArray=[[NSMutableArray alloc]init];
//    for (int i=0; i<30; i++) {
//        
//        [self.dataArray addObject:[NSString stringWithFormat:@"第%d行",i]];
//    }
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_flag==1) {
        if (indexPath.section==0 && (indexPath.row==2 ||indexPath.row==3)) {
            static NSString * identifier=@"cell";
            MyTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell=[[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
             cell.label.text = _titleArray[indexPath.row];
            return cell;
        }else{
            static NSString * identifier=@"cell1";
            UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.textLabel.text=_titleArray[indexPath.row];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }else{
        static NSString * identifier=@"cell2";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text=[_titleArray objectAtIndex:indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return  cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0 && indexPath.row==1 && _flag==0) {
        /**
          * 当点击第二行时,刷新数据出现新的行
          */
        _rowInSectionArray=[NSMutableArray arrayWithObjects:@"5",@"2", nil];
        _titleArray=[NSMutableArray arrayWithObjects:@"标题1",@"标题2",@"标题2下属1",@"标题2下属2",@"标题3", nil];
        [self.tableView reloadData];
        _flag=1;
    }else if (indexPath.section==0 && indexPath.row==1 && _flag==1){
        /**
         * 当点击第二行时,删除第3和第四行,并伴随动画
         */
        _rowInSectionArray=[NSMutableArray arrayWithObjects:@"3",@"2", nil];
        _titleArray =[NSMutableArray arrayWithObjects:@"标题1",@"标题2",@"标题3", nil];
        NSIndexPath * path1=[NSIndexPath indexPathForRow:2 inSection:0];
        NSIndexPath * path2=[NSIndexPath indexPathForRow:3 inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[path1,path2] withRowAnimation:UITableViewRowAnimationFade];
        _flag=0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断section的标记是否为1,如果是说明为展开,就返回真实个数,如果不是就说明是缩回,返回0.
    if ([_selectedArray[section] isEqualToString:@"1"]) {
        return [_rowInSectionArray[section] integerValue];
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.sectionArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (void)changeUI{
    self.segues.layer.cornerRadius=8;
    self.segues.clipsToBounds=YES;
}
/**
 *  区头的内容
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH_, 40)];
    sectionView.backgroundColor=[UIColor grayColor];
    UIButton * sectionButton=[UIButton buttonWithType:UIButtonTypeCustom];
    sectionButton.frame=sectionView.frame;
    [sectionButton setTitle:[_sectionArray objectAtIndex:section] forState:UIControlStateNormal];
    [sectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    sectionButton.tag=section+1000;
    [sectionView addSubview:sectionButton];
    return sectionView;
}
/**
 *  区头的点击事件
 *
 *  @param btn
 */
- (void)buttonAction:(UIButton*)btn{
    if ([_selectedArray[btn.tag-1000] isEqualToString:@"0"]) {
        [_selectedArray replaceObjectAtIndex:btn.tag-1000 withObject:@"1"];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag-1000] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
        [_selectedArray replaceObjectAtIndex:btn.tag-1000 withObject:@"0"];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag-1000] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(id)sender {
    ZYMenuController * menu=self.menuController;
    [menu showLeftViewController:YES];
}
- (IBAction)segument:(id)sender {
    UISegmentedControl * segment=(UISegmentedControl *)sender;
    switch (segment.selectedSegmentIndex) {
        case 0:{
            NSLog(@"消息");
        }
            break;
        case 1:{
            NSLog(@"电话");
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)addButtonClick:(id)sender {
    CGPoint point = CGPointMake(1, 0);
    [PopViewLikeQQView configCustomPopViewWithFrame:CGRectMake(210, 64, 150, 200) imagesArr:@[@"saoyisao.png",@"jiahaoyou.png",@"taolun.png",@"diannao.png",@"diannao.png",@"shouqian.png"] dataSourceArr:@[@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱"] anchorPoint:point seletedRowForIndex:^(NSInteger index) {
        NSLog(@"%ld", index + 1);
        
        if (index==0) {
            CQScanLifeViewController * vc=[[CQScanLifeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } animation:YES timeForCome:0.2 timeForGo:0.3];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
