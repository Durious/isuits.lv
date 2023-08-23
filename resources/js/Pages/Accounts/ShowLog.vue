<template>
  <div v-if="log" class="w-full h-full flex items-center overflow-auto">
    <div class="w-full max-w-2xl mx-auto bg-white rounded shadow-lg leading-normal my-auto animate zoomIn">
      <div class="flex items-center px-4 py-3 border-b">
        <h4 class="font-bold">{{ log.id }}: {{ log.description }}</h4>
        <a class="modal-close ltr:ml-auto rtl:mr-auto cursor-pointer" @click="$emit('close')">
          <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
            <path
              d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"
            ></path>
          </svg>
        </a>
      </div>
      <div class="p-6 overflow-x-auto scroll-on-light">
        <h4 class="text-lg font-bold">{{ $t('Subject') }}</h4>
        <pre>{{ log.subject }}</pre>
        <h4 class="text-lg font-bold">{{ $t('Properties') }}</h4>
        <pre>{{ log.properties }}</pre>
      </div>
      <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 rounded-b">
        <button @click="$emit('close')" class="btn-gray px-4 py-2 ltr:ml-auto rtl:mr-auto flex items-center">
          {{ $t('Close') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: { log: Object },
};
</script>
