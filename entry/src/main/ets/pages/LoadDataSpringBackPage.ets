import { LitheRefresh, RefreshController } from '@abner/lithe_refresh'
import { ActionBar } from '@abner/bar'
import router from '@ohos.router'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/11/13
 * INTRODUCE:底部上拉加载数据不回弹
 * */
@Entry
@Component
struct LoadDataSpringBackPage {
  @State testArray: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  scroller: Scroller = new Scroller()
  controller: RefreshController = new RefreshController()

  @Builder
  itemLayout(_this: LoadDataSpringBackPage) {
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

      ActionBar({
        title: "底部上拉加载数据不回弹",
        leftText: "返回",
        onLeftClick: () => {
          router.back()
        },
      })

      LitheRefresh({
        scroller: this.scroller,
        controller: this.controller,
        slideDisplayLoadData: true, //底部不回弹
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
            for (let i = 10; i < 20; i++) {
              this.testArray.push(i)
            }
            this.controller.finishLoadMore()
          }, 2000)
        }
      })
    }
  }
}