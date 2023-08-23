<template>
    <div v-if="measurement && measurement.id" class="w-full ltr:text-left rtl:text-right">
        <div v-if="modal" class="np flex justify-between items-center px-6 py-4 mb-4 bg-gray-100 border-b rounded-t">
            <p class="font-bold">{{ $t('Measurement No', { x: measurement.id }) }}</p>
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
        <div class="w-full h-full px-6 leading-normal">
            <div class="flex flex-wrap border-b pb-3">
                <div class="w-1/3 p-2">
                    <strong>{{ $t('Date of Birth') }}:</strong>
                    {{ measurement.dob }}
                </div>
                <div class="w-1/3 p-2">
                    <strong>{{ $t('Height') }}:</strong>
                    {{ measurement.height }} cm
                </div>
                <div class="w-1/3 p-2">
                    <strong>{{ $t('Weight') }}:</strong>
                    {{ measurement.weight }} kg
                </div>
            </div>
            <div class="flex flex-wrap border-b py-4">
                <div class="w-1/3 p-2" v-for="number_key in number_keys">
                    <strong>{{ $t(number_key) }}:</strong>
                    {{ measurement[number_key] }} cm
                </div>
            </div>
            <div class="flex flex-wrap py-4 capitalize">
                <div class="w-1/3 p-2">
                    <strong>{{ $t('Shoulder Type') }}:</strong>
                    {{ measurement.shoulder_type }}
                </div>
                <div class="w-1/3 p-2">
                    <strong>{{ $t('Chest Type') }}:</strong>
                    {{ measurement.chest_type }}
                </div>
                <div class="w-1/3 p-2">
                    <strong>{{ $t('Stomach Type') }}:</strong>
                    {{ measurement.stomach_type }}
                </div>
                <div class="w-1/3 p-2">
                    <strong>{{ $t('Back Type') }}:</strong>
                    {{ measurement.back_type }}
                </div>
                <div class="w-1/3 p-2">
                    <strong>{{ $t('Rear Type') }}:</strong>
                    {{ measurement.rear_type }}
                </div>
                <div class="w-1/3 p-2">
                    <strong>{{ $t('Fit') }}:</strong>
                    {{ measurement.fit }}
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
        measurement: Object,
        modal: {
            type: Boolean,
            default: true
        }
    },
    data() {
        return {
            number_keys: ['chest', 'neck', 'shoulder', 'back_length', 'arm_length', 'biceps', 'wrist', 'stomach', 'waistline', 'hip', 'inside_length', 'thigh']
        }
    }
}
</script>