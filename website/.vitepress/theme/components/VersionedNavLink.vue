<script setup>
import { computed } from 'vue'
import { useRoute } from 'vitepress'
import VPNavBarMenuLink from 'vitepress/dist/client/theme-default/components/VPNavBarMenuLink.vue'
import VPNavScreenMenuLink from 'vitepress/dist/client/theme-default/components/VPNavScreenMenuLink.vue'

const props = defineProps({
  text: { type: String, required: true },
  link: { type: String, required: true },
  versions: { type: Array, required: true },
  screenMenu: { type: Boolean, default: false }
})

const route = useRoute()

/** Keeps top-level nav inside the version the reader is currently browsing. */
const item = computed(() => {
  const version = props.versions.find((v) => route.path.startsWith(`/${v}/`))
  const link = version ? `/${version}${props.link}` : props.link

  return { text: props.text, link, activeMatch: link }
})
</script>

<template>
  <VPNavScreenMenuLink v-if="screenMenu" :item="item" />
  <VPNavBarMenuLink v-else :item="item" />
</template>
