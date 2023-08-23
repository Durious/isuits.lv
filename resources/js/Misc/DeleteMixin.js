import { humanize, pluralize, titleize } from 'inflection';
import DialogModal from '@/Jetstream/DialogModal.vue';

function deleteMethods(m, mm) {
  const uriName = pluralize(m);
  // const model = capitalize(m);
  const model = titleize(humanize(m));
  if (mm) {
    m = mm;
  }
  return {
    data() {
      return { Id: '' };
    },
    methods: {
      destroy() {
        console.log('DialogModal');
        this.$vfm.show('dialog', {
          title: this.$t('delete_x', { x: this.$tc(model) }),
          text: this.$t('ask_delete_x', { x: this.$tc(model) }),
          buttons: [
            {
              title: 'Yes',
              class: 'px-6 py-3 bg-gray-200 hover:bg-gray-400',
              handler: () => {
                this.$vfm.hide('dialog');
                this.$inertia.delete(this.route(uriName + '.destroy', this[m].id));
              },
            },
            {
              title: 'No',
              class: 'px-6 py-3 border-l bg-gray-200 hover:bg-gray-400',
            },
          ],
        });
      },
      destroyPermanently() {
        this.$vfm.show('dialog', {
          title: this.$t('Delete Permanently'),
          text: this.$t('ask_final_delete_x', { x: this.$tc(model) }),
          buttons: [
            {
              title: 'Yes',
              class: 'px-6 py-3 bg-gray-200 hover:bg-gray-400',
              handler: () => {
                this.$vfm.hide('dialog');
                this.$inertia.delete(this.route(uriName + '.delete', this[m].id));
              },
            },
            {
              title: 'No',
              class: 'px-6 py-3 border-l bg-gray-200 hover:bg-gray-400',
            },
          ],
        });
      },
      restore() {
        console.log('12312312')
        this.$vfm.show('dialog', {
          title: this.$t('retore_x', { x: this.$tc(model) }),
          text: this.$t('ask_retore_x', { x: this.$tc(model) }),
          buttons: [
            {
              title: 'Yes',
              class: 'px-6 py-3 bg-gray-200 hover:bg-gray-400',
              handler: () => {
                this.$vfm.hide('dialog');
                this.$inertia.put(this.route(uriName + '.restore', this[m].id));
              },
            },
            {
              title: 'No',
              class: 'px-6 py-3 border-l bg-gray-200 hover:bg-gray-400',
            },
          ],
        });
      },
    },
  };
}

export default deleteMethods;
