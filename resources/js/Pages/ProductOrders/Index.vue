<template>
    <div>
        <h1 class="mb-6 mt-2 font-bold text-lg md:text-2xl">{{ $tc('Product Order', 2) }}</h1>
        <div class="bg-white rounded shadow overflow-x-auto scroll-on-light">
            <table class="w-full whitespace-no-wrap">
                <thead>
                    <tr class="text-left font-bold">
                        <th class="px-6 pt-6 pb-4">{{ $t('Order Date') }}</th>
                        <th class="px-6 pt-6 pb-4">{{ $tc('Product', 2) }}</th>
                        <th class="px-6 pt-6 pb-4">{{ $t('Customer') }}</th>
                        <th class="px-6 pt-6 pb-4 text-right">{{ $t('Price') }} (&euro;)</th>
                        <th class="px-6 pt-6 pb-4">{{ $t('Address') }}</th>
                        <th class="px-6 pt-6 pb-4">{{ $t('Payment') }}</th>
                        <th class="px-6 pt-6 pb-4">{{ $t('Status') }}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr :key="product_order.id" v-for="product_order in product_orders"
                        @click="rowClicked(product_order.id)"
                        class="cursor-pointer hover:bg-teal-200 focus-within:bg-teal-200">
                        <td class="border-t px-6 py-4 max-w-lg truncate">
                            {{ formatDate(product_order.created_at) }}
                        </td>
                        <td class="border-t px-6 py-4 max-w-lg truncate">
                            <ul class="list-disc pl-5">
                                <li v-for="cart_item in product_order.carts" class="my-1">
                                    {{ cart_item.product.name }}
                                </li>
                            </ul>
                        </td>
                        <td class="border-t px-6 py-4 max-w-lg leading-relaxed">
                            {{ product_order.customer.name }}
                        </td>
                        <td class="border-t px-6 py-4 max-w-lg truncate text-right">
                            {{ $number(product_order.total_price) }}
                        </td>
                        <td class="border-t px-6 py-4 max-w-lg truncate">
                            <div>{{ product_order.shipping_address.address }}</div>
                            <div class="mt-3">
                                {{ product_order.shipping_address.city }},
                                {{ product_order.shipping_address.state }},
                                {{ product_order.shipping_address.country }}
                            </div>
                        </td>
                        <td class="border-t px-6 py-4 w-8">
                            <span :class="`bg-${paid_status_colors[product_order.paid_status]}-200 rounded text-sm py-1 px-2 capitalize`">
                                {{ product_order.paid_status }}
                            </span>
                        </td>
                        <td class="border-t px-6 py-4 w-8">
                            <span :class="`bg-${order_status_colors[product_order.status]}-200 rounded text-sm py-1 px-2`">
                                {{ product_order.status }}
                            </span>
                        </td>
                        <td class="border-t px-6 py-4 w-8">
                            <Icons name="cheveron-right" class="block w-6 h-6 fill-gray-400 rtl:rotate" />
                        </td>
                    </tr>
                    <tr v-if="product_orders.length === 0">
                        <td class="border-t px-6 py-4" colspan="5">{{ $t('no_x_found', { x: $tc('Product Order') }) }}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <Modal :show="viewModal" max-width="3xl" :closeable="true" @close="() => (viewModal = false)">
            <Show :order="order" @close="() => (viewModal = false)" />
        </Modal>
    </div>
</template>
    
<script>
import Filters from '@/Misc/Filters';
import Layout from '@/Shared/Layout.vue';
import Modal from '@/Jetstream/Modal.vue';
import Show from '@/Pages/ProductOrders/Show.vue';

export default {
    layout: Layout,
    props: { product_orders: Object },
    components: { Show, Modal },
    data() {
        const paid_status_colors = {}
        const paid_statuses = this.$page.props.user.account.order_statuses
        paid_statuses.forEach((item, index) => {
            if(index === paid_statuses.length - 1) {
                paid_status_colors[item] = 'green'
            } else if(index === 0) {
                paid_status_colors[item] = 'gray'
            } else {
                paid_status_colors[item] = 'red'
            }
        });
        return {
            viewModal: false,
            order: null,
            order_status_colors: {
                Pending: 'gray',
                Received: 'blue',
                Completed: 'green',
            },
            paid_status_colors
        }
    },
    methods: {
        ...Filters,
        rowClicked(n) {
            this.order = this.product_orders.find(item => item.id === n);
            this.viewModal = true;
        },
    }
};
</script>
    