import { h } from 'vue'
import DefaultTheme from 'vitepress/theme'
import BTCFooter from './components/BTCFooter.vue'
import VersionBanner from './components/VersionBanner.vue'
import './custom.css'

export default {
  extends: DefaultTheme,
  Layout() {
    return h(DefaultTheme.Layout, null, {
      'layout-top': () => h(VersionBanner)
    })
  },
  enhanceApp({ app }) {
    app.component('BTCFooter', BTCFooter)
  }
}
