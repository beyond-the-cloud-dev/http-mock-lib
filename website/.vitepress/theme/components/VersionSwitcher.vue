<script setup>
import { computed } from 'vue'
import { useRoute } from 'vitepress'
import VPFlyout from 'vitepress/dist/client/theme-default/components/VPFlyout.vue'
import VPMenuLink from 'vitepress/dist/client/theme-default/components/VPMenuLink.vue'
import VPNavScreenMenuGroup from 'vitepress/dist/client/theme-default/components/VPNavScreenMenuGroup.vue'

const props = defineProps({
  latest: { type: String, required: true },
  versions: { type: Array, required: true },
  pages: { type: Object, required: true },
  screenMenu: { type: Boolean, default: false }
})

const route = useRoute()

const current = computed(
  () => props.versions.find((v) => route.path.startsWith(`/${v}/`)) ?? props.latest
)

/** Current route with its version prefix stripped: `/1.2.0/api/headers` -> `/api/headers`. */
const currentPage = computed(() => {
  const path = route.path.replace(/\.html$/, '')
  return current.value === props.latest ? path : path.slice(`/${current.value}`.length) || '/'
})

function linkFor(version) {
  const isLatest = version === props.latest
  const prefix = isLatest ? '' : `/${version}`
  const known = props.pages[isLatest ? 'latest' : version] ?? []

  // Fall back to the version's home page when this page does not exist there.
  return known.includes(currentPage.value) ? `${prefix}${currentPage.value}` : `${prefix}/`
}

const items = computed(() =>
  [props.latest, ...props.versions].map((version) => ({
    text: version === props.latest ? `${version} (latest)` : version,
    link: linkFor(version)
  }))
)
</script>

<template>
  <VPNavScreenMenuGroup v-if="screenMenu" :text="`Version: ${current}`" :items="items" />

  <VPFlyout v-else class="VPVersionSwitcher" :button="current" label="Switch version">
    <div class="items">
      <VPMenuLink v-for="item in items" :key="item.link" :item="item" />
    </div>
  </VPFlyout>
</template>

<style scoped>
.VPVersionSwitcher {
  display: flex;
  align-items: center;
}
</style>
