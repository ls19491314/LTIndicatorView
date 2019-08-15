# LTIndicatorView

## Requirements

* iOS 8.0+
* Xcode 8.0+

## Install

* pod 'LTIndicatorView'


### UIScrollView 的扩展

### 只需要一行代码，就能实现自定义UIScrollView,TableView,UICollectionView的指示器功能！

```ogdl
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIImage *image= [UIImage imageNamed:@"xxxx"];
   [self.tableView registerILSIndicator:image imageSize:CGSizeMake(xx, xx)];
}
 !!! 由于需要确定LTIndicatorView位置，所以注册时需要知道LTIndicatorView 的frame，所以在viewDidLayoutSubviews调用了


```
