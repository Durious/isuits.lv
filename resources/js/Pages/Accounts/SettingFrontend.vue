<template>
  <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
    <form @submit.prevent="submitForm" autocomplete="off">
      <div class="p-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-3 flex flex-wrap">
        <div class="mb-5 font-bold text-gray-500">HomePage</div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('slides')">
            {{ $tc('Hero Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'slides' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'slides'">
            <div v-for="(item, index) in form.slides" :key="index" class="py-5" :class="index !== 0 ? 'border-t' : ''">
              <div class="mb-3 font-bold">
                {{ $tc('Slide') + ' ' + (index + 1) }}
              </div>
              <div class="flex w-full">
                <text-input v-model="item.main_title" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Main Title')"
                  :errors="errors['slides.' + index + '.main_title']" />
                <text-input v-model="item.sub_title" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Sub Title')"
                  :errors="errors['slides.' + index + '.sub_title']" />
              </div>
              <file-input type="file" accept="image/*" :label="$t('Main Image')" previewUrl='/storage/frontend/'
                v-model="item.main_image" :error="errors['slides.' + index + '.main_image']"
                class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
              <file-input type="file" accept="image/*" :label="$t('Sub Image')" previewUrl='/storage/frontend/'
                v-model="item.sub_image" :error="errors['slides.' + index + '.sub_image']"
                class="ltr:pr-6 rtl:pl-6 w-full mt-5" />
              <textarea-input v-model="item.description" class="ltr:pr-6 rtl:pl-6 w-full mt-5" :label="$t('Description')"
                :error="errors['slides.' + index + '.description']" />
              <div class="flex w-full mt-3">
                <text-input v-model="item.name" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Name')"
                  :errors="errors['slides.' + index + '.name']" />
                <text-input v-model="item.url" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('URL')"
                  :errors="errors['slides.' + index + '.url']" />
              </div>
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addSlideItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeSlideItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('limited')">
            {{ $tc('Limited Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'limited' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'limited'" class="pt-2 pb-5">
            <div v-for="(item, index) in form.limiteds" :key="index" class="py-5" :class="index !== 0 ? 'border-t' : ''">
              <div class="mb-3 font-bold">
                {{ $tc('Limited') + ' ' + (index + 1) }}
              </div>
              <file-input type="file" accept="image/*" :label="$t('Image')" previewUrl='/storage/frontend/'
                v-model="item.image" :error="errors['limiteds.' + index + '.image']"
                class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
              <textarea-input v-model="item.description" class="ltr:pr-6 rtl:pl-6 w-full mt-5" :label="$t('Description')"
                :error="errors['limiteds.' + index + '.description']" />
              <div class="flex w-full mt-3">
                <text-input v-model="item.name" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Name')"
                  :errors="errors['limiteds.' + index + '.name']" />
                <text-input v-model="item.url" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('URL')"
                  :errors="errors['limiteds.' + index + '.url']" />
              </div>
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addLimitedItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeLimitedItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
            <!-- <file-input type="file" accept="image/*" :label="$t('Image')" previewUrl='/storage/frontend/'
              v-model="form.limited.image" :error="errors['limited.image']" class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
            <textarea-input v-model="form.limited.description" class="ltr:pr-6 rtl:pl-6 w-full mt-5"
              :label="$t('Description')" :error="errors['limited.description']" />
            <div class="flex w-full mt-3">
              <text-input v-model="form.limited.name" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Name')"
                :errors="errors['limited.name']" />
              <text-input v-model="form.limited.url" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('URL')"
                :errors="errors['limited.url']" />
            </div> -->
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('discount')">
            {{ $tc('Discount Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'discount' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'discount'" class="pt-2 pb-5">
            <text-input v-model="form.discount.title" class="ltr:pr-6 rtl:pl-6 w-full mt-3" :label="$t('Title')"
              :errors="errors['discount.title']" />
            <file-input type="file" accept="image/*" :label="$t('Image') + '1'" previewUrl='/storage/frontend/'
              v-model="form.discount.image1" :error="errors['discount.image1']" class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
            <file-input type="file" accept="image/*" :label="$t('Image') + '2'" previewUrl='/storage/frontend/'
              v-model="form.discount.image2" :error="errors['discount.image2']" class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
            <file-input type="file" accept="image/*" :label="$t('Image') + '3'" previewUrl='/storage/frontend/'
              v-model="form.discount.image3" :error="errors['discount.image3']" class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
            <textarea-input v-model="form.discount.description" class="ltr:pr-6 rtl:pl-6 w-full mt-5"
              :label="$t('Description')" :error="errors['discount.description']" />
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('embrace')">
            {{ $tc('Embrace Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'embrace' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'embrace'" class="pt-2 pb-5">
            <file-input type="file" accept="image/*" :label="$t('Image')" previewUrl='/storage/frontend/'
              v-model="form.embrace.image" :error="errors['embrace.image']" class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
            <textarea-input v-model="form.embrace.description" class="ltr:pr-6 rtl:pl-6 w-full mt-5"
              :label="$t('Description')" :error="errors['embrace.description']" />
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('testimonial')">
            {{ $tc('Testimonial Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'testimonial' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'testimonial'">
            <div v-for="(item, index) in form.testimonial" :key="index" class="py-5"
              :class="index !== 0 ? 'border-t' : ''">
              <div class="mb-3 font-bold">
                {{ $tc('Testimonial') + ' ' + (index + 1) }}
              </div>
              <div class="flex w-full">
                <text-input v-model="item.name" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Name')"
                  :errors="errors['testimonial.' + index + '.name']" />
                <text-input v-model="item.position" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Position')"
                  :errors="errors['testimonial.' + index + '.position']" />
              </div>
              <file-input type="file" accept="image/*" :label="$t('Photo')" previewUrl='/storage/frontend/'
                v-model="item.photo" :error="errors['testimonial.' + index + '.photo']"
                class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
              <textarea-input v-model="item.description" class="ltr:pr-6 rtl:pl-6 w-full mt-5" :label="$t('Description')"
                :error="errors['testimonial.' + index + '.description']" />
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addTestimonialItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeTestimonialItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('service')">
            {{ $tc('Service Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'service' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'service'">
            <div v-for="(item, index) in form.service" :key="index" class="py-5" :class="index !== 0 ? 'border-t' : ''">
              <div class="mb-3 font-bold">
                {{ $tc('Service') + ' ' + (index + 1) }}
              </div>
              <text-input v-model="item.title" class="ltr:pr-6 rtl:pl-6 w-full" :label="$t('Title')"
                :errors="errors['service.' + index + '.title']" />
              <file-input type="file" accept="image/*" :label="$t('Icon')" previewUrl='/storage/frontend/'
                v-model="item.icon" :error="errors['service.' + index + '.icon']" class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
              <textarea-input v-model="item.description" :rows="3" class="ltr:pr-6 rtl:pl-6 w-full mt-5"
                :label="$t('Description')" :error="errors['service.' + index + '.description']" />
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addServiceItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeServiceItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('galleries')">
            {{ $tc('Gallery Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'galleries' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'galleries'">
            <div v-for="(item, index) in form.galleries" :key="index" class="py-5" :class="index !== 0 ? 'border-t' : ''">
              <div class="mb-3 font-bold">
                {{ $tc('Gallery') + ' ' + (index + 1) }}
              </div>
              <div class="flex w-full">
                <text-input v-model="item.main_title" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Main Title')"
                  :errors="errors['galleries.' + index + '.main_title']" />
                <text-input v-model="item.sub_title" class="ltr:pr-6 rtl:pl-6 w-full lg:w-1/2" :label="$t('Sub Title')"
                  :errors="errors['galleries.' + index + '.sub_title']" />
              </div>
              
              <div v-for="(sub_image, image_index) in form.images[index]" :key="image_index"
                class="px-8 pb-8 ltr:-mr-6 rtl:-ml-6 ltr:ml-0 rtl:mr-0 -mb-8 flex flex-wrap">
                <file-input type="file" accept="image/*" :label="$t('Image') + ' ' + (image_index + 1)" previewUrl='/storage/frontend/' 
                  v-model="form.images[index][image_index].file" :error="errors['sub_image.' + index]" class="ltr:pr-6 rtl:pl-6 pb-8 w-full lg:w-full" />
              </div>
              <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
                <button type="button" @click="() => addGalleryImage(index)"
                  class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                    stroke="currentColor" class="w-6 h-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                  </svg>
                </button>
                <button type="button" @click="() => removeGalleryImage(index)"
                  class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                    stroke="currentColor" class="w-6 h-6">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                  </svg>
                </button>
              </div>
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addGalleryItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeGalleryItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('subscribe')">
            {{ $tc('Subscribe Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'subscribe' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'subscribe'" class="pt-2 pb-5">
            <file-input type="file" accept="image/*" :label="$t('Image')" previewUrl='/storage/frontend/'
              v-model="form.subscribe.image" :error="errors['subscribe.image']" class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
            <textarea-input v-model="form.subscribe.description" class="ltr:pr-6 rtl:pl-6 w-full mt-5"
              :label="$t('Description')" :error="errors['subscribe.description']" />
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('faq')">
            {{ $tc('FAQ Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'faq' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'faq'">
            <div v-for="(item, index) in form.faq" :key="index" class="py-5" :class="index !== 0 ? 'border-t' : ''">
              <div class="mb-3 font-bold">
                {{ $tc('FAQ') + ' ' + (index + 1) }}
              </div>
              <text-input v-model="item.title" class="ltr:pr-6 rtl:pl-6 w-full" :label="$t('Title')"
                :errors="errors['faq.' + index + '.title']" />
              <textarea-input v-model="item.description" :rows="3" class="ltr:pr-6 rtl:pl-6 w-full mt-5"
                :label="$t('Description')" :error="errors['faq.' + index + '.description']" />
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addFAQItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeFAQItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('instagram')">
            {{ $tc('Instagram Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'instagram' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'instagram'">
            <div v-for="(item, index) in form.instagram" :key="index" class="py-5" :class="index !== 0 ? 'border-t' : ''">
              <file-input type="file" accept="image/*" :label="$t('Image')" previewUrl='/storage/frontend/'
                v-model="item.image" :error="errors['instagram.' + index + '.image']"
                class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addInstagramItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeInstagramItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
          </div>
        </div>
        <div class="my-5 font-bold text-gray-500">{{$t('about_us')}}</div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('story')">
            {{ $tc('Story Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'story' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'story'" class="pt-2 pb-5">
            <file-input type="file" accept="image/*" :label="$t('Image')" previewUrl='/storage/frontend/'
              v-model="form.story.image" :error="errors['story.image']" class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
            <textarea-input v-model="form.story.description" class="ltr:pr-6 rtl:pl-6 w-full mt-5"
              :label="$t('Description')" :error="errors['story.description']" />
          </div>
        </div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('about_service')">
            {{ $tc('Service Content Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'about_service' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'about_service'" class="pt-2 pb-5">
            <textarea-input v-model="form.about_service.description" class="ltr:pr-6 rtl:pl-6 w-full mt-5"
              :label="$t('Description')" :error="errors['about_service.description']" />
            <div v-for="(item, index) in form.about_service.list" :key="index" class="py-5"
              :class="index !== 0 ? 'border-t' : ''">
              <div class="mb-3 font-bold">
                {{ $tc('Service') + ' ' + (index + 1) }}
              </div>
              <text-input v-model="item.title" class="ltr:pr-6 rtl:pl-6 w-full" :label="$t('Title')"
                :errors="errors['about_service.list.' + index + '.title']" />
              <file-input type="file" accept="image/*" :label="$t('Icon')" previewUrl='/storage/frontend/'
                v-model="item.icon" :error="errors['about_service.list.' + index + '.icon']"
                class="ltr:pr-6 rtl:pl-6 w-full mt-3" />
              <textarea-input v-model="item.description" :rows="3" class="ltr:pr-6 rtl:pl-6 w-full mt-5"
                :label="$t('Description')" :error="errors['about_service.list.' + index + '.description']" />
            </div>
            <div class="w-full flex items-center justify-end mt-5 mb-6 gap-4 ltr:pr-6 rtl:pl-6">
              <button type="button" @click="addAboutServiceItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
              </button>
              <button type="button" @click="removeAboutServiceItem"
                class="bg-gray-700 px-3 py-1.5 rounded-md text-gray-50 hover:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                  stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
                </svg>
              </button>
            </div>
          </div>
        </div>
        <div class="my-5 font-bold text-gray-500">{{$t('Footer')}}</div>
        <div class="w-full">
          <div
            class="ltr:mr-6 rtl:ml-6 mb-3 bg-white font-bold text-lg border rounded-md p-3 cursor-pointer flex justify-between items-center hover:border-gray-400"
            @click="setSection('footer')">
            {{ $tc('Footer Section') }}
            <Icons name="chevron-down"
              :class="`w-5 h-5 ${currentSection === 'footer' ? 'rotate-180' : ''} transition-all`" />
          </div>
          <div v-if="currentSection === 'footer'" class="pt-2 pb-5">
            <text-input v-model="form.footer.text" class="ltr:pr-6 rtl:pl-6 w-full mt-3" :label="$t('Footer Text')"
              :errors="errors['footer.text']" />
            <text-input v-model="form.footer.facebook" class="ltr:pr-6 rtl:pl-6 w-full mt-3" :label="$t('Facebook Link')"
              :errors="errors['footer.facebook']" />
            <text-input v-model="form.footer.instagram" class="ltr:pr-6 rtl:pl-6 w-full mt-3"
              :label="$t('Instagram Link')" :errors="errors['footer.instagram']" />
            <text-input v-model="form.footer.twitter" class="ltr:pr-6 rtl:pl-6 w-full mt-3" :label="$t('Twitter Link')"
              :errors="errors['footer.twitter']" />
          </div>
        </div>
        <div class="my-5 font-bold text-gray-500">{{$tc('terms_condition')}}</div>
        <div class="w-full ltr:mr-6 rtl:ml-6">
          <ckeditor :editor="editor" v-model="editorData" :config="editorConfig"></ckeditor>
        </div>
      </div>
      <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
        <loading-button :loading="sending" class="btn-gray ltr:ml-auto rtl:mr-auto" type="submit">
          {{ $t('update_x', { x: $tc('Setting', 2) }) }}
        </loading-button>
      </div>
    </form>
  </div>
</template>
<script>
import CKEditor from "@ckeditor/ckeditor5-vue"
import TextInput from '@/Shared/TextInput.vue';
import FileInput from '@/Shared/FileInput.vue';
import LoadingButton from '@/Shared/LoadingButton.vue';
import TextareaInput from '@/Shared/TextareaInput.vue';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';

export default {
  components: { TextInput, FileInput, LoadingButton, TextareaInput, ckeditor: CKEditor.component },
  props: { frontend_setting: Object },
  data() {
    return {
      currentSection: '',
      errors: {},
      sending: false,
      form: {
        images: [],
        slides: JSON.parse(this.frontend_setting?.slides ?? 'null') ?? [
          {
            main_title: '',
            sub_title: '',
            description: '',
            main_image: '',
            sub_image: '',
            name: '',
            url: ''
          },
          {
            main_title: '',
            sub_title: '',
            description: '',
            main_image: '',
            sub_image: '',
            name: '',
            url: ''
          }
        ],
        galleries: JSON.parse(this.frontend_setting?.galleries ?? 'null') ?? [
          {
            main_title: '',
            sub_title: '',
            images: []
          },
          {
            main_title: '',
            sub_title: '',            
            images: []
          }
        ],
        limiteds: JSON.parse(this.frontend_setting?.limited ?? 'null') ?? [
          {
            image: '',
            description: '',
            name: '',
            url: ''
          },
          {
            image: '',
            description: '',
            name: '',
            url: ''
          }
        ],
        discount: JSON.parse(this.frontend_setting?.discount ?? 'null') ?? {
          title: '',
          description: '',
          image1: '',
          image2: '',
          image3: '',
        },
        embrace: JSON.parse(this.frontend_setting?.embrace ?? 'null') ?? {
          image: '',
          description: ''
        },
        testimonial: JSON.parse(this.frontend_setting?.testimonial ?? 'null') ?? [
          {
            name: '',
            position: '',
            photo: '',
            description: '',
          },
          {
            name: '',
            position: '',
            photo: '',
            description: '',
          },
        ],
        service: JSON.parse(this.frontend_setting?.service ?? 'null') ?? [
          {
            title: '',
            icon: '',
            description: '',
          },
          {
            title: '',
            icon: '',
            description: '',
          },
        ],
        subscribe: JSON.parse(this.frontend_setting?.subscribe ?? 'null') ?? {
          image: '',
          description: ''
        },
        faq: JSON.parse(this.frontend_setting?.faq ?? 'null') ?? [
          {
            title: '',
            description: '',
          },
          {
            title: '',
            description: '',
          },
        ],
        instagram: JSON.parse(this.frontend_setting?.instagram ?? 'null') ?? [
          { image: '' },
          { image: '' },
        ],
        story: JSON.parse(this.frontend_setting?.story ?? 'null') ?? {
          image: '',
          description: ''
        },
        about_service: JSON.parse(this.frontend_setting?.about_service ?? 'null') ?? {
          description: '',
          list: [
            {
              title: '',
              icon: '',
              description: '',
            },
            {
              title: '',
              icon: '',
              description: '',
            },
          ]
        },
        footer: JSON.parse(this.frontend_setting?.footer ?? 'null') ?? {
          text: '',
          facebook: '',
          instagram: '',
          twitter: ''
        },
      },
      editor: ClassicEditor,
      editorData: this.frontend_setting?.terms ?? ''
    }
  },
  mounted() {
    this.form.galleries.map((item, index) => {
      var images = [];
      item.images.map((image, img_index) => {
        console.log(image);
        images.push({file : image});
      });
      this.form.images.push(images);
    });
    console.log(this.form.images);
  },
  methods: {
    addSlideItem() {
      this.form.slides.push({
        main_title: '',
        sub_title: '',
        description: '',
        main_image: '',
        sub_image: '',
        name: '',
        url: ''
      });
    },
    removeSlideItem() {
      this.form.slides.pop();
    },
    addLimitedItem() {
      this.form.limiteds.push({
        image: '',
        description: '',
        name: '',
        url: ''
      });
    },
    removeLimitedItem() {
      this.form.limiteds.pop();
    },
    addGalleryItem() {
      this.form.galleries.push({
        main_title: '',
        sub_title: '',
        image: '',
      });
    },
    removeGalleryItem() {
      this.form.galleries.pop();
    },
    addGalleryImage(index) {
      this.form.images[index].push({
        file: ''
      });
      // this.form.galleries[index].images.push('');
    },
    removeGalleryImage(index) {
      this.form.images[index].pop();
    },
    addTestimonialItem() {
      this.form.testimonial.push({
        name: '',
        position: '',
        photo: '',
        description: '',
      });
    },
    removeTestimonialItem() {
      this.form.testimonial.pop();
    },
    addServiceItem() {
      this.form.service.push({
        title: '',
        icon: '',
        description: '',
      });
    },
    removeServiceItem() {
      this.form.service.pop();
    },
    addFAQItem() {
      this.form.faq.push({
        title: '',
        description: '',
      });
    },
    removeFAQItem() {
      this.form.faq.pop();
    },
    addInstagramItem() {
      this.form.instagram.push({
        image: '',
      });
    },
    removeInstagramItem() {
      this.form.instagram.pop();
    },
    addAboutServiceItem() {
      this.form.about_service.list.push({
        title: '',
        icon: '',
        description: '',
      });
    },
    removeAboutServiceItem() {
      this.form.about_service.list.pop();
    },
    submitForm() {
      this.sending = true;
      this.errors = {};
      const data = new FormData();
      this.form.slides.forEach((slide, index) => {
        for (let key in slide) {
          data.append(`slides[${index}][${key}]`, slide[key] || '')
        }
      });
      // this.form.images.forEach((image, index) => {        
      //   this.form.galleries[index].images = image;
      //   console.log(this.form.galleries[index].images);
      // });
      // this.form.sub_photos.forEach((item, index) => {
      //   data.append(`sub_photos[${index}]`, item.file || '')
      // });
      this.form.images.forEach((images, index) => {
        images.forEach((image, img_index) => {
          data.append(`gallery_images[${index}][${img_index}]`, image.file || '');
        });
      });
      this.form.galleries.forEach((gallery, index) => {
        for (let key in gallery) {
          data.append(`galleries[${index}][${key}]`, gallery[key] || '')
        }
      });
      this.form.testimonial.forEach((testimonial, index) => {
        for (let key in testimonial) {
          data.append(`testimonial[${index}][${key}]`, testimonial[key] || '')
        }
      });
      this.form.service.forEach((service, index) => {
        for (let key in service) {
          data.append(`service[${index}][${key}]`, service[key] || '')
        }
      });
      this.form.faq.forEach((faq, index) => {
        for (let key in faq) {
          data.append(`faq[${index}][${key}]`, faq[key] || '')
        }
      });
      this.form.instagram.forEach((instagram, index) => {
        for (let key in instagram) {
          data.append(`instagram[${index}][${key}]`, instagram[key] || '')
        }
      });
      this.form.about_service.list.forEach((item, index) => {
        for (let key in item) {
          data.append(`about_service[list][${index}][${key}]`, item[key] || '')
        }
      });
      this.form.limiteds.forEach((limited, index) => {
        for (let key in limited) {
          data.append(`limiteds[${index}][${key}]`, limited[key] || '')
        }
      });
      // for (let key in this.form.limited) {
      //   data.append(`limited[${key}]`, this.form.limited[key] || '')
      // }
      for (let key in this.form.discount) {
        data.append(`discount[${key}]`, this.form.discount[key] || '')
      }
      for (let key in this.form.embrace) {
        data.append(`embrace[${key}]`, this.form.embrace[key] || '')
      }
      for (let key in this.form.subscribe) {
        data.append(`subscribe[${key}]`, this.form.subscribe[key] || '')
      }
      for (let key in this.form.story) {
        data.append(`story[${key}]`, this.form.story[key] || '')
      }
      data.append('about_service[description]', this.form.about_service.description || '')
      for (let key in this.form.footer) {
        data.append(`footer[${key}]`, this.form.footer[key] || '')
      }
      data.append('terms', this.editorData);

      this.$inertia.post(this.route('settings.frontend.save'), data, {
        onError: (response) => {
          this.errors = response
          this.sending = false
          console.log(this.errors);
        },
        onFinish: () => {
          this.sending = false
        },
      });
    },
    setSection(s) {
      if (this.currentSection === s) {
        this.currentSection = ''
      } else {
        this.currentSection = s
      }
    }
  }
}
</script>
<style>
.ck.ck-content {
  min-height: 240px;
}
</style>