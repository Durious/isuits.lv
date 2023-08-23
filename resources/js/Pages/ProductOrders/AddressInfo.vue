<template>
    <div v-if="shippingAddress && shippingAddress.id" class="w-full ltr:text-left rtl:text-right">
        <div v-if="modal" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
            <p class="font-bold">{{ $t('Address Information') }}</p>
            <div class="flex items-center">
                <a class="modal-close ml-2 cursor-pointer" @click="$emit('close')">
                    <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                        viewBox="0 0 18 18">
                        <path
                            d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z">
                        </path>
                    </svg>
                </a>
            </div>
        </div>
        <div class="font-bold mx-8 pt-3 pb-5 border-b mb-3">{{ $t('Shipping Address') }}</div>
        <div class="w-full h-full px-10 leading-normal">
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Full Name') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ shippingAddress.fname }} {{ shippingAddress.lname }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Address') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ shippingAddress.address }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('City') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ shippingAddress.city }}, {{ shippingAddress.state }}, {{ shippingAddress.country }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Zipcode') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ shippingAddress.zipcode }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Phone') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ shippingAddress.phone }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Other') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ shippingAddress.other ?? 'N/A' }}
                </div>
            </div>
        </div>
        <div class="font-bold mx-8 pt-7 pb-5 border-b mb-3">{{ $t('Billing Address') }}</div>
        <div class="w-full h-full px-10 leading-normal">
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Full Name') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.fname }} {{ billingAddress.lname }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Address') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.address }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('City') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.city }}, {{ billingAddress.state }}, {{ billingAddress.country }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Zipcode') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.zipcode }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('vatcode') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.vatcode }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('fiscalcode') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.fiscalcode }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('recipientcode') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.recipientcode }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('taxcode') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.taxcode }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Certified Email') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.certified_email }}
                </div>
            </div>
            <div class="flex flex-wrap pb-2">
                <div class="w-1/4 px-2">
                    <strong>{{ $t('Other') }}:</strong>
                </div>
                <div class="w-3/4 px-2">
                    {{ billingAddress.other }}
                </div>
            </div>
        </div>
        <div class="np block xs:flex px-6 py-4 mt-4 bg-gray-100 border-t rounded-b">
            <button @click="$emit('close')" class="btn-gray ml-auto">
                {{ $t('Close') }}
            </button>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        shippingAddress: Object,
        billingAddress: Object,
        modal: {
            type: Boolean,
            default: true
        }
    }
}
</script>