import { ActionBar } from '@abner/bar';
import router from '@ohos.router';
import { RefreshController, RefreshView } from '@abner/lithe_refresh';

/**
 * AUTHOR:AbnerMing
 * DATE:2024/11/13
 * INTRODUCE:设置沉浸式
 * */
@Entry
@Component
struct NewRefreshImmersivePage {
  controller: RefreshController = new RefreshController()

  @Builder
  itemLayout() {
    Column() {
      Text("我是任意组件")
    }.width("100%")
    .height("100%")
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      Column() {
        ActionBar({
          title: "【任意组件刷新】",
          barBackgroundColor: Color.Pink,
          leftText: "返回",
          onLeftClick: () => {
            router.back()
          },
        })
      }.backgroundColor(Color.Pink)
      .width("100%")
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])


      RefreshView({
        itemLayout: this.itemLayout,
        controller: this.controller,
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            //模拟耗时
            this.controller.finishRefresh()
          }, 2000)
        },
        onLoadMore: () => {
          //加载更多
          setTimeout(() => {
            //模拟耗时
            this.controller.finishLoadMore()
          }, 2000)
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}