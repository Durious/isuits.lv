<template>
  <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
    <div class="caption-div">
      <label class="form-label">{{ $t('Select Language') }}</label>
      <select class="form-control lang-select" @change="(e) => onSelectAction(e)" :label="$t('Select Language')">
        <option v-for="(item, index) in lang_array" :key="index" :value="item.value">{{ (item.value) }}</option>
      </select>

    </div>
  </div>
  <div class="bg-white rounded shadow overflow-hidden max-w-3xl content-panel">
    <div class="editor-title">
      <p>SET LANGUAGE KEYS & VALUES</p>
    </div>
    <div class="editor-header">
      <form class="lang-item">
        <div class="lang-index header">Main Languages</div>
        <div class="lang-value header">Translated Languages</div>
      </form>
    </div>
    <div id="json-list">
      <div class="lang-item" v-for="(item, index) in lang_content" :key="index">
        <input class="lang-index" :value="index" @click="getKey" @change="setKey">
        <input :value="item" :name="index" class="lang-value" @click="getValue" @change="$event => onChangeForm($event)">
        <button :value="item" @click="removeItem(index)" :name="index"
          class="px-4 py-2 bg-red-500 hover:bg-red-700 focus:outline-none rounded-md font-medium text-white fill-white flex items-center">
          <icons name="cross" class="w-6 h-6 sm:mr-2" />
        </button>
      </div>
    </div>
    <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
      <loading-button class="btn-gray ltr:ml-auto rtl:mr-auto" @click="newLang">
        {{ $t('Add More Field') }}
      </loading-button>
    </div>
    <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
      <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" @click="saveLang">
        {{ $t('Submit') }}
      </loading-button>
    </div>
  </div>
</template>
<style>
.header {
  font-size: 1.2em;
  font-weight: 600;
}

.option-pane {
  width: 7em;
  display: flex;
  justify-content: center;
}

.editor-title {
  justify-content: center;
  display: flex;
  font-size: 1.5em;
  margin-top: 0.5em;
  font-weight: 700;
}

.editor-header {
  margin-top: 1em;
}

.lang-label {
  line-height: 2em;
}

.lang-action {
  border-radius: 1em;
  height: 2em;
  font-size: 15px;
  padding: 0 5px 0 15px;
  width: 7em;
  background-color: mediumblue;
  color: blanchedalmond;
}

.lang-select {
  width: 80%;
  margin-left: 2em;
  padding: 0 5px 0 15px;
  border-radius: 0.7em;
  height: 2em;
}

.content-panel {
  margin-top: 1em;
  padding: 1em;
  min-height: 30em;
}

.caption-div {
  background-color: white;
  padding: 10px;
  display: block;
}

.lang-item {
  justify-content: space-between;
  display: flex;
  padding: 10px 20px;
}

.lang-caption {
  background-color: lightgray;
  padding: 10px 20px;
  display: flex;
  width: 100%;
  justify-content: space-between;
}

.lang-index {
  width: 40%;
  font-size: 1.4em;
}

.lang-value {
  width: 50%;
  font-size: 1.4em;
}
</style>
<script>
import TextInput from '@/Shared/TextInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import Button from '@/Jetstream/Button.vue';
import _ from "lodash";

export default {
  components: { TextInput, LoadingButton, Button },
  props: { lang_array: [] },
  data() {
    return {
      errors: {},
      sending: false,
      lang_json: [],
      lang_array: [],
      lang_content: [],
      form: {},
      current_index: '',
      current_value: '',
      current_lang: 'en',
      lang: '',
      new_index: 0,
      current_key: '',
      new_key: '',
      input_valid: 1
    }
  },
  mounted() {
    this.getLanguages();
    this.selectLang("en");
  },
  methods: {
    newLang() {
      if (this.lang_content.hasOwnProperty("newField")) {
        alert("You should delete or modify the key 'newField'. Please retry.");
        return;
      } else {

      }
      this.lang_content = {
        ...this.lang_content,
        "newField": ""
      }
      // this.lang_content.push({"newField": ""});
    },
    removeItem(index) {
      delete this.lang_content[index];
    },
    saveLang() {
      this.sending = true;
      this.errors = {};
      console.log(this.current_lang);
      console.log(this.lang_content);
      this.$inertia.post(this.route('settings.save_language'), { data: this.lang_content, lang: this.current_lang }, {
        onError: (response) => {
          this.errors = response
          this.sending = false
        },
        onFinish: () => {
          this.sending = false
        },
      });
    },
    getLanguages() {
      fetch(this.route('settings.get_languages')).then(res => {
        res.json().then(data => {
          var langs = data;
          for (let i = 0; i < langs.length; i++) {
            this.lang_array.push({ value: langs[i].toUpperCase() });
          }
        });
      });
    },
    selectLang(string) {
      var lang = string;
      fetch(this.route('settings.get_lang_json', { lang })).then(res => {
        res.json().then(data => {
          this.lang_content = data;
        });
      });
    },
    submitSaveLang(e) {
      console.log(this.current_index, this.current_value);
      console.log(this.form)
      if (this.current_lang == "en") {
        enJson[this.current_index] = this.current_value;
      } else if (this.current_lang == "lv") {
        lvJson[this.current_index] = this.current_value;
      }
    },
    getValue(e) {
      this.form[e.target.name] = e.target.value
      this.current_index = e.target.name;
    },
    onChangeForm(e) {
      this.lang_content[e.target.name] = e.target.value;
      this.form[e.target.name] = e.target.value;
      this.current_value = e.target.value;
    },
    onSelectAction(e) {
      var prop_string = e.target.value;
      console.log(prop_string);
      this.current_lang = prop_string;
      this.selectLang(this.current_lang);
    },
    onChangeNewIndex(e) {
      var new_index = "val";
      console.log(new_index);
    },
    onChangeNewValue(e) {
      console.log(e.target.name);
    },
    getKey(e) {
      if (this.input_valid == 1) {
        this.current_key = e.target.value;
        console.log(this.current_key);
      }

    },
    setKey(e) {
      if (e.target.value == "") {
        alert("The key you input is empty. Please input valid key!");
        this.input_valid = 0;
        return;
      } else if (this.lang_content.hasOwnProperty(e.target.value)) {
        alert("The key you input already exists. Please input new key.");
        this.input_valid = 0;
        return;
      } else {
        this.input_valid = 1;
        this.new_key = e.target.value;
        this.lang_content[this.new_key] = this.lang_content[this.current_key];
        delete this.lang_content[this.current_key];
        this.current_key = this.new_key;
      }
    }
  }
}
</script>