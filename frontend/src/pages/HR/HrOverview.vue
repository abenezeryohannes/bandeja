<template>
  <section class="content" v-if="!loading">
    <div class="col-sm-8" >
      <h5 style="text-align: center; font-weight: bolder;">Attendance</h5>
      <apexchart  type="bar" height="300" :options="charts.attendance.chartOptions" :series="charts.attendance.series"></apexchart>

    </div>
    <div class="col-sm-4" >
      <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="info-box">
          <span class="info-box-icon bg-aqua"><i class="ion ion-person-add"></i></span>
          <div class="info-box-content">
            <span class="info-box-text">Total Employees</span>
            <span class="info-box-number">{{ stats.members }}</span>
          </div>
        </div>
        <div class="col-sm-12" >
          <h5 style="text-align: center; font-weight: bolder;">Male to Female Ratio</h5>
          <apexchart type="pie" height="300"  :options="charts.sex.chartOptions" :series="charts.sex.series"></apexchart>
        </div>
      </div>


      <div class="col-md-4 col-sm-6 col-xs-12" v-if="stats.groups">
        <div class="info-box">
          <span class="info-box-icon bg-aqua"><i class="fa fa-users"></i></span>
          <div class="info-box-content">
            <span class="info-box-text">Total Groups</span>
            <span class="info-box-number">{{ stats.groups }}</span>
          </div>
        </div>
      </div>
    </div>





  </section>
</template>

<script>
export default {


  props: [
  
  ],

  data() {
    return {

      loading: true,

      stats: {
        members: null,
        groups: null,
      },

      charts: {
        attendance : {
          chartOptions: {
            chart: {
              id: 'vuechart-example'
            },
            xaxis: {
              categories: ['11-09-2020', '12-09-2020', '13-09-2020', '14-09-2020', '15-09-2020', '16-09-2020', '17-09-2020' ]
            }
          },
          series: [{
            name: 'Present',
            data: [30, 40, 35, 50, 49, 60, 70]
          }, {
            name: 'absent',
            data: [70, 60, 65, 50, 51, 40, 30]
          }],
        },
        sex: {
          series: [44, 55],
          chartOptions: {
            chart: {
              width: 380,
              type: 'pie',
            },
            labels: ['Team A', 'Team B'],
            responsive: [{
              breakpoint: 480,
              options: {
                chart: {
                  width: 200
                },
                legend: {
                  position: 'bottom'
                }
              }
            }]
          },
        }
      },

      api: '/api/hr/overview',
    }
  },


  watch: {
    // nice: 'load_data'
  },

  mounted() {
    this.load_data()
  },

  updated(){
    // this.load_data()
  },

  methods: {

    load_data() {
      this.loading = true
      this.$axios
          .get(this.api)
          .then(response => {
            this.charts.sex.series = response.data.data.sex_chart.values
            this.charts.sex.chartOptions.labels = response.data.data.sex_chart.labels

            // this.charts.group.chartOptions.xaxis.categories = response.data.data.group_chart.labels
            // this.charts.group.series[0].data = response.data.data.group_chart.values

            this.stats.members = response.data.data.stats.employees

            this.loading = false
          })
          .catch(error => {
            this.errored = true
          })
      // .finally(() => this.loading = false)
    },

  }


}
</script>
