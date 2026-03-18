## 介绍

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/abner.jpg" width="100px" /><br/>
<span style="font-size:12px;color:red;">扫码关注，千帆起航，共筑鸿蒙！</span>
</p>

lithe_refresh是一个轻盈的上拉下拉刷新组件，无任何耦合，支持List、Grid，WaterFlow，支持各种任意组件刷新!

### 特点

由于是一个轻量级的刷新组件，和其它组件结合使用无任何耦合关系，这是HarmonyOsLitheRefresh的独有特点！

### 使用须知

如果您想实现一些较为复杂的效果，比如拖拽，侧滑删除，二楼，吸顶等等效果，您可以使用我的另一个全能刷新组件refresh,地址：[点击直达](https://ohpm.openharmony.cn/#/cn/detail/@abner%2Frefresh)

### 目前支持功能

- 1、支持List、Grid，WaterFlow，支持各种任意组件下来刷新。
- 2、支持List、Grid，WaterFlow，支持各种任意组件上拉加载。
- 3、支持web组件下拉刷新和上拉加载。
- 4、支持自定义下拉刷新和上拉加载样式。
- 5、支持上拉加载无数据和无数据固定等样式展示。
- 6、支持无阻尼，有阻尼，最大阻尼条件设置。
- 7、支持自动下拉刷新，自动上拉加载等功能触发。
- 8、支持多视图，自定义高度。

## 效果

### 所有功能

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/refresh/lithe_refresh_20251029001.png" width="300px" />
</p>

### 刷新效果
<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/refresh/lithe_100.png" width="200px" />
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/refresh/lithe_101.png" width="200px" />
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/refresh/lithe_102.png" width="200px" />
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/refresh/lithe_103.png" width="200px" />
</p>

## Api支持版本

Api版本：>=12

## 快速使用

方式一：在Terminal窗口中，执行如下命令安装三方包，DevEco Studio会自动在工程的oh-package.json5中自动添加三方包依赖。

**建议：在使用的模块路径下进行执行命令。**

```
ohpm install @abner/lithe_refresh
```

方式二：在工程的oh-package.json5中设置三方包依赖，配置示例如下：

```
"dependencies": { "@abner/lithe_refresh": "^1.0.6"}
```

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/refresh/lithe_001.png" width="300"></p>


### 查看是否引用成功

无论使用哪种方式进行依赖，最终都会在使用的模块中，生成一个oh_modules文件，并创建源代码文件，有则成功，无则失败，如下：

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/refresh/lithe_002.png" width="300"></p>

## 代码使用

目前提供了两个自定义组件，一个是LitheRefresh组件，一个是RefreshView组件，两个都可以实现下拉和上拉功能，RefreshView组件是在系统Refresh组件基础
之上封装的，看大家的需求进行对应选择使用。

只需要包裹您想刷新的任意组件，相对比较灵活，如果您想实现懒加载数据模式，建议结合提供的**RefreshDataSource**，可以让您实现更加方便。

**须知**：如果是包裹的可滑动组件，比如List，Grid，WaterFlow等，需要配合nestedScroll属性！

### 简单使用

```typescript
controller: RefreshController = new RefreshController()

//任意组件，可以是List、Grid，WaterFlow ……
@Builder
itemLayout() {
  Column() {
   
  }.width("100%")
    .height("100%")
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
}

LitheRefresh({
        itemLayout: this.itemLayout,
        controller: this.controller,
        onRefresh: () => {
          //下拉刷新
          this.controller.finishRefresh()
        },
        onLoadMore: () => {
          //加载更多
          this.controller.finishLoadMore()
        }
      })
```

### List使用

```typescript
@Entry
@Component
struct ListUpAndDownPage {
  @State testArray: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  scroller: Scroller = new Scroller()
  controller: RefreshController = new RefreshController()

  @Builder
  itemLayout(_this: ListUpAndDownPage) {
    List({ scroller: _this.scroller, space: 20 }) {
      ForEach(_this.testArray, (item: number) => {
        ListItem() {
          Text('' + item)
            .width('100%')
            .height(80)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .backgroundColor(0xFFFFFF)
            .border({ width: 2, color: Color.Pink })
        }
      }, (item: string, index: number) => JSON.stringify(item) + "_" + index)
    }
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .width("100%")
    .height("100%")
    .padding({ left: 20, right: 20 })
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.PARENT_FIRST
    })
  }

  build() {
    Column() {
      
      LitheRefresh({
        scroller: this.scroller,
        controller: this.controller,
        itemLayout: () => {
          this.itemLayout(this)
        },
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            this.controller.finishRefresh()
          }, 2000)
        },
        onLoadMore: () => {
          //上拉加载
          setTimeout(() => {
            this.testArray.push(13)
            this.testArray.push(14)
            this.controller.finishLoadMore()
          }, 2000)
        }
      })
    }
  }
}
```

### Grid使用

```typescript
@Entry
@Component
struct GridUpAndDownPage {
  @State testArray: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  scroller: Scroller = new Scroller()
  controller: RefreshController = new RefreshController()

  @Builder
  itemLayout(_this: GridUpAndDownPage) {
    Grid(_this.scroller) {
      ForEach(_this.testArray, (item: number) => {
        GridItem() {
          Text('' + item)
            .width('100%')
            .height(80)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .backgroundColor(0xFFFFFF)
            .border({ width: 2, color: Color.Pink })
        }
      }, (item: string, index: number) => JSON.stringify(item) + "_" + index)
    }
    .columnsTemplate("1fr 1fr")
    .columnsGap(10)
    .rowsGap(10)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .width("100%")
    .height("100%")
    .padding({ left: 20, right: 20 })
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.PARENT_FIRST
    })
  }

  build() {
    Column() {

      ActionBar({
        title: "Grid组件刷新",
        barBackgroundColor: Color.Red,
        leftText: "返回",
        onLeftClick: () => {
          router.back()
        },
      })

      LitheRefresh({
        scroller: this.scroller,
        controller: this.controller,
        itemLayout: () => {
          this.itemLayout(this)
        },
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            this.controller.finishRefresh()
          }, 2000)
        },
        onLoadMore: () => {
          //上拉加载
          setTimeout(() => {
            this.testArray.push(13)
            this.testArray.push(14)
            this.controller.finishLoadMore()
          }, 2000)
        }
      })
    }
  }
}
```

### WaterFlow使用

这里没有使用提供RefreshDataSource，所以懒加载方式比较冗余，为了简洁代码，建议使用我提供的RefreshDataSource，可以让您的效率极大提升。

具体RefreshDataSource使用方式，可以查看Demo中LazyDataOperationPage页面。

```typescript
@Entry
@Component
struct WaterFlowUpAndDownPage {
  scroller: Scroller = new Scroller()
  controller: RefreshController = new RefreshController()

  @Builder
  itemLayout(_this: WaterFlowUpAndDownPage) {
    WaterFlowView({
      scroller: _this.scroller
    })
  }

  build() {
    Column() {

      LitheRefresh({
        scroller: this.scroller,
        controller: this.controller,
        itemLayout: () => {
          this.itemLayout(this)
        },
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            this.controller.finishRefresh()
          }, 2000)
        },
        onLoadMore: () => {
          //上拉加载
          setTimeout(() => {
            this.controller.finishLoadMore()
          }, 2000)
        }
      })
    }
  }
}


@Component
struct WaterFlowView {
  @State minSize: number = 80
  @State maxSize: number = 180
  @State fontSize: number = 24
  @State colors: number[] = [0xFFC0CB, 0xDA70D6, 0x6B8E23, 0x6A5ACD, 0x00FFFF, 0x00FF7F]
  scroller: Scroller = new Scroller()
  dataSource: WaterFlowDataSource = new WaterFlowDataSource()
  private itemWidthArray: number[] = []
  private itemHeightArray: number[] = []

  // 计算FlowItem宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  // 设置FlowItem的宽/高数组
  setItemSizeArray() {
    for (let i = 0; i < 30; i++) {
      this.itemWidthArray.push(this.getSize())
      this.itemHeightArray.push(this.getSize())
    }
  }

  aboutToAppear() {
    this.setItemSizeArray()
  }

  build() {
    WaterFlow({ scroller: this.scroller }) {
      LazyForEach(this.dataSource, (item: number) => {
        FlowItem() {
          Column() {
            Text("N" + item).fontSize(12).height('16')
          }
        }
        .width('100%')
        .height(this.itemHeightArray[item % 30])
        .backgroundColor(this.colors[item % 5])
      }, (item: string) => item)
    }
    .columnsTemplate("1fr 1fr")
    .columnsGap(10)
    .rowsGap(5)
    .backgroundColor(0xFAEEE0)
    .width('100%')
    .height('100%')
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.PARENT_FIRST
    })
  }
}

// 实现IDataSource接口的对象，用于瀑布流组件加载数据
export class WaterFlowDataSource implements IDataSource {
  private dataArray: number[] = []
  private listeners: DataChangeListener[] = []

  constructor() {
    for (let i = 0; i < 30; i++) {
      this.dataArray.push(i)
    }
  }

  // 获取索引对应的数据
  public getData(index: number): number {
    return this.dataArray[index]
  }

  // 通知控制器数据重新加载
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }

  // 通知控制器数据增加
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }

  // 通知控制器数据变化
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index)
    })
  }

  // 通知控制器数据删除
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index)
    })
  }

  // 通知控制器数据位置变化
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to)
    })
  }

  //通知控制器数据批量修改
  notifyDatasetChange(operations: DataOperation[]): void {
    this.listeners.forEach(listener => {
      listener.onDatasetChange(operations);
    })
  }

  // 获取数据总数
  public totalCount(): number {
    return this.dataArray.length
  }

  // 注册改变数据的控制器
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  // 注销改变数据的控制器
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }

  // 增加数据
  public add1stItem(): void {
    this.dataArray.splice(0, 0, this.dataArray.length)
    this.notifyDataAdd(0)
  }

  // 在数据尾部增加一个元素
  public addLastItem(): void {
    this.dataArray.splice(this.dataArray.length, 0, this.dataArray.length)
    this.notifyDataAdd(this.dataArray.length - 1)
  }

  // 在指定索引位置增加一个元素
  public addItem(index: number): void {
    this.dataArray.splice(index, 0, this.dataArray.length)
    this.notifyDataAdd(index)
  }

  // 删除第一个元素
  public delete1stItem(): void {
    this.dataArray.splice(0, 1)
    this.notifyDataDelete(0)
  }

  // 删除第二个元素
  public delete2ndItem(): void {
    this.dataArray.splice(1, 1)
    this.notifyDataDelete(1)
  }

  // 删除最后一个元素
  public deleteLastItem(): void {
    this.dataArray.splice(-1, 1)
    this.notifyDataDelete(this.dataArray.length)
  }

  // 在指定索引位置删除一个元素
  public deleteItem(index: number): void {
    this.dataArray.splice(index, 1)
    this.notifyDataDelete(index)
  }

  // 重新加载数据
  public reload(): void {
    this.dataArray.splice(1, 1)
    this.dataArray.splice(3, 2)
    this.notifyDataReload()
  }
}
```

### 属性介绍

#### LitheRefresh

| 属性                       | 类型                                          | 概述                          |
|--------------------------|---------------------------------------------|-----------------------------|
| itemLayout               | () => void                                  | 子布局，可以是任意布局,List/Grid/Other |
| headerRefreshLayout      | (status: RefreshLayoutStatusModel) => void  | 头部下拉布局……                    |
| footerLoadLayout         | (status: LoadMoreLayoutStatusModel) => void | 尾部加载布局……                    |
| onRefresh                | () => void                                  | 下拉刷新                        |
| onLoadMore               | () => void                                  | 上拉加载                        |
| enableRefresh            | boolean                                     | 是否禁止刷新                      |
| enableLoadMore           | boolean                                     | 是否禁止上拉加载                    |
| refreshHeaderAttribute   | (attribute: RefreshHeaderAttr) => void      | 刷新头属性设置                     |
| loadMoreFooterAttribute  | (attribute: LoadMoreFooterAttr) => void     | 加载尾部属性                      |
| scroller                 | Scroller                                    | 外部可滑动组件必传递                  |
| controller               | RefreshController                           | 刷新控制器                       |
| isScrollSpring           | boolean                                     | 是否是阻尼效果，默认是阻尼效果             |
| maxRefreshSpringDistance | number                                      | 最大刷新阻尼距离                    |
| maxLoadSpringDistance    | number                                      | 最大加载阻尼距离                    |
| isPullUpProhibitTouch    | boolean                                     | 加载是否禁止手势，默认禁止               |
| isPullDownProhibitTouch  | boolean                                     | 刷新是否禁止手势，默认禁止               |
| slideDisplayLoadData     | boolean                                     | 滑动显示加载数据                    |
| isScrollBottom           | boolean                                     | 是否滑动了底部                     |

#### RefreshView

| 属性                       | 类型                                          | 概述                          |
|--------------------------|---------------------------------------------|-----------------------------|
| itemLayout               | () => void                                  | 子布局，可以是任意布局,List/Grid/Other |
| headerRefreshLayout      | (status: RefreshLayoutStatusModel) => void  | 头部下拉布局……                    |
| footerLoadLayout         | (status: LoadMoreLayoutStatusModel) => void | 尾部加载布局……                    |
| onRefresh                | () => void                                  | 下拉刷新                        |
| onLoadMore               | () => void                                  | 上拉加载                        |
| enableRefresh            | boolean                                     | 是否禁止刷新                      |
| enableLoadMore           | boolean                                     | 是否禁止上拉加载                    |
| refreshHeaderAttribute   | (attribute: RefreshHeaderAttr) => void      | 刷新头属性设置                     |
| loadMoreFooterAttribute  | (attribute: LoadMoreFooterAttr) => void     | 加载尾部属性                      |
| controller               | RefreshController                           | 刷新控制器                       |
| isScrollSpring           | boolean                                     | 是否是阻尼效果，默认是阻尼效果             |
| maxRefreshSpringDistance | number                                      | 最大刷新阻尼距离                    |
| maxLoadSpringDistance    | number                                      | 最大加载阻尼距离                    |
| isPullUpProhibitTouch    | boolean                                     | 加载是否禁止手势，默认禁止               |
| isPullDownProhibitTouch  | boolean                                     | 刷新是否禁止手势，默认禁止               |
| slideDisplayLoadData     | boolean                                     | 滑动显示加载数据                    |

### 全局初始化

全局初始化，可以动态配置下拉刷新和上拉加载的内容展示，配置后，全局生效，也可以单独进行配置。

```typescript
initRefreshOptions({
      refreshHeaderAttr: (attr) => {
        attr.pullingText = "下拉刷新"
        attr.releaseText = "释放加载"
        //……其他属性
      },
      loadMoreFooterAttr:(attr)=>{
        attr.footerPullingText = "上拉加载中"
        //……其他属性
      }
    })
```

#### 相关属性

RefreshHeaderAttr属性：

| 属性              | 类型                                         | 概述                           |
|-----------------|--------------------------------------------|------------------------------|
| headerType      | RefreshHeaderType                          | 刷新头类型，目前只有DEFAULT和POINTS三点刷新 |
| width           | Length                                     | 刷新头的宽度                       |
| height          | number                                     | 刷新头的高度                       |
| timeFormat      | RefreshHeaderTimeFormat                    | 刷新头的时间格式,默认月日时分              |
| timeLabel       | RefreshHeaderTimeLabel                     | 刷新头的时间标签格式                   |
| hideTime        | boolean                                    | 是否隐藏刷新头时间，默认展示               |
| fontSize        | number/string/ Resource                    | 刷新头的文字大小                     |
| fontColor       | ResourceColor                              | 刷新头的文字颜色                     |
| timeFontSize    | number /string/Resource                    | 刷新头的时间文字大小                   |
| timeFontColor   | ResourceColor                              | 刷新头的时间文字颜色                   |
| marginIconLeft  | Length                                     | 刷新文字距离左边的距离                  |
| iconDown        | PixelMap/ ResourceStr/DrawableDescriptor   | 刷新的下拉箭头                      |
| iconUpLoad      | PixelMap / ResourceStr/ DrawableDescriptor | 下拉刷新icon                     |
| pullingText     | string / Resource                          | 下拉可以刷新的文字内容                  |
| releaseText     | string /Resource                           | 释放立即刷新的文字内容                  |
| refreshingText  | string/Resource                            | 正在刷新中的文字内容                   |
| finishText      | string/Resource                            | 刷新结束的文字内容                    |
| backgroundColor | ResourceColor                              | 背景颜色                         |
| marginBottom    | Length                                     | 距离底部                         |
| iconWidth       | Length                                     | 图片宽度                         |
| iconHeight      | Length                                     | 图片高度                         |

LoadMoreFooterAttr属性：

| 属性                  | 类型                                        | 概述          |
|---------------------|-------------------------------------------|-------------|
| width               | Length                                    | 加载尾的宽度      |
| height              | Length                                    | 加载尾的高度      |
| backgroundColor     | ResourceColor                             | 尾部背景颜色      |
| footerPullingText   | string/Resource                           | 上拉加载文字内容    |
| footerReleaseText   | string/Resource                           | 释放加载文字内容    |
| footerLoadingText   | string/Resource                           | 加载中蚊子内容     |
| footerFinishText    | string/Resource                           | 加载结束文字内容    |
| footerNothingText   | string/Resource                           | 暂时没有数据文字内容  |
| fontColor           | ResourceColor                             | 字体颜色        |
| fontSize            | number /string / Resource                 | 字体大小        |
| fontWeight          | number /FontWeight/ string                | 字重          |
| fontFamily          | string/Resource                           | 字体          |
| loadingSrc          | PixelMap/ ResourceStr/ DrawableDescriptor | loading图片地址 |
| loadingIconWidth    | Length                                    | 加载图片宽度      |
| loadingIconHeight   | Length                                    | 加载图片高度      |
| loadingMarginRight  | Length                                    | 距离右边文字的距离   |

RefreshHeaderTimeFormat类型：

```typescript
  YMDHMS, //年月日时分秒 2024-04-08 08:08:08
  MDHMS, //月日时分秒 04-08 08:08:08
  MDHM, //月日时分秒 04-08 08:08
  HMS //时分秒 08:08:08
```

RefreshHeaderTimeLabel类型：

```typescript
BACKSLASH, //反斜杠 / 2024/04/08 08:08:08
SHORTLINE, //短线 -  2024-04-08 08:08:08
CHARACTERS //文字 年月日 2024年04月08日 08时08分08秒
```


## 更多案例

可以查看相关Demo【右侧仓库地址】。

## 咨询作者

如果您在使用上有问题，解决不了，或者查看精华的鸿蒙技术文章，可扫码进行操作。

<p><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/abner.jpg" width="150"></p>

## License

```
Copyright (C) AbnerMing, lithe_refresh Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
