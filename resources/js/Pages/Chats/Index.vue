<template>
  <div class="section-chat-page">
    <div class="w-full h-full flex flex-wrap">

<!--      <iframe src="https://dashboard.tawk.to/" width="100%"></iframe>-->

      <!--      <div class="w-full h-full lg:w-1/3 ltr:pr-2 rtl:pl-2">-->
<!--        <div class="bg-white rounded shadow p-6 h-full">-->
<!--          <div v-for="item in customers">-->
<!--            <div class="p-4 border border-gray-200 rounded-md cursor-pointer mb-3 hover:border-gray-600 shadow"-->
<!--              :class="{ 'border-gray-600 bg-gray-700 text-white': item.id === selected_customer?.id }"-->
<!--              @click="displayChat(item.id)">-->
<!--              <div class="flex flex-wrap">-->
<!--                <img :src="item.photo ? '/storage/profile/' + item.photo : '/customer/img/profile-page/profile.jpg'"-->
<!--                  alt="customer-photo" class="object-cover rounded-full h-14 w-14 mr-4" />-->
<!--                <div>-->
<!--                  <div class="font-bold mt-1">{{ item.name }}</div>-->
<!--                  <div class="text-sm mt-1">{{ item.email }}</div>-->
<!--                </div>-->
<!--              </div>-->
<!--            </div>-->
<!--          </div>-->
<!--        </div>-->
<!--      </div>-->
<!--      <div class="w-full h-full lg:w-2/3 ltr:pl-8 rtl:pr-8">-->
<!--        <div class="bg-white rounded shadow p-8 h-full">-->
<!--          <div class="relative flex flex-col h-full rounded border">-->
<!--            <div class="absolute top-0 bottom-0 left-0 right-0 bg-white bg-opacity-60 cursor-not-allowed rounded"-->
<!--              v-if="loading || !first_chat || !(first_chat.is_accepted)">-->
<!--              <div class="flex flex-wrap items-center justify-center h-full">-->
<!--                <div v-if="loading" class="cursor-pointer">-->
<!--                  <svg aria-hidden="true"-->
<!--                    class="w-24 h-24 mr-2 text-gray-200 animate-spin dark:text-gray-200 fill-blue-600"-->
<!--                    viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg">-->
<!--                    <path-->
<!--                      d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"-->
<!--                      fill="currentColor" />-->
<!--                    <path-->
<!--                      d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z"-->
<!--                      fill="currentFill" />-->
<!--                  </svg>-->
<!--                  <span class="sr-only">Loading...</span>-->
<!--                </div>-->
<!--                <div v-else-if="!selected_customer" class="cursor-pointer shadow-lg">-->
<!--                  <div-->
<!--                    class="bg-blue-100 border border-blue-600 text-blue-600 py-4 px-6 text-lg rounded w-[300px] text-center"-->
<!--                    role="alert">-->
<!--                    <strong class="font-bold">No customer selected!</strong>-->
<!--                  </div>-->
<!--                </div>-->
<!--                <div v-else-if="!first_chat" class="cursor-pointer shadow-lg" @click="sayHi()">-->
<!--                  <div-->
<!--                    class="bg-blue-100 border border-blue-600 text-blue-600 py-4 px-6 text-lg rounded w-[300px] text-center"-->
<!--                    role="alert">-->
<!--                    <strong class="font-bold">Say Hi</strong>-->
<!--                  </div>-->
<!--                </div>-->
<!--                <div v-else-if="first_chat && !first_chat.is_accepted && first_chat.from_user"-->
<!--                  class="cursor-pointer shadow-lg">-->
<!--                  <div-->
<!--                    class="bg-blue-100 border border-blue-600 text-blue-600 py-4 px-6 text-lg rounded w-[300px] text-center"-->
<!--                    role="alert">-->
<!--                    <strong class="font-bold">Waiting to accept</strong>-->
<!--                  </div>-->
<!--                </div>-->
<!--                <div v-else-if="first_chat && !first_chat.is_accepted && !first_chat.from_user"-->
<!--                  class="cursor-pointer shadow-lg" @click="acceptChat()">-->
<!--                  <div-->
<!--                    class="bg-blue-100 border border-blue-600 text-blue-600 py-4 px-6 text-lg rounded w-[300px] text-center"-->
<!--                    role="alert">-->
<!--                    <strong class="font-bold">Accept</strong>-->
<!--                  </div>-->
<!--                </div>-->
<!--              </div>-->
<!--            </div>-->
<!--            <div class="px-6 pt-6 pb-2 h-full overflow-y-auto" id="chat-history">-->
<!--              <div class="flex flex-col justify-end">-->
<!--                <div v-for="item in chats">-->
<!--                  <div v-if="item.from_user" class="flex mb-3 flex-row-reverse">-->
<!--                    <img-->
<!--                      :src="$page.props.user.photo ? '/storage/' + $page.props.user.photo : '/customer/img/profile-page/profile.jpg'"-->
<!--                      class="rounded-full w-8 h-8 object-cover" />-->
<!--                    <div class="mr-4 w-full">-->
<!--                      <div class="w-fit content bg-gray-300 px-3 py-2 rounded-lg rounded-tr-none leading-6 max-w-[70%] ml-auto">{{ item.text }}</div>-->
<!--                      <div class="text-sm text-right text-gray-400 mt-1">-->
<!--                        {{ datetime(item.created_at) }}-->
<!--                      </div>-->
<!--                    </div>-->
<!--                  </div>-->
<!--                  <div v-else class="flex mb-3">-->
<!--                    <img-->
<!--                      :src="selected_customer.photo ? '/storage/profile/' + selected_customer.photo : '/customer/img/profile-page/profile.jpg'"-->
<!--                      class="rounded-full w-8 h-8 object-cover" />-->
<!--                    <div class="ml-4 w-full">-->
<!--                      <div class="w-fit content bg-green-600 px-3 py-2 rounded-lg rounded-tl-none leading-6 max-w-[70%] mr-auto text-white">-->
<!--                        {{ item.text }}-->
<!--                      </div>-->
<!--                      <div class="text-sm text-gray-400 mt-1">{{ datetime(item.created_at) }}</div>-->
<!--                    </div>-->
<!--                  </div>-->
<!--                </div>-->
<!--              </div>-->
<!--            </div>-->
<!--            <div class="border-t flex flex-wrap">-->
<!--              <textarea v-model="message" @keydown="handleKeyDown" rows="1"-->
<!--                class="grow border-none focus:ring-transparent placeholder-gray-300 px-6"-->
<!--                placeholder="Enter your message"></textarea>-->
<!--              <button class="px-6 border-l font-bold" @click="submitChat()">Send</button>-->
<!--            </div>-->
<!--          </div>-->
<!--        </div>-->
<!--      </div>-->
    </div>
  </div>
</template>

<script>
import Filters from '@/Misc/Filters';
import Layout from '@/Shared/Layout.vue';
import { io } from "socket.io-client";

export default {
  layout: Layout,
  props: { icustomers1: Object, icustomers2: Object },
  metaInfo() {
    return { title: this.$tc('Chat', 2) };
  },
  data() {
    return {
      customers: [],
      selected_customer: null,
      first_chat: null,
      chats: [],
      loading: false,
      message: ''
    }
  },
  mounted() {
    this.customers = [
      ...this.icustomers1,
      ...this.icustomers2.filter(item => {
        return this.icustomers1.find(item2 => (
          item2.id === item.id
        )) === undefined
      })
    ]
    // const socket = io('https://node.isuits.lv')
    const socket = io('http://localhost:3000')
    socket.on('USERID_REQUEST', () => {
      socket.emit('USERID_RESPONSE', {
        'user_id': this.$page.props.user.id,
        'type': 'user'
      });
    });
    socket.on('USER_MSG_RECEIVED', () => {
      this.reloadChat();
    });
  },
  updated() {
    var container = document.getElementById("chat-history");
    container.scrollTop = container.scrollHeight;
  },
  methods: {
    ...Filters,
    displayChat(customer_id) {
      this.selected_customer = this.customers.find(item => item.id === customer_id)
      this.loading = true
      this.reloadChat(customer_id)
    },
    reloadChat(customer_id = null) {
      const id = customer_id ?? (this.selected_customer?.id ?? 0);
      if (id) {
        fetch(this.route('chats.show', id)).then(res => {
          res.json().then(data => {
            this.loading = false
            this.chats = data.chats.map((item) => (this.convertType(item)))
            this.first_chat = this.convertType(data.first_chat)
          });
        });
      }
    },
    handleKeyDown(event) {
      if (event.ctrlKey && event.keyCode === 13) {
        this.submitChat()
      }
    },
    submitChat() {
      this.sendMessage(this.message)
      this.message = ""
    },
    sayHi() {
      this.sendMessage('Hi.')
    },
    sendMessage(text) {
      this.$axios.post(this.route('chats.send', this.selected_customer.id), { text })
        .then(res => {
          if (res.data.success) {
            this.reloadChat()
          }
        })
    },
    acceptChat() {
      this.$axios.post(this.route('chats.accept', this.selected_customer.id))
        .then(res => {
          if (res.data.success) {
            this.reloadChat()
          }
        })
    },
    convertType(chatItem) {
      if (!chatItem)
        return chatItem
      const {from_user, user_id, customer_id, is_accepted, is_read} = chatItem
      return {
        ...chatItem,
        from_user: !!Number(from_user),
        is_accepted: !!Number(is_accepted),
        is_read: !!Number(is_read),
        user_id: Number(user_id),
        customer_id: Number(customer_id)
      }
    }
  }
};
</script>

<style>
.section-chat-page {
  height: calc(100vh - 130px);
}
</style>
