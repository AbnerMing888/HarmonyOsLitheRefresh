import { ActionBar } from '@abner/bar'
import router from '@ohos.router'
import {
  LoadMoreLayoutStatusModel,
  RefreshController,
  RefreshLayoutStatusModel,
  RefreshView
} from '@abner/lithe_refresh'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/11/13
 * INTRODUCE:自定义刷新头和加载尾，支持多种类型
 * */

@Entry
@Component
struct NewRefreshHeaderAndFooterPage {
  @State testArray: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  scroller: Scroller = new Scroller()
  controller: RefreshController = new RefreshController()

  @Builder
  itemLayout() {
    List({ scroller: this.scroller, space: 20 }) {
      ForEach(this.testArray, (item: number) => {
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

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:自定义刷新头
   * */
  @Builder
  headerRefreshLayout(model: RefreshLayoutStatusModel) {
    Column() {
      Text("" + model.status)
    }.width("100%")
    .height(80)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Pink)
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:自定义刷新尾部
   * */
  @Builder
  footerLoadLayout(model: LoadMoreLayoutStatusModel) {
    Column() {
      Text("" + model.status)
    }.width("100%")
    .height(80)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.Pink)
  }

  build() {
    Column() {
      ActionBar({
        title: "【自定义刷新头和加载尾】",
        leftText: "返回",
        onLeftClick: () => {
          router.back()
        },
      })

      RefreshView({
        scroller: this.scroller,
        controller: this.controller,
        refreshHeaderAttribute: (attr) => {
          attr.height = 80 //刷新头的高度
        },
        headerRefreshLayout: this.headerRefreshLayout,
        footerLoadLayout: this.footerLoadLayout,
        itemLayout: () => {
          this.itemLayout()
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