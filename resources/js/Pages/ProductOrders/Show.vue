<template>
    <div v-if="order && order.id" class="bg-white rounded-md ltr:text-left rtl:text-right">
        <div v-if="order" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
            <p class="font-bold">{{ $t('Order') }} - {{ order.reference }}</p>
            <div class="flex items-center">
                <template v-if="order.status != 'Completed'">
                    <Dropdown placement="bottom-end">
                        <div class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800">
                            <Icons class="w-5 h-5 fill-current" name="scissors" />
                        </div>
                        <template v-slot:dropdown>
                            <div class="mt-2 py-2 bg-gray-800 rounded text-sm">
                                <button type="button" @click="updateStatus('Pending')"
                                    class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white">
                                    {{ $t('mark_as_x', { x: $t('Pending') }) }}
                                </button>
                                <button type="button" @click="updateStatus('Received')"
                                    class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white">
                                    {{ $t('mark_as_x', { x: $t('Received') }) }}
                                </button>
                                <button type="button" @click="updateStatus('Completed')"
                                    class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white">
                                    {{ $t('mark_as_x', { x: $t('Completed') }) }}
                                </button>
                            </div>
                        </template>
                    </Dropdown>
                </template>
                <a @click="printOrder()" class="modal-close mx-2 cursor-pointer text-gray-700 hover:text-gray-800">
                    <Icons name="printer" class="h-5 w-5 fill-current" />
                </a>
                <Link :href="route('product_orders.edit', order.id)" class="mx-2 cursor-pointer text-gray-700 hover:text-gray-800">
                    <Icons name="edit" class="h-5 w-5 fill-current" />
                </Link>
                <a class="modal-close ml-2 cursor-pointer" @click="hide()">
                    <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                        viewBox="0 0 18 18">
                        <path
                            d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z">
                        </path>
                    </svg>
                </a>
            </div>
        </div>
        <div class="print">
            <div class="max-w-3xl h-full py-4 px-6 leading-normal">
                <div class="flex flex-wrap xs:flex-no-wrap justify-around w-full items-center">
                    <div class="text-gray-900 mx-auto xs:mx-0" style="width: 180px">
                        <img :alt="order.account.name" v-if="order.account.logo_path"
                            :src="`/storage/account/${order.account.logo_path}`" />
                        <logo v-else />
                    </div>
                    <div class="text-sm px-4 py-4 xs:py-0 text-center xs:ltr:text-left rtl:text-right">
                        <div class="font-extrabold">{{ order.account.name }}</div>
                        <div class="font-bold">{{ order.account.phone }}</div>
                        {{ order.account.email }}
                    </div>
                    <div class="text-sm">
                        <div class="flex">
                            <span class="ltr:text-right rtl:text-left ltr:mr-2 rtl:ml-2" style="width: 70px">
                                {{ $t('No') }}:</span>
                            <span class="font-bold">{{ order.reference }}</span>
                        </div>
                        <div class="flex">
                            <span class="ltr:text-right rtl:text-left ltr:mr-2 rtl:ml-2" style="width: 70px">{{ $t('Date')
                            }}:</span>
                            <span class="font-bold">
                                <span class="inline-block">{{ $datetime(order.created_at) }}</span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="my-6 px-4 py-3 rounded text-sm flex justify-between" :class="{
                    'bg-gray-200': order.status == $t('Pending'),
                    'bg-blue-200': order.status == $t('Received'),
                    'bg-green-200': order.status == $t('Completed'),
                }">
                    <div>
                        {{ $t('Paid') }}:
                        <span class="font-extrabold inline-block capitalize">
                            {{ order.paid_status }}
                        </span>
                    </div>
                    <div>
                        {{ $t('Status') }}: <span class="font-extrabold inline-block">{{ order.status }}</span>
                    </div>
                    <div>
                        {{ $t('Updated Date') }}:
                        <span class="font-extrabold inline-block">{{ $date(order.updated_at) }}</span>
                    </div>
                </div>

                <div id="details" class="block xs:flex my-6">
                    <div id="company" class="ltr:pr-0 rtl:pl-0 xs:ltr:pr-3 xs:rtl:pl-3 w-full xs:max-w-1/2">
                        <div class="px-2 py-2 border rounded-t font-bold">
                            {{ $t('Company Details') }}
                        </div>
                        <div class="border rounded-b border-t-0 px-2 py-2">
                            <div class="flex">
                                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Name') }}:</span>
                                <span>
                                    <strong>{{ order.account.name }}</strong>
                                </span>
                            </div>
                            <div v-if="order.account.address" class="flex">
                                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Address') }}:</span>
                                <span>{{ order.account.address }}</span>
                            </div>
                            <div class="flex">
                                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Phone') }}:</span>
                                <span>{{ order.account.phone }}</span>
                            </div>
                            <div v-if="order.account.email" class="flex">
                                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Email') }}:</span>
                                <span>{{ order.account.email }}</span>
                            </div>
                        </div>
                    </div>
                    <div id="customer" class="mt-4 xs:mt-0 ltr:pl-0 rtl:pr-0 xs:ltr:pl-3 xs:rtl:pr-3 w-full xs:max-w-1/2">
                        <div class="px-2 py-2 border rounded-t font-bold">
                            {{ $t('Customer Details') }}
                        </div>

                        <div class="border rounded-b border-t-0 px-2 py-2">
                            <div class="flex">
                                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Name') }}:</span>
                                <span>
                                    <strong>{{ order.customer.name }}</strong>
                                </span>
                            </div>
                            <div v-if="order.customer.address" class="flex">
                                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Address') }}:</span>
                                <span>{{ order.customer.address }}</span>
                            </div>
                            <div class="flex">
                                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Phone') }}:</span>
                                <span>{{ order.customer.phone }}</span>
                            </div>
                            <div v-if="order.customer.email" class="flex">
                                <span class="ltr:mr-2 rtl:ml-2" style="min-width: 70px">{{ $t('Email') }}:</span>
                                <span>{{ order.customer.email }}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="border rounded leading-tight">
                    <p class="px-4 py-3 border-b rounded-t font-bold">
                        {{ $tc('Product', 2) }}
                    </p>
                    <div class="rounded-b overflow-x-auto scroll-on-light">
                        <table class="w-full all max-w-full min-w-0">
                            <thead>
                                <tr>
                                    <th class="border-b bg-gray-200 px-4 py-2">{{ $t('Name') }}</th>
                                    <th class="border-b bg-gray-200 px-4 py-2">{{ $t('Photo') }}</th>
                                    <th class="border-b bg-gray-200 px-4 py-2 text-center">{{ $t('Price') }}</th>
                                    <th class="border-b bg-gray-200 px-4 py-2 text-center">{{ $t('Qty') }}</th>
                                    <th class="border-b bg-gray-200 px-4 py-2 text-center">{{ $t('Amount') }}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="cart in order.carts" :key="'service_' + cart.id">
                                    <td class="border-b px-4 py-2">
                                        <div style="min-width: 180px">
                                            <div class="font-bold">{{ cart.product.name }}</div>
                                            <div v-if="cart.customization !== 'null'" class="mt-3 pl-2 text-sm">
                                                <div v-for="(value, key) in JSON.parse(cart.customization)">
                                                    {{ key }}: {{ value }}
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                                        <img :src="'/storage/product/' + cart.product.main_photo" alt="product-photo"
                                            class="h-12 object-cover" />
                                    </td>
                                    <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                                        {{ $number(cart.unit) }}
                                    </td>
                                    <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                                        {{ cart.quantity }}
                                    </td>
                                    <td class="border-b px-4 py-2 ltr:text-right rtl:text-left">
                                        {{ $number(cart.unit * cart.quantity) }}
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="4" class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">{{
                                        $t('Total') }}</th>
                                    <th class="border-b px-4 py-2 bg-gray-200 ltr:text-right rtl:text-left">
                                        {{ $number(order.total_price) }}
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!--Footer-->
        <div class="np block xs:flex items-end justify-between px-6 py-4 mt-4 bg-gray-100 border-t rounded-b">
            <div class="m-1 xs:m-0">
                <button @click="showMeasurement()"
                    class="inline-flex items-center mt-1 px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2">
                    {{ $t('Measurement') }}
                </button>
                <button @click="showAddressInfo()"
                    class="inline-flex items-center mt-1 px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2">
                    {{ $t('Address') }}
                </button>
                <dropdown class="mt-1" placement="top-start">
                    <div
                        class="flex items-center cursor-pointer select-none group px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2">
                        {{ $t('Payment') }}
                        <Icons class="w-2 h-2 fill-current ml-2" name="cheveron-up" />
                    </div>
                    <template v-slot:dropdown>
                        <div class="mb-2 py-2 bg-gray-800 rounded text-sm">
                            <button type="button" v-for="item in $page.props.user.account.order_statuses" @click="updatePaidStatus(item)"
                                class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white">
                                {{ $t('mark_as_x', { x: item }) }}
                            </button>
                        </div>
                    </template>
                </dropdown>
                <template v-if="order.status != 'Completed'">
                    <dropdown class="mt-1" placement="top-start">
                        <div
                            class="flex items-center cursor-pointer select-none group px-4 py-3 text-sm rounded bg-gray-200 hover:bg-gray-400 border ltr:mr-2 rtl:ml-2">
                            {{ $t('Status') }}
                            <Icons class="w-2 h-2 fill-current ml-2" name="cheveron-up" />
                        </div>
                        <template v-slot:dropdown>
                            <div class="mb-2 py-2 bg-gray-800 rounded text-sm">
                                <button type="button" @click="updateStatus('Completed')"
                                    class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white">
                                    {{ $t('mark_as_x', { x: $t('Completed') }) }}
                                </button>
                                <button type="button" @click="updateStatus('Received')"
                                    class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white">
                                    {{ $t('mark_as_x', { x: $t('Received') }) }}
                                </button>
                                <button type="button" @click="updateStatus('Pending')"
                                    class="block w-full ltr:text-left rtl:text-right px-6 py-3 text-white hover:bg-gray-900 hover:text-white fill-white">
                                    {{ $t('mark_as_x', { x: $t('Pending') }) }}
                                </button>
                            </div>
                        </template>
                    </dropdown>
                </template>
            </div>
            <button @click="hide()" class="btn-gray">
                {{ $t('Close') }}
            </button>
        </div>
        <Dialog :show="message" :content="message" :closeText="$t('ok')" :close="() => (message = null)" />
        <Dialog :show="confirm" :close="() => (confirm = false)" :action-text="dialogButtonText" :action="dialogAction"
            :title="dialogTitle" :content="dialogBody" />
        <Modal :show="viewMeasurement" max-width="4xl" :closeable="true" @close="viewMeasurement = false">
            <Measurement :measurement="measurement" @close="() => (viewMeasurement = false)" />
        </Modal>
        <Modal :show="viewAddress" max-width="2xl" :closeable="true" @close="viewAddress = false">
            <AddressInfo :shippingAddress="shippingAddress" :billingAddress="billingAddress" @close="() => (viewAddress = false)" />
        </Modal>
    </div>
</template>
<script>
import Logo from '@/Shared/Logo.vue';
import Dialog from '@/Shared/Dialog.vue';
import Modal from '@/Jetstream/Modal.vue';
import Dropdown from '@/Shared/Dropdown.vue';
import Measurement from '@/Pages/ProductOrders/Measurement.vue';
import AddressInfo from '@/Pages/ProductOrders/AddressInfo.vue';

export default {
    metaInfo() {
        return {
            title: this.$t('Order Number', { x: this.order.id }),
        };
    },
    props: {
        order: {
            default: {},
        },
    },
    components: { Logo, Dropdown, Dialog, Modal, Measurement, AddressInfo },
    data() {
        return {
            message: null,
            dialogButtonText: null,
            dialogAction: null,
            dialogTitle: null,
            dialogBody: null,
            confirm: false,
            viewMeasurement: false,
            measurement: null,
            shippingAddress: null,
            billingAddress: null,
            viewAddress: false
        }
    },
    methods: {
        updateStatus(status) {
            if (this.order.status == 'Completed') {
                this.message = this.$t('Order is already marked as completed.');
            } else {
                this.dialogButtonText = this.$t('Yes');
                this.dialogAction = () => this.updateStatusNow(status);
                this.dialogTitle = this.$t('update_status_x', { x: this.$t(status) });
                this.dialogBody = this.$t('ask_update_status_x', { x: this.$t(status) });
                this.confirm = true;
            }
        },
        updateStatusNow(status) {
            this.$emit('close');
            this.$inertia.put(this.route('product_orders.status', this.order.id), { status });
        },
        updatePaidStatus(status) {
            this.dialogButtonText = this.$t('Yes');
            this.dialogAction = () => this.updatePaidStatusNow(status);
            this.dialogTitle = this.$t('update_status_x', { x: this.$t(status) });
            this.dialogBody = this.$t('ask_update_status_x', { x: this.$t(status) });
            this.confirm = true;
        },
        updatePaidStatusNow(status) {
            this.$emit('close');
            this.$inertia.put(
                this.route('product_orders.paid_status', this.order.id),
                { status }
            );
        },
        printOrder() {
            window.print();
        },
        hide() {
            this.$emit('close');
        },
        showMeasurement() {
            fetch(this.route('customer_info.measurement.show', this.order.customer.id)).then(res => {
                res.json().then(data => {
                    this.measurement = data;
                    this.viewMeasurement = true;
                })
            })
        },
        showAddressInfo() {
            fetch(this.route('customer_info.address.show', this.order.id)).then(res => {
                res.json().then(data => {
                    this.shippingAddress = data.shipping_address;
                    this.billingAddress = data.billing_address;
                    this.viewAddress = true;
                })
            })
        }
    }
}
</script>