<template>
  <div>
    <div class="flex overflow-x-auto scroll-on-light pb-2">
      <div
        class="w-full max-w-xs md:max-w-md lg:w-1/4 min-w-225 flex text-white fill-white items-center bg-green-to-teal rounded shadow p-4 ltr:mr-6 rtl:ml-6"
      >
        <span class="flex items-center justify-center h-12 w-12 rounded-full shadow bg-mono-circle ltr:mr-4 rtl:ml-4">
          <Icons name="store-front" class="w-6 h-6 fill-green-700" />
        </span>
        <div>
          <h1 class="text-2xl">
            {{ $shortNumber(data.order.total_amount) }}
            <span class="text-sm"> {{ $shortNumber(data.order.total_count) }} {{ $tc('Order', data.order.total_count) }}</span>
          </h1>
          <p class="text-xs mt-2">{{ data.start }} - {{ data.end }}</p>
        </div>
      </div>
      <div
        class="w-full max-w-xs md:max-w-md lg:w-1/4 min-w-225 flex text-white fill-white items-center bg-blue-to-purple rounded shadow p-4 ltr:mr-6 rtl:ml-6"
      >
        <span class="flex items-center justify-center h-12 w-12 rounded-full shadow bg-mono-circle ltr:mr-4 rtl:ml-4">
          <Icons name="salary" class="w-6 h-6 fill-blue-700" />
        </span>
        <div>
          <h1 class="text-2xl">
            {{ $shortNumber(data.salary.total_amount) }}
            <span class="text-sm"> {{ $shortNumber(data.salary.total_count) }} {{ $tc('Salary', data.salary.total_count) }}</span>
          </h1>
          <p class="text-xs mt-2">{{ data.start }} - {{ data.end }}</p>
        </div>
      </div>
      <div
        class="w-full max-w-xs md:max-w-md lg:w-1/4 min-w-225 flex text-white fill-white items-center bg-red-to-orange rounded shadow p-4 ltr:mr-6 rtl:ml-6"
      >
        <span class="flex items-center justify-center h-12 w-12 rounded-full shadow bg-mono-circle ltr:mr-4 rtl:ml-4">
          <Icons name="expense" class="w-6 h-6 fill-orange-700" />
        </span>
        <div>
          <h1 class="text-2xl">
            {{ $shortNumber(data.expense.total_amount) }}
            <span class="text-sm"> {{ $shortNumber(data.expense.total_count) }} {{ $tc('Expense', data.expense.total_count) }}</span>
          </h1>
          <p class="text-xs mt-2">{{ data.start }} - {{ data.end }}</p>
        </div>
      </div>
      <div
        class="w-full max-w-xs md:max-w-md lg:w-1/4 min-w-225 flex text-white fill-white items-center bg-blue-to-teal rounded shadow p-4"
      >
        <span class="flex items-center justify-center h-12 w-12 rounded-full shadow bg-mono-circle ltr:mr-4 rtl:ml-4">
          <Icons name="customer" class="w-6 h-6 fill-blue-700" />
        </span>
        <div>
          <h1 class="text-2xl">
            {{ $shortNumber(data.customers) }}
            <span class="text-sm">
              {{ $t('new_x', { x: $tc('Customer', data.customers) }) }}
            </span>
          </h1>
          <p class="text-xs mt-2">{{ data.start }} - {{ data.end }}</p>
        </div>
      </div>
    </div>

    <div class="w-full flex flex-wrap items-center mt-4">
      <div id="month" class="w-full lg:w-1/2">
        <div class="bg-month-chart rounded shadow py-4 px-6 mb-6 lg:mb-0 ltr:mr-0 lg:ltr:mr-3 rtl:ml-0 lg:rtl:ml-3">
          <div class="font-extrabold mb-6 -my-4 -mx-6 py-4 px-6 border-b border-gray-900 flex items-center">
            <div class="flex-1 text-lg text-gray-300">{{ $t('Month Overview Chart') }}</div>
            <div class="inline-block relative text-gray-400">
              <select
                v-model="month"
                class="block rounded-md border-0 bg-transparent py-1 pl-2 pr-8 -mr-4 text-base focus:border-indigo-500 focus:outline-none focus:ring-indigo-500"
              >
                <option v-for="m in months" :value="m" :key="m">{{ m }}</option>
              </select>
            </div>
          </div>
          <div class="pb-2 overflow-x-auto scroll-on-dark">
            <div id="daily" class="min-w-600">
              <highcharts :options="monthChartOptions"></highcharts>
            </div>
          </div>
        </div>
      </div>
      <div id="year" class="w-full lg:w-1/2">
        <div class="bg-year-chart rounded shadow py-4 px-6 ltr:ml-0 lg:ltr:ml-3 rtl:mr-0 lg:rtl:mr-3">
          <div class="font-extrabold mb-6 -my-4 -mx-6 py-4 px-6 border-b border-blue-900 flex items-center">
            <div class="flex-1 text-lg text-gray-300">{{ $t('Year Overview Chart') }}</div>
            <div class="inline-block relative text-gray-400">
              <select
                v-model="year"
                class="block rounded-md border-0 bg-transparent py-1 pl-2 pr-8 -mr-4 text-base focus:border-indigo-500 focus:outline-none focus:ring-indigo-500"
              >
                <option v-for="y in years" :value="y" :key="y">{{ y }}</option>
              </select>
            </div>
          </div>
          <div class="pb-2 overflow-x-auto scroll-on-dark">
            <div id="monthly" class="min-w-600">
              <highcharts :options="yearChartOptions"></highcharts>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="w-full flex flex-wrap items-stretch my-6">
      <div id="no" class="w-full lg:w-1/2">
        <div class="bg-green-to-teal rounded shadow py-4 px-6 mb-6 lg:mb-0 ltr:mr-0 lg:ltr:mr-3 rtl:ml-0 lg:rtl:ml-3">
          <div class="font-extrabold text-white fill-white mb-6 -my-4 -mx-6 py-4 px-6 border-b border-o2 text-lg">
            {{ $t('Today Orders') }}
          </div>
          <div class="pb-4 overflow-auto scroll-on-dark">
            <div v-if="new_today.length === 0" class="text-white fill-white">
              {{ $t('No new order today') }}
            </div>
            <div v-else id="new" class="min-w-600" style="max-height: 350px">
              <table class="w-full text-white fill-white whitespace-no-wrap">
                <thead>
                  <tr class="text-left font-bold">
                    <th class="px-3 pb-2">{{ $tc('Order') }}</th>
                    <th class="px-3 pb-2">{{ $tc('Customer') }}</th>
                    <th class="px-3 pb-2">{{ $tc('Delivery') }}</th>
                    <th class="px-3 pb-2">{{ $t('Status') }}</th>
                    <th class="px-3 pb-2">{{ $t('Grand Total') }}</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- @click="rowClicked(order.id)" class="cursor-pointer" -->
                  <tr :key="order.id" v-for="order in new_today">
                    <td class="border-t border-o2 px-3 py-2 leading-normal">
                      <div>{{ order.id }}: {{ $reference(order.reference) }}</div>
                      <div v-if="order.user">by {{ order.user.name }}</div>
                    </td>
                    <td class="border-t border-o2 px-3 py-2 leading-normal">
                      <div v-if="order.customer">
                        {{ order.customer.name }}
                        <div>{{ order.customer.phone }}</div>
                      </div>
                    </td>
                    <td class="border-t border-o2 px-3 py-2 leading-normal">
                      <div v-if="order.assigned_to">
                        {{ order.assigned_to.name }}
                      </div>
                      <div>{{ order.delivery_date }}</div>
                    </td>
                    <td class="border-t border-o2 px-3 py-2 text-center">
                      <div>{{ order.status }}</div>
                      <div v-if="order.priority" v-html="PriorityCol(order.priority)"></div>
                    </td>
                    <td class="border-t border-o2 text-right font-bold px-3 py-2">
                      <div class="inline-flex">
                        <Icons v-if="order.paid" name="check" class="flex-shrink-0 w-3 h-3 text-white fill-white ltr:mr-2 rtl:ml-2" />
                        {{ order.grand_total }}
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
      <div id="do" class="w-full lg:w-1/2">
        <div class="bg-red-to-orange rounded shadow py-4 px-6 mb-6 lg:mb-0 ltr:ml-0 lg:ltr:ml-3 rtl:mr-0 lg:rtl:mr-3">
          <div class="font-extrabold text-white fill-white mb-6 -my-4 -mx-6 py-4 px-6 border-b border-o2 text-lg">
            {{ $t('Today Deliveries') }}
          </div>
          <div class="pb-4 overflow-x-auto scroll-on-dark">
            <div v-if="due_today.length === 0" class="text-white fill-white">
              {{ $t('No order delivery today') }}
            </div>
            <div v-else id="due" class="min-w-600" style="max-height: 350px">
              <table class="w-full text-white fill-white whitespace-no-wrap">
                <thead>
                  <tr class="text-left font-bold">
                    <th class="px-3 pb-2">{{ $tc('Order') }}</th>
                    <th class="px-3 pb-2">{{ $tc('Customer') }}</th>
                    <th class="px-3 pb-2">{{ $tc('Delivery') }}</th>
                    <th class="px-3 pb-2">{{ $t('Status') }}</th>
                    <th class="px-3 pb-2">{{ $t('Grand Total') }}</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- @click="rowClicked(order.id)" class="cursor-pointer" -->
                  <tr :key="order.id" v-for="order in due_today">
                    <td class="border-t border-o2 px-3 py-2 leading-normal">
                      <div>{{ order.id }}: {{ $reference(order.reference) }}</div>
                      <div v-if="order.user">by {{ order.user.name }}</div>
                    </td>
                    <td class="border-t border-o2 px-3 py-2 leading-normal">
                      <div v-if="order.customer">
                        {{ order.customer.name }}
                        <div>{{ order.customer.phone }}</div>
                      </div>
                    </td>
                    <td class="border-t border-o2 px-3 py-2 leading-normal">
                      <div v-if="order.assigned_to">
                        {{ order.assigned_to.name }}
                      </div>
                      <div>{{ $date(order.delivery_date) }}</div>
                    </td>
                    <td class="border-t border-o2 px-3 py-2 text-center">
                      <div>{{ order.status }}</div>
                      <div v-if="order.priority" v-html="PriorityCol(order.priority)"></div>
                    </td>
                    <td class="border-t border-o2 text-right font-bold px-3 py-2">
                      <div class="inline-flex">
                        <Icons v-if="order.paid" name="check" class="flex-shrink-0 w-3 h-3 text-white fill-white ltr:mr-2 rtl:ml-2" />
                        {{ order.grand_total }}
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Icon from '@/Shared/Icon.vue';
import { Chart } from 'highcharts-vue';
import Layout from '@/Shared/Layout.vue';
import AutoComplete from '@/Shared/AutoComplete.vue';

export default {
  layout: Layout,
  metaInfo: { title: 'Dashboard' },
  components: { Icon, highcharts: Chart, AutoComplete },
  props: { data: Object, chart: Object, due_today: Array, new_today: Array },
  data() {
    return {
      year: new Date().getFullYear(),
      month: new Date().getMonth(),
      months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      monthChartOptions: {},
      yearChartOptions: {},
      chartOptions: {
        title: { text: '' },
        credits: { enabled: false },
        xAxis: {
          crosshair: true,
          categories: this.months,
          lineColor: 'rgba(0, 0, 0, 0.1)',
          gridLineColor: 'rgba(0, 0, 0, 0.1)',
          minorGridLineColor: 'rgba(0, 0, 0, 0.1)',
          labels: { style: { color: 'rgba(255, 255, 255, 0.75)' } },
        },
        yAxis: {
          min: 0,
          title: { text: '' },
          gridLineColor: 'rgba(0, 0, 0, 0.1)',
          labels: { style: { color: 'rgba(255, 255, 255, 0.75)' } },
        },
        legend: {
          itemStyle: { color: '#E0E0E3' },
          itemHoverStyle: { color: '#FFF' },
          itemHiddenStyle: { color: '#606063' },
          title: { style: { color: '#C0C0C0' } },
        },
        chart: { type: 'column', backgroundColor: 'rgba(0,0,0,0)' },
        series: [
          { name: 'Order', data: [] },
          { name: 'Salarie', data: [] },
          { name: 'Expense', data: [] },
        ],
        colors: ['#38A169', '#805AD5', '#DD6B20', '#718096', '#5A67D8', '#2db7f5', '#515a6e', '#2b908f', '#f45b5b', '#91e8e1'],
        plotOptions: {
          column: { pointPadding: 0.2, borderWidth: 0 },
        },
        tooltip: {
          headerFormat: '<span style="font-weight:900;">{point.key}</span><table>',
          footerFormat: '</table>',
          shared: true,
          useHTML: true,
          hideDelay: 0,
          shadow: false,
          borderWidth: 0,
          borderRadius: 10,
          followPointer: true,
          backgroundColor: 'rgba(0, 0, 0, 0.85)',
          style: { color: '#F0F0F0', width: 'auto', maxWidth: '250px' },
        },
      },
    };
  },
  computed: {
    years() {
      let years = [];
      let date = new Date();
      let year = date.getFullYear();
      for (let y = 2019; y <= year; y++) {
        years.push(y);
      }
      return years;
    },
  },
  watch: {
    month: function (m) {
      let month = 0;
      this.months.map((mn, mi) => (mn == m ? (month = mi + 1) : mn));
      this.$axios
        .get(`/admin/chart/month?month=${month}&year=${this.year}`)
        .then(res => this.setMonthChart(res.data.chart.month))
        .catch(err => console.log(err));
    },
    year: function (y) {
      this.$axios
        .get('/admin/chart/year?year=' + y)
        .then(res => {
          this.setYearChart(res.data.chart.year);
          this.setMonthChart(res.data.chart.month);
        })
        .catch(err => console.log(err));
    },
  },
  mounted() {
    this.month = this.months[new Date().getMonth()];
    this.yearChartOptions = JSON.parse(JSON.stringify(this.chartOptions));
    this.monthChartOptions = JSON.parse(JSON.stringify(this.chartOptions));
    this.setYearChart(this.chart.year);
    this.setMonthChart(this.chart.month);
  },
  methods: {
    PriorityCol(p) {
      if (p == 1) {
        return '<div class="text-gray-200 mt-1">Normal</div>';
      } else if (p == 2) {
        return '<div class="text-orange-200 mt-1">High</div>';
      } else if (p == 3) {
        return '<div class="text-red-200 mt-1">Urgent</div>';
      }
    },
    setYearChart(chart) {
      let series = [];
      for (let m in chart) {
        let elem = { name: m, data: [] };
        let data = { ...chart[m] };
        Object.keys(data)
          .sort(function (a, b) {
            return new Date('' + a + '-01') - new Date('' + b + '-01');
          })
          .map((k, i) => {
            elem.data[i] = data[k];
          });
        series.push(elem);
      }
      
      var vm = this;
      var tc = x => this.$tc(x, 2);
      this.yearChartOptions.series = series;
      this.yearChartOptions.legend.labelFormatter = function () {
        return tc(this.name.charAt(0).toUpperCase() + this.name.substring(1));
      };
      this.yearChartOptions.xAxis.categories = this.months;
      this.yearChartOptions.tooltip.pointFormatter = function (tooltip) {
        this.y = vm.$number(this.y);
        return `<tr><td style="color:${this.series.color};padding:0;font-weight:bold;">${tc(
          vm.$capitalize(this.series.name)
        )}: &nbsp;&nbsp;</td><td style="color:${this.series.color};padding:0;text-align:right"><b>${this.y}</b></td></tr>`;
      };
    },
    setMonthChart(chart) {
      let series = [];
      let categories = [];
      for (let m in chart) {
        let data = { ...chart[m] };
        let elem = { name: m, data: [] };
        Object.keys(data)
          .sort(function (a, b) {
            return new Date(a) - new Date(b);
          })
          .map((k, i) => {
            elem.data[i] = data[k];
          });
        series.push(elem);
      }
      Object.keys(chart.order)
        .sort((a, b) => new Date(a) - new Date(b))
        .map(k => {
          let day = new Date(k).toLocaleString('en-us', { day: 'numeric', weekday: 'short' });
          categories.push(day);
        });
      var vm = this;
      var tc = x => this.$tc(x, 2);
      this.monthChartOptions.series = series;
      this.monthChartOptions.legend.labelFormatter = function () {
        return tc(this.name.charAt(0).toUpperCase() + this.name.substring(1));
      };
      this.monthChartOptions.chart.type = 'line';
      this.monthChartOptions.xAxis.categories = categories;
      this.monthChartOptions.tooltip.pointFormatter = function (tooltip) {
        this.y = vm.$number(this.y);
        return `<tr><td style="color:${this.series.color};padding:0;font-weight:bold;">${tc(
          vm.$capitalize(this.series.name)
        )}: &nbsp;&nbsp;</td><td style="color:${this.series.color};padding:0;text-align:right"><b>${this.y}</b></td></tr>`;
      };
    },
  },
};
</script>
