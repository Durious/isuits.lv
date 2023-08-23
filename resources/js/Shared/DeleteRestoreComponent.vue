<template>
  <div>
    <Dialog
      :show="confirm"
      :close="closeModal"
      action-text="Delete"
      action-type="delete"
      :action="deleteRecord"
      :title="'Delete ' + model + '!'"
      :content="$t('delete_confirm')"
    />
    <Dialog
      :show="restoreConf"
      action-text="Restore"
      :action="restoreRecord"
      :close="closeRestoreModal"
      :title="'Restore ' + model + '!'"
      :content="$t('restore_confirm')"
    />
    <Dialog
      max-width="md"
      :show="permanent"
      action-type="delete"
      :close="closePermanentModal"
      :title="'Delete ' + model + '!'"
      action-text="Delete Permanently"
      :action="deleteRecordPermanently"
      :content="`<p class='mb-2 leading-relaxed text-red-500'>${$t('permanent_delete_confirm')}</p>
        <p class='leading-relaxed'>${$t('permanent_delete_warning')}</p>`"
    />
    <button v-if="!data.deleted_at" class="text-red-600 hover:underline" tabindex="-1" type="button" @click="destroy">
      {{ $t('delete_x', { x: $tc(model) }) }}
    </button>
    <button v-else-if="permanentEnable" class="text-red-600 hover:underline" tabindex="-1" type="button" @click="destroyPermanently">
      {{ $t('Delete Permanently') }}
    </button>
  </div>
</template>
<script>
import Dialog from '@/Shared/Dialog.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';

export default {
  props: {
    data: {type: Object},
    model: {type: String},
    routeM: {type: String},
    restore: {type: Boolean, default: false},
    permanentEnable: {type: Boolean, default: true}
  },
  components: {
    Dialog,
    LoadingButton,
  },
  data() {
    return { loading: false, confirm: false, restoreConf: false, permanent: false };
  },
  watch: {
    restore: function (v) {
      this.restoreConf = v;
    },
  },
  methods: {
    destroy() {
      this.confirm = true;
    },
    deleteRecord() {
      this.$inertia.delete(route(this.routeM + '.destroy', this.data.id), {
        onSuccess: () => this.closeModal(),
      });
    },
    closeModal() {
      this.confirm = false;
    },
    restoreM() {
      this.restoreConf = true;
    },
    restoreRecord() {
      this.$inertia.put(this.route(this.routeM + '.restore', this.data.id), {
        onSuccess: () => this.closeRestoreModal(),
      });
    },
    closeRestoreModal() {
      this.restoreConf = false;
      this.$emit('close-restore');
    },
    deletePermanently() {
      this.permanent = true;
    },
    deleteRecordPermanently() {
      this.$inertia.delete(route(this.routeM + '.delete', this.data.id), {
        onSuccess: () => this.closePermanentModal(),
      });
    },
    destroyPermanently() {
      this.permanent = true;
    },
    closePermanentModal() {
      this.permanent = false;
    },
  },
}
</script>
